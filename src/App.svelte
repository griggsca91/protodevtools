<script>
    import requests from "./lib/requests.svelte";
</script>

<div>Hello World</div>

<ul>
    {#each requests.requests as request}
        <li>
            {request}
        </li>
    {/each}
</ul>
