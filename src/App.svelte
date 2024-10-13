<script lang="ts">
  import "./app.css";
  import requests, { type Request } from "./lib/requests.svelte";
  import fileRegistry from "./lib/fileRegistry.svelte";
  import { JsonView } from "@zerodevx/svelte-json-view";
  import Panel from "./lib/Panel.svelte";
  import DropZone from "./lib/DropZone.svelte";

  import type { ChangeEventHandler, DragEventHandler } from "svelte/elements";
  import RequestList from "./lib/RequestList.svelte";
  let selectedRequest: Request | null = $state(null);
  function setActiveRegistry(e: Event) {
    e.preventDefault();
    fileRegistry.setActiveFileRegistry((e.target as HTMLSelectElement).value);
  }

  function fileDropped(fileName: string, contents: ArrayBuffer) {
    fileRegistry.addFileRegistryFromBinary(fileName, new Uint8Array(contents));
  }
</script>

<select onchange={setActiveRegistry}>
  <option>None</option>
  {#each fileRegistry.fileRegistries as fr}
    <option selected={fr.name == fileRegistry.activeFileRegistry?.name}
      >{fr.name}</option
    >
  {/each}
</select>
<DropZone fileDropped={fileDropped}>
  <RequestList
    requests={requests.requests}
    onRequestSelected={(i) => (selectedRequest = requests.requests[i])}
  />
</DropZone>
<Panel
  closePanel={() => (selectedRequest = null)}
  request={selectedRequest}
  isOpen={selectedRequest != null}
/>
