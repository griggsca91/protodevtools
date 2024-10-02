import { prettyPrintJson } from 'pretty-print-json';
import { Buffer } from 'buffer'
import JSBI from "jsbi";
import { BufferReader } from "./BufferReader"; // Adjust the path as necessary
import { base64Decode } from "@bufbuild/protobuf/wire";
import { FileDescriptorSetSchema } from "@bufbuild/protobuf/wkt";
import {
    fromBinary,
    createFileRegistry,
    type DescMessage,
    create,
    mergeFromBinary,
    type FileRegistry
} from "@bufbuild/protobuf";
import { Humanize, humanizeResponse } from './BufImage';

function recurse(obj: any, parsedData: any) {
    for (let p of parsedData.parts) {
        switch (p.type) {
            case 0:
                obj[p.index] = decodeVarintParts(p.value)
                break;
            case 1:
                obj[p.index] = decodeFixed64(p.value)
                break;
            case 2:
                let decoded = decodeProto(p.value)
                if (p.value.length > 0 && decoded.leftOver.length === 0) {
                    obj[p.index] = {}
                    recurse(obj[p.index], decoded)
                } else {
                    obj[p.index] = decodeStringOrBytes(p.value);
                }
                break
            case 5:
                obj[p.index] = decodeFixed32(p.value)
                break

        }
    }

    if (parsedData.leftOver.length > 0) {
        const p = decodeProto(parsedData.leftOver)
        if (p.parts.length > 0) {
            recurse(obj, p)
        }
    }
    return obj

}


function decodeProto(buffer: any) {
    const TYPES = {
        VARINT: 0,
        FIXED64: 1,
        LENDELIM: 2,
        FIXED32: 5
    };


    const reader = new BufferReader(buffer) as any;
    const parts = [];

    reader.trySkipGrpcHeader();

    try {
        while (reader.leftBytes() > 0) {
            reader.checkpoint();

            const byteRange = [reader.offset];
            const indexType = parseInt(reader.readVarInt().toString());
            const type = indexType & 0b111;
            const index = indexType >> 3;

            let value;
            if (type === TYPES.VARINT) {
                value = reader.readVarInt().toString();
            } else if (type === TYPES.LENDELIM) {
                const length = parseInt(reader.readVarInt().toString());
                value = reader.readBuffer(length);
            } else if (type === TYPES.FIXED32) {
                value = reader.readBuffer(4);
            } else if (type === TYPES.FIXED64) {
                value = reader.readBuffer(8);
            } else {
                throw new Error("Unknown type: " + type);
            }
            byteRange.push(reader.offset);

            parts.push({
                byteRange,
                index,
                type,
                value
            });
        }
    } catch (err) {
        console.log(err)
        reader.resetToCheckpoint();
    }

    return {
        parts,
        leftOver: reader.readBuffer(reader.leftBytes())
    };
}

export function decodeStringOrBytes(value: any) {
    if (!value.length) {
        return { type: "string|bytes", value: "" };
    }
    const td = new TextDecoder("utf-8", { fatal: true });
    try {
        return { type: "string", value: td.decode(value) };
    } catch (e) {
        return { type: "bytes", value: value };
    }
}

export function decodeVarintParts(value: any) {
    const result = [];
    const uintVal = JSBI.BigInt(value);
    result.push({ type: "uint", value: uintVal.toString() });

    for (const bits of [8, 16, 32, 64]) {
        const intVal = interpretAsTwosComplement(uintVal, bits);
        if (intVal !== uintVal) {
            result.push({ type: "int" + bits, value: intVal.toString() });
        }
    }

    const signedIntVal = interpretAsSignedType(uintVal);
    if (signedIntVal !== uintVal) {
        result.push({ type: "sint", value: signedIntVal.toString() });
    }

    return result;
}


export function decodeFixed32(value: any) {
    const floatValue = value.readFloatLE(0);
    const intValue = value.readInt32LE(0);
    const uintValue = value.readUInt32LE(0);

    const result = [];

    result.push({ type: "int", value: intValue });

    if (intValue !== uintValue) {
        result.push({ type: "uint", value: uintValue });
    }

    result.push({ type: "float", value: floatValue });

    return result;
}

export function decodeFixed64(value: any) {
    const floatValue = value.readDoubleLE(0);
    const uintValue = JSBI.BigInt("0x" + bufferLeToBeHex(value));
    const intValue = interpretAsTwosComplement(uintValue, 64);

    const result = [];

    result.push({ type: "int", value: intValue.toString() });

    if (intValue !== uintValue) {
        result.push({ type: "uint", value: uintValue.toString() });
    }

    result.push({ type: "double", value: floatValue });

    return result;
}

export function bufferLeToBeHex(buffer: any) {
    let output = "";
    for (const v of buffer) {
        const hex = v.toString(16);
        if (hex.length === 1) {
            output = "0" + hex + output;
        } else {
            output = hex + output;
        }
    }
    return output;
}


export function interpretAsSignedType(n: any) {
    // see https://github.com/protocolbuffers/protobuf/blob/master/src/google/protobuf/wire_format_lite.h#L857-L876
    // however, this is a simpler equivalent formula
    const isEven = JSBI.equal(JSBI.bitwiseAnd(n, JSBI.BigInt(1)), JSBI.BigInt(0));
    if (isEven) {
        return JSBI.divide(n, JSBI.BigInt(2));
    } else {
        return JSBI.multiply(
            JSBI.BigInt(-1),
            JSBI.divide(JSBI.add(n, JSBI.BigInt(1)), JSBI.BigInt(2))
        );
    }
}

export function interpretAsTwosComplement(n: any, bits: any) {
    const isTwosComplement = JSBI.equal(
        JSBI.signedRightShift(n, JSBI.BigInt(bits - 1)),
        JSBI.BigInt(1)
    );
    if (isTwosComplement) {
        return JSBI.subtract(n, JSBI.leftShift(JSBI.BigInt(1), JSBI.BigInt(bits)));
    } else {
        return n;
    }
}

let requests: Request[] = $state([]);

function base64Encode(input: string): string {
    return Buffer.from(input).toString('base64');
}

if (chrome?.devtools?.network?.onRequestFinished?.addListener) {

    chrome.devtools.network.onRequestFinished.addListener((request: any) => {
        console.log("request", request)
        if (request.request.method != "POST") {
            return
        }

        let data: any
        const rawData = base64Encode(request.request.postData.text);
        const text = request.request.postData.text
        if (selectedRegistry) {
            const buffer = Buffer.from(text)
            data = humanizeResponse(selectedRegistry, new Uint8Array(buffer.buffer.slice(5, buffer[4]+5)), request.request.url)
        } else {
            console.log(request.url, request)
            console.log("reqeust base64 encoded text", rawData)
            const reader = Buffer.from(request.request.postData.text);
            console.log(reader.buffer)
            data = recurse({}, decodeProto(reader))
            console.log("request parsed response", data)

        }
        let r: Request = {
            requestTime: new Date(),
            data,
            rawData,
            text,
            url: request.request.url,
            method: 'POST',
        }
        request.getContent((body: any) => {
            console.log("response body", body, r.url)
            if (selectedRegistry) {

                const b = base64Decode(body)
                 r.response = {
                    rawData: body,
                    data: humanizeResponse(selectedRegistry, b.slice(5, b[4]+5), r.url)
                }
            } else {
                const parsedResponse = decodeProto(Buffer.from(body, "base64"))
                const recursed = recurse({}, parsedResponse)
                console.dir(recursed, { depth: null });
                r.response = {
                    data: recursed,
                    rawData: body
                }
            }
            requests.push(r)
        });
    });
}

type Response = {
    data: any
    rawData: any
}


export type Request = {
    requestTime: Date
    data: any
    rawData?: any
    text: string
    url: string
    method: "POST" | "GET"
    response?: Response
}

let selectedRegistry: FileRegistry | null = $state(null)

export default {
    get requests() { return requests },
    addRequest(r: Request) {
        requests.push(r)
    },
    setFileRegistry(a: Uint8Array) {
        // let decodedResponse = base64Decode(a)
        // console.log(decodedResponse)
        const fileDescriptorSet = fromBinary(
            FileDescriptorSetSchema,
            a,
        );
        // Create a FileRegistry from the google.protobuf.FileDescriptorSet message:
        const registry = createFileRegistry(fileDescriptorSet);
        selectedRegistry = registry;

        console.log(registry)
    }
}