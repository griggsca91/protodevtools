import protobuf from "protobufjs"
import { prettyPrintJson } from 'pretty-print-json';

function parseProtobufData(dataArrayBuffer) {
  const encoder = new TextEncoder();

  const buffer = encoder.encode(dataArrayBuffer)
  console.log(buffer)
  const reader = new protobuf.Reader(buffer);
  const parsedFields = [];
  console.log("reader", reader)

  try {
    while (reader.pos < reader.len) {
      const tag = reader.uint32();
      const fieldNumber = tag >>> 3;
      const wireType = tag & 7;
      let value;

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
  }

  return parsedFields;
}
chrome.devtools.panels.create("MyPanel", null, 'popup.html');


chrome.devtools.network.onRequestFinished.addListener(request => {
  console.log("request", request)
  if (request.request.method == "POST") {
    console.log("request", request.request.postData.text, request.request.postData.text.length)
    var enc = new TextEncoder();
    var buffer = enc.encode(request.request.postData.text)

    const parsedResponse = parseProtobufData(request.request.postData.text.substring(5))
    console.log("parsed response", parsedResponse)
    const html = prettyPrintJson.toHtml(parsedResponse)
    const app = document.getElementById("app")
    app.innerHTML = html
  }
  request.getContent((body) => {
    // console.log("body", body)
    if (request.request && request.request.url) {
      if (request.request.url.includes('localhost:50051')) {
        console.log(request)
        console.log("body", body)
        // const parsedResponse = parseProtobufData(body)
        // console.log("parseed response", parsedResponse)
        chrome.runtime.sendMessage({
          response: body
        });
      }
    }
  });
});

