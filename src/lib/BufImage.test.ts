import { assert, describe, expect, it } from "vitest";
import { removeGrpcEncoding } from "./BufImage";

import { readFileSync } from "node:fs";
import { cwd } from "node:process";
import { base64Decode } from "@bufbuild/protobuf/wire";

describe("removeGrpcEncoding", () => {
  it("works on requests", () => {
    const sayHelloRequestBase64 = readFileSync(
      "./src/lib/testfiles/SayHelloRequest.grpc.txt",
      { encoding: "ascii" },
    );
    const buf = Buffer.from(base64Decode(sayHelloRequestBase64));
    const cleanedBuf = removeGrpcEncoding(buf);
    assert.equal(cleanedBuf.length, 7);
    assert.notEqual(buf, cleanedBuf);
  });
  it("works on responses", () => {
    const sayHelloRequestBase64 = readFileSync(
      "./src/lib/testfiles/SayHelloResponse.grpc.txt",
      { encoding: "ascii" },
    );
    const buf = Buffer.from(base64Decode(sayHelloRequestBase64));
    const cleanedBuf = removeGrpcEncoding(buf);
    assert.equal(cleanedBuf.length, 204);
    assert.notEqual(buf, cleanedBuf);
  });
  it("works on larger than 255 byte responses", () => {
    const sayHelloRequestBase64 = readFileSync(
      "./src/lib/testfiles/SayHelloResponseLarge.grpc.txt",
      { encoding: "ascii" },
    );
    const buf = Buffer.from(base64Decode(sayHelloRequestBase64));
    const cleanedBuf = removeGrpcEncoding(buf);
    assert.equal(cleanedBuf.length, 353);
    assert.notEqual(buf, cleanedBuf);
  });
  it("ignores non-grpc requests", () => {
    const sayHelloRequestBase64 = readFileSync(
      "./src/lib/testfiles/SayHelloRequest.proto.txt",
      { encoding: "ascii" },
    );
    const buf = Buffer.from(base64Decode(sayHelloRequestBase64));
    const cleanedBuf = removeGrpcEncoding(buf);
    assert.equal(cleanedBuf.length, 7);
    assert.equal(buf, cleanedBuf);
  });
});
