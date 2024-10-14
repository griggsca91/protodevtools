<script lang="ts">
  import "./app.css";
  import requests, { type Request } from "./lib/requests.svelte";
  import fileRegistry from "./lib/fileRegistry.svelte";
  import Panel from "./lib/Panel.svelte";
  import DropZone from "./lib/DropZone.svelte";

  import RequestList from "./lib/RequestList.svelte";
  let selectedRequestIndex: number | null = $state(null);
  let selectedRequest: Request | null = $derived(requests.requests[selectedRequestIndex ?? -1] ?? null)
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
    onRequestSelected={(i) => selectedRequestIndex = i}
    selectedRequestIndex={selectedRequestIndex}
  />
</DropZone>
<Panel
  closePanel={() => (selectedRequestIndex = null)}
  request={selectedRequest}
  isOpen={selectedRequest != null}
/>
