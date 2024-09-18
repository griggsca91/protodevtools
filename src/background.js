import protobuf from "protobufjs"

function parseProtobufData(dataArrayBuffer) {
  console.log(dataArrayBuffer)
  const reader = new protobuf.Reader(dataArrayBuffer);
  const parsedFields = [];

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
          const length = reader.uint32();
          value = reader.bytes(length);
          // Try to interpret bytes as UTF-8 string
          try {
            value = new TextDecoder().decode(value);
          } catch {
            value = Array.from(value);
          }
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
    console.error('Error parsing Protobuf data:', e);
  }

  return parsedFields;
}

chrome.webRequest.onBeforeRequest.addListener(
  function (details) {
    console.log("on before", details.url)
    if (details.requestBody && details.requestBody.raw) {
      const requestData = details.requestBody.raw[0].bytes;
      console.log(string(requestData))
      const parsedRequest = parseProtobufData(requestData);
      console.log('Parsed Request:', parsedRequest);
    }
    return {};
  },
  { urls: ["<all_urls>"] },
  ["requestBody"]
);

chrome.webRequest.onCompleted.addListener(
  function (details) {
    console.log("on completed", details.url)
    // To access response bodies, we'll need to use a workaround
    // such as injecting a content script
  },
  { urls: ["<all_urls>"] }
);


chrome.runtime.onMessage.addListener(function (message, sender, sendResponse) {
  console.log("on messasge", message)
  // const parsedResponse = parseProtobufData(message.data);
  // console.log('Parsed Response:', parsedResponse);
  // After parsing data
  chrome.runtime.sendMessage({
    type: "PARSED_PROTOBUF",
    data: message,
  });
});



