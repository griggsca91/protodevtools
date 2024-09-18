(function () {
  // Override fetch
  const originalFetch = window.fetch;
  window.fetch = function (...args) {
    console.log("fetch called")
    return originalFetch.apply(this, args).then(async (response) => {
      console.log("fetch send")
      const clonedResponse = response.clone();
      const buffer = await clonedResponse.arrayBuffer();
      const responseData = new Uint8Array(buffer);
      window.postMessage(
        { type: "PROTOBUF_RESPONSE", url: response.url, data: responseData },
        "*"
      );
      return response;
    });
  };

  // Override XHR
  const originalXHR = XMLHttpRequest.prototype.send;
  XMLHttpRequest.prototype.send = function (...args) {
    console.log("originalXHR send")
    this.addEventListener("load", function () {
      console.log("load")
      const arrayBuffer = this.response;
      if (arrayBuffer instanceof ArrayBuffer) {
        const responseData = new Uint8Array(arrayBuffer);
        window.postMessage(
          { type: "PROTOBUF_RESPONSE", url: this.responseURL, data: responseData },
          "*"
        );
      }
    });
    originalXHR.apply(this, args);
  };
})();

// Listen for messages from the content script
window.addEventListener("message", function (event) {
  console.log("window message", event)
  if (event.source !== window) return;
  if (event.data && event.data.type === "PROTOBUF_RESPONSE") {
    chrome.runtime.sendMessage(event.data);
  }
});

