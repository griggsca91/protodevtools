<script lang="ts">
  import { fade, fly, slide } from "svelte/transition";
  import { backOut } from "svelte/easing";

  import { type Request } from "./requests.svelte";
  import { JsonView } from "@zerodevx/svelte-json-view";
  const {
    isOpen,
    request,
    closePanel,
  }: { isOpen: Boolean; request: Request | null; closePanel: () => void } =
    $props();

  let activeTab: "request" | "response" = $state("request");
</script>

{#snippet renderJSON(data: any)}
  <div class="ml-4">
    <JsonView json={data} />
  </div>
{/snippet}

{#if isOpen}
  <div
    out:slide={{
      axis: "x",
      duration: 200,
    }}
    in:slide={{
      axis: "x",
      duration: 200,
    }}
    class="fixed top-0 right-0 w-1/2
            h-full transform
            bg-gray-50
            transition-transform
            overflow-auto
            "
  >
    <button class="bg-gray-800 text-white p-2 rounded" onclick={closePanel}>
      ✕
    </button>
    <div class="">
      <h3 class="text-lg font-semibold mb-2">Request Details</h3>
      <div class="flex border-b border-gray-200">
        <button
          onclick={() => (activeTab = "request")}
          class={`px-4 py-2 font-medium text-sm focus:outline-none ${
            activeTab === "request"
              ? "text-blue-600 border-b-2 border-blue-600"
              : "text-gray-500 hover:text-gray-700"
          }`}
        >
          Request
        </button>
        <button
          onclick={() => (activeTab = "response")}
          class={`px-4 py-2 font-medium text-sm focus:outline-none ${
            activeTab === "response"
              ? "text-blue-600 border-b-2 border-blue-600"
              : "text-gray-500 hover:text-gray-700"
          }`}
        >
          Response
        </button>
      </div>
      <div
        class="h-96 overflow-auto border border-gray-200 rounded-md mt-4 p-4"
      >
        {#if activeTab == "request"}
          {@render renderJSON(request?.data)}
        {/if}

        {#if activeTab == "response"}
          {@render renderJSON(request?.response?.data)}
        {/if}
      </div>
    </div>
  </div>
{/if}

<style>
  .transition-transform {
    transition: transform 2s ease-in-out;
  }
</style>
