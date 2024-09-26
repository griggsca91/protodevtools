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
</script>

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
            h-full bg-slate-300 transform
            transition-transform
            overflow-auto
            "
    >
        <button
            class="bg-gray-800 text-white p-2 rounded"
            onclick={closePanel}
        >
            ✕
        </button>
        <div class="flex flow-column justify-around">
            <div>
                <JsonView json={request?.data} />
            </div>
            <div>
                <JsonView json={request?.response?.data} />
            </div>
        </div>
    </div>
{/if}

<style>
    .transition-transform {
        transition: transform 2s ease-in-out;
    }
</style>
