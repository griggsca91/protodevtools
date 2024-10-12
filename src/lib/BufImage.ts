// To parse this data:
//
//   import { Convert, Welcome } from "./file";
//
//   const welcome = Convert.toWelcome(json);
import { type DescMessage, type DescService, type Registry, create, fromBinary } from "@bufbuild/protobuf";
import path from "path-browserify-esm"

export function extractInfoFromURL(rawURL: string) {
  const url = new URL(rawURL)
  const serviceName = path.dirname(url.pathname).replace("/", "")
  const methodName = path.basename(url.pathname)
  return {
    serviceName,
    methodName
  }
}

// GRPC first byte is a compression indictor, the next 4 bytes are the size of the message
export function removeGrpcEncoding(b: Buffer): Buffer {
  const size = b.readUint32BE(1)
  return b.subarray(5, size + 5)
}

export function humanizeRequest(image: Registry, a: Buffer, url: string) {
  const method = getMethod(image, url)
  if (!method) {
    return null
  }
  return Humanize(image, a, method.input)
}

export function humanizeResponse(image: Registry, a: Buffer, url: string) {
  const method = getMethod(image, url)
  if (!method) {
    return null
  }
  return Humanize(image, a, method.output)

}

export function getMethod(image: Registry, url: string) {
  const { serviceName, methodName } = extractInfoFromURL(url)
  console.log(serviceName)
  const service = image.getService(serviceName)
  console.log("service", service)
  const method = service?.methods.find((v) => v.name == methodName)
  return method
}

export function Humanize(image: Registry, a: Buffer, messageDescription: DescMessage) {
  console.log("messageDescription", messageDescription, a)
  a = removeGrpcEncoding(a)

  const message = fromBinary(messageDescription, a)
  console.log(message)
  return message
}
