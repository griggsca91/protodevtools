<script lang="ts">
  import type { Snippet } from "svelte";

  const {
    fileDropped,
    children,
  }: {
    fileDropped: (fileName: string, data: ArrayBuffer) => void;
    children: Snippet;
  } = $props();

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
          if (!file) {
            console.log("File doesn't exist");
            return;
          }
          const contents = await file?.arrayBuffer();
          if (!contents) {
            console.log("contents null", contents);
            return;
          }
          fileDropped(file.name, contents);
          //   fileRegistry.addFileRegistryFromBinary(
          //     file.name,
          //     new Uint8Array(coneternts),
          //   );
          //   console.log(`… file[${i}].name = ${file?.name}`);
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

<!-- svelte-ignore a11y_no_static_element_interactions -->
<div
  id="dropZone"
  ondragleave={onDragEnd}
  ondragover={onDragStart}
  ondrop={onDrop}
>
  {@render children()}
</div>
