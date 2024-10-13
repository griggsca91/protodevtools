<script lang="ts">
  const {
    requests,
    onRequestSelected,
  }: {
    requests: { url: string; requestTime: Date }[];
    onRequestSelected: (index: number) => void;
  } = $props();
</script>

<div class="container m-2 p-2 h-screen">
  <h3 class="text-lg font-semibold mb-2">Network Requests</h3>
  <div class="h-96 overflow-auto border border-gray-200 rounded-md">
    <div class="container flex-row space-y-4">
      <table class="min-w-full divide-y divide-gray-200">
        <thead class="bg-gray-50">
          <tr>
            <th
              class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
              >URL</th
            >
            <th
              class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider"
              >Timestamp</th
            >
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          {#each requests as r, i}
            <tr
              onclick={() => {
                onRequestSelected(i);
              }}
            >
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900"
                >{r.url}</td
              >
              <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500"
                >{r.requestTime}</td
              >
            </tr>
          {/each}
        </tbody>
      </table>
    </div>
  </div>
</div>
