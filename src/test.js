import protobuf from "protobufjs"
const testDataRaw = '\n\u0005World';

console.log(Buffer.from(testDataRaw).toString('base64'))
var output = ""
for (var i = 0; i < testDataRaw.length; i++) {
  output += testDataRaw[i].charCodeAt(0).toString(2) + " ";
}

console.log("output", output)
const parsedData = parseProtobufData(testDataRaw)
console.log("testData", parsedData)
function parseProtobufData(dataArrayBuffer) {
  const encoder = new TextEncoder();

  const buffer = encoder.encode(dataArrayBuffer)
  console.log(buffer)
  const reader = new protobuf.Reader(buffer);
  const parsedFields = [];
  console.log("reader", reader)

  try {
    while (reader.pos < reader.len) {
      console.log(reader.len)
      console.log(reader.pos)
      const tag = reader.uint32();
      const fieldNumber = tag >>> 3;
      const wireType = tag & 7;
      let value;
      console.log("tag", tag)
      console.log(fieldNumber)
      console.log(wireType)

      switch (wireType) {
        case 0: // Varint
          value = reader.int64().toString();
          break;
        case 1: // 64-bit
          value = reader.fixed64().toString();
          break;
        case 2: // Length-delimited
           value = reader.bytes();
          // Try to interpret bytes as UTF-8 string
          console.log('value before', value)
          try {
            value = new TextDecoder().decode(value);
          } catch {
            value = Array.from(value);
          }
          console.log('value', value)
          break;
        case 5: // 32-bit
          value = reader.fixed32();
          break;
        default:
          reader.skipType(wireType);
          continue;
      }

      parsedFields.push({
        fieldNumber,
        wireType,
        value,
      });
    }
  } catch (e) {
    console.log(parsedFields)
    console.error('Error parsing Protobuf data:', e);
  }

  return parsedFields;
}


