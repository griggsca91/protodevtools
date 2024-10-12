import {
  fromBinary,
  createFileRegistry,
  type FileRegistry
} from "@bufbuild/protobuf";
import { FileDescriptorSetSchema } from "@bufbuild/protobuf/wkt";

let loaded: Boolean = $state(false)
let registries: DevtoolFileRegistry[] = $state([])
let rawRegistry: Uint8Array[] = $state([])

let activeFileRegistry: DevtoolFileRegistry | null = $state(null)

type DevtoolFileRegistry = {
  fileRegistry: FileRegistry
  name: string
}


function addRegistryToDB(fileName: string, rawRegistry: Uint8Array) {
  let openRequest = indexedDB.open("protodevtools", 1);
  openRequest.onsuccess = function () {
    let db = openRequest.result;

    let transaction = db.transaction("fileRegistries", "readwrite"); // (1)

    // get an object store to operate on it
    let fileRegistries = transaction.objectStore("fileRegistries"); // (2)

    let fileRegistry = {
      name: fileName,
      data: rawRegistry
    };

    let request = fileRegistries.add(fileRegistry); // (3)
    request.onsuccess = function () { // (4)
      console.log("Book added to the store", request.result);
    };

    request.onerror = function () {
      console.log("Error", request.error);
    };



  }
  openRequest.onerror = function () {
    console.error("Error", openRequest.error);

  }
  openRequest.onupgradeneeded = function (event) {
    let db = openRequest.result;
    switch (event.oldVersion) { // existing db version
      case 0:
        db.createObjectStore("fileRegistries", { keyPath: "name" })
      // version 0 means that the client had no database
      // perform initialization
      case 1:
      // client had version 1
      // update
    }

  }
}

function loadFileRegistries() {
  let openRequest = indexedDB.open("protodevtools", 1);
  openRequest.onsuccess = function () {
    let db = openRequest.result;

    let transaction = db.transaction("fileRegistries", "readwrite"); // (1)

    // get an object store to operate on it
    let fileRegistries = transaction.objectStore("fileRegistries"); // (2)


    let request = fileRegistries.getAll(); // (3)
    request.onsuccess = function () { // (4)
      console.log("got all file registries", request.result);

      registries = request.result.map((fr) => {

        const fileDescriptorSet = fromBinary(
          FileDescriptorSetSchema,
          fr.data,
        );
        // Create a FileRegistry from the google.protobuf.FileDescriptorSet message:
        const fileRegistry = createFileRegistry(fileDescriptorSet);

        return {
          name: fr.name,
          fileRegistry
        }
      }
      );
    };

    request.onerror = function () {
      console.log("Error", request.error);
    };
  }
  openRequest.onerror = function () {
    console.error("Error", openRequest.error);

  }
  openRequest.onupgradeneeded = function (event) {
    let db = openRequest.result;
    switch (event.oldVersion) { // existing db version
      case 0:
        db.createObjectStore("fileRegistries", { keyPath: "name" })
      // version 0 means that the client had no database
      // perform initialization
      case 1:
      // client had version 1
      // update
    }

  }
}


export default {
  get activeFileRegistry(): DevtoolFileRegistry | null {
    if (localStorage) {
      const registryName = localStorage.getItem("activeFileRegistry")
      const foundRegistry = registries.find(r => r.name == registryName) ?? null
      activeFileRegistry = foundRegistry
    }
    return activeFileRegistry
  },
  setActiveFileRegistry(registryName: string) {
    if (localStorage) {
      localStorage.setItem("activeFileRegistry", registryName)
    }

    const foundRegistry = registries.find(r => r.name == registryName) ?? null

    activeFileRegistry = foundRegistry
  },
  addFileRegistryFromBinary(fileName: string, b: Uint8Array) {
    const fileDescriptorSet = fromBinary(
      FileDescriptorSetSchema,
      b,
    );
    // Create a FileRegistry from the google.protobuf.FileDescriptorSet message:
    const registry = createFileRegistry(fileDescriptorSet);
    console.log("registry", registry)
    addRegistryToDB(fileName, b)
    this.addFileRegistry({
      name: fileName,
      fileRegistry: registry
    })
  },
  addFileRegistry(registry: DevtoolFileRegistry) {
    registries.push(registry)
    this.setActiveFileRegistry(registry.name)
  },
  get fileRegistries(): DevtoolFileRegistry[] {
    console.log("loading registries")
    if (!loaded) {
      loaded = true
      loadFileRegistries()
    }
    return registries
  }
}
