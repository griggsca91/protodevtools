// To parse this data:
//
//   import { Convert, Welcome } from "./file";
//
//   const welcome = Convert.toWelcome(json);
import path from "path"

export type FieldType = "TYPE_FLOAT" | "TYPE_STRING" | "TYPE_ENUM" | "TYPE_MESSAGE"


export type BufImage = {
    allTypes: {
        [index: string]: MessageType;
    };
    file: File[];
}

export type File = {
    name:         string;
    package:      string;
    messageType:  MessageType[];
    service:      Service[];
    options:      FileOptions;
    syntax:       string;
    bufExtension: BufExtension;
}

export type BufExtension = {
    isImport:            boolean;
    isSyntaxUnspecified: boolean;
}

export type MessageType = {
    name:        string;
    field?:      Field[];
    nestedType?: NestedType[];
    enumType?:   EnumType[];
    oneofDecl?:  OneofDecl[];
}

export type EnumType = {
    name:  string;
    value: Value[];
}

export type Value = {
    name:   string;
    number: number;
}

export type Field = {
    name:            string;
    number:          number;
    label:           Label;
    type:            string;
    jsonName:        string;
    typeName?:       string;
    oneofIndex?:     number;
    proto3Optional?: boolean;
}

export type Label = "LABEL_OPTIONAL" | "LABEL_REPEATED";

export type NestedType = {
    name:    string;
    field:   Field[];
    options: NestedTypeOptions;
}

export type NestedTypeOptions = {
    mapEntry: boolean;
}

export type OneofDecl = {
    name: string;
}

export type FileOptions = {
    goPackage: string;
}

export type Service = {
    name:   string;
    method: Method[];
}

export type Method = {
    name:       string;
    inputType:  string;
    outputType: string;
}


export function load(s: string): BufImage {
    const b = JSON.parse(s) as BufImage
    b.allTypes = {}

    for (let file of b.file) {
        console.log(file)
        for (let messageType of file.messageType) {
        console.log(messageType.name, file.package)
            b.allTypes["." + file.package + "." + messageType.name] = messageType
        }
    }

    return b

}

function getMethod(image: BufImage, packageName: string, serviceName: string, methodName: string): Method | undefined {
    for (let file of image.file) {
        if (file.package != packageName) {
            continue
        }
        for (let service of file.service) {
            console.log(service, serviceName)
            if (serviceName != service.name) {
                continue
            }
            for (let method of service.method) {
                console.log(method, methodName)
                if (method.name == methodName) {
                    return method
                }
            }
        }
    }
}

function extractInfoFromURL(rawURL: string) {
    const url = new URL(rawURL)
    const serviceAndPackage = path.dirname(url.pathname).replace("/", "")
    const [packageName, serviceName] = serviceAndPackage.split(".")
    const methodName = path.basename(url.pathname)
    return {
        packageName,
        serviceName, 
        methodName
    }
}

export function Humanize(image: BufImage, a: any, url: string): any {
    const {packageName, serviceName, methodName} = extractInfoFromURL(url)

    const method = getMethod(image, packageName, serviceName, methodName)
    if (!method) {
        return
    }
    console.log("method", method)
    console.log("input", image.allTypes[method.inputType])
    console.log("output", image.allTypes[method.outputType])

    // const type = getType(image, method.inputType)
}