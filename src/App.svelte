<script lang="ts">
    import "./app.css";
    import requests, { type Request } from "./lib/requests.svelte";
    import { JsonView } from "@zerodevx/svelte-json-view";
    import Panel from "./lib/Panel.svelte";
    import type { DragEventHandler } from "svelte/elements";
    let selectedRequest: Request | null = $state(null);

    let openPanel = $state(false);
    function toggle() {
        openPanel = !openPanel;
    }

    async function onDrop(ev: DragEvent) {
        console.log("ondrop", ev.dataTransfer?.items);
        ev.preventDefault();
        const el = document.getElementById("dropZone");
        if (el) {
            el.style.opacity = "1";
        }
        if (!ev.dataTransfer) {
            return;
        }

        if (ev.dataTransfer.items) {
            // Use DataTransferItemList interface to access the file(s)
            [...ev.dataTransfer.items].forEach(async (item, i) => {
                // If dropped items aren't files, reject them
                if (item.kind === "file") {
                    const file = item.getAsFile();
                    const coneternts = await file?.arrayBuffer();
                    if (!coneternts) {
                        console.log("contents null", coneternts);
                        return;
                    }
                    console.log(coneternts);
                    requests.setFileRegistry(new Uint8Array(coneternts));
                    console.log(`… file[${i}].name = ${file?.name}`);
                }
            });
        } else {
            // Use DataTransfer interface to access the file(s)
            [...ev.dataTransfer.files].forEach((file, i) => {
                console.log(`… file[${i}].name = ${file.name}`);
            });
        }
    }
    function onDragStart(e: DragEvent) {
        e.preventDefault();
        const el = document.getElementById("dropZone");
        if (!el) {
            return;
        }
        el.style.opacity = "0.5";
    }
    function onDragEnd(e: DragEvent) {
        e.preventDefault();
        const el = document.getElementById("dropZone");
        if (!el) {
            return;
        }
        el.style.opacity = "1";
    }
</script>

<!-- svelte-ignore css_unused_selector -->
<div
    id="dropZone"
    ondragleave={onDragEnd}
    ondragover={onDragStart}
    ondrop={onDrop}
>
    <div class="container m-2 p-2 h-screen bg-amber-100">
        <div class="container flex-row space-y-4">
            {#each requests.requests as r}
                <!-- svelte-ignore a11y_click_events_have_key_events -->
                <!-- svelte-ignore a11y_no_static_element_interactions -->
                <div
                    class="flex flex-column"
                    onclick={(e) => {
                        selectedRequest = r;
                        openPanel = true;
                        e.stopPropagation();
                    }}
                >
                    <div class="basis-1/4 flex-row">
                        <div class="basis-1/2">
                            {r.url}
                        </div>
                        <div class="text-xs basis-1/2">
                            {r.requestTime}
                        </div>
                    </div>
                </div>
            {/each}
        </div>
    </div>
</div>
<Panel
    closePanel={() => (openPanel = false)}
    request={selectedRequest}
    isOpen={openPanel}
/>
