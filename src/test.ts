import { Humanize } from "./lib/BufImage"
import * as fs from 'fs';
import {
  fromBinary,
  createFileRegistry,
  type DescMessage,
  create,
  mergeFromBinary
} from "@bufbuild/protobuf";
import { FileDescriptorSetSchema } from "@bufbuild/protobuf/wkt";
import { base64Decode } from "@bufbuild/protobuf/wire";


const data = fs.readFileSync('./src/image.pbin');
const fileDescriptorSet = fromBinary(
    FileDescriptorSetSchema,
    data
  );

// let response = fs.readFileSync("./src/out.pbin")
let response = fs.readFileSync("./src/output.pbin")
console.log(response)
let decodedResponse = base64Decode(response.toString())
console.log(decodedResponse.slice(5, decodedResponse[4]+5))
for (let a of decodedResponse.slice(5, decodedResponse[4]+5)) {
    console.log(a)
}
// console.log(decodedResponse)

  // Create a FileRegistry from the google.protobuf.FileDescriptorSet message:
const registry = createFileRegistry(fileDescriptorSet);
// for (let a of registry) {
//     console.log(a.kind)
// }
// console.log(registry.get("greeter.ComplexObjectResponse"))

// console.dir(bufImage.allTypes, {depth: null})

    Humanize(registry, decodedResponse.slice(5, decodedResponse[4]+5), "http://localhost:8080/greeter.Greeter/SayHello")

