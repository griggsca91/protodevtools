import { prettyPrintJson } from 'pretty-print-json';
import { Buffer } from 'buffer'
import JSBI from "jsbi";
import { BufferReader } from "./BufferReader"; // Adjust the path as necessary

function recurse(obj: any, parsedData: any) {
    console.log("recurse", parsedData)
    for (let p of parsedData.parts) {
        console.log("p", p)
        switch (p.type) {
            case 0:
                obj[p.index] = decodeVarintParts(p.value)
                break;
            case 1:
                obj[p.index] = decodeFixed64(p.value)
                break;
            case 2:
                console.log("case 2", p)
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
        console.log("decoded p", p)
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

let requests: string[] = $state([]);

chrome.devtools.network.onRequestFinished.addListener((request: any) => {
    if (!request.request.url.includes('localhost:8080')) {
        return
    }
    console.log("request", request)
    if (request.request.method == "POST") {
        console.log("request", request.request.postData.text, request.request.postData.text.length)
        const reader = Buffer.from(request.request.postData.text);
        const parsedResponse = decodeProto(reader)
        console.log("parsed response", parsedResponse)
        const html = prettyPrintJson.toHtml(parsedResponse)
        requests.push(JSON.stringify(parsedResponse, null, "\t"))
    }
    request.getContent((body: any) => {
        console.log("request", request.request.url)
        console.log("string body", body)
        const parsedResponse = decodeProto(Buffer.from(body, "base64"))
        console.log("parsed response", parsedResponse)
        const recursed = recurse({}, parsedResponse)
        console.log("recursed", recursed)
        console.dir(recursed, { depth: null });

        const html = prettyPrintJson.toHtml(recursed)
        requests.push(JSON.stringify(recursed, null, "\t"))    });
});


export default {
    get requests() { return requests },
}