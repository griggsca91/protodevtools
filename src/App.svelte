<script>
    import "./app.css";
    import requests from "./lib/requests.svelte";
    import { JsonView } from "@zerodevx/svelte-json-view";

    function addRequest() {
        requests.addRequest({
            requestTime: new Date(),
            data: {
                "1": {
                    type: "string",
                    value: "World",
                },
            },
            url: "http://localhost:8080/greeter.Greeter/SayHello",
            method: "POST",
            response: {
                data: {
                    "0": [
                        {
                            type: "uint",
                            value: "16",
                        },
                        {
                            type: "sint",
                            value: "8",
                        },
                    ],
                    "1": {
                        type: "string",
                        value: "Hello, World!",
                    },
                    "2": {
                        "1": {
                            type: "string",
                            value: "string",
                        },
                        "2": {
                            type: "string",
                            value: "world",
                        },
                        "3": [
                            {
                                type: "uint",
                                value: "42",
                            },
                            {
                                type: "sint",
                                value: "21",
                            },
                        ],
                        "4": [
                            {
                                type: "uint",
                                value: "1",
                            },
                            {
                                type: "sint",
                                value: "-1",
                            },
                        ],
                        "5": [
                            {
                                type: "uint",
                                value: "1",
                            },
                            {
                                type: "sint",
                                value: "-1",
                            },
                        ],
                        "6": [
                            {
                                type: "int",
                                value: 1078523331,
                            },
                            {
                                type: "float",
                                value: 3.140000104904175,
                            },
                        ],
                        "7": [
                            {
                                type: "uint",
                                value: "4",
                            },
                            {
                                type: "sint",
                                value: "2",
                            },
                        ],
                        "8": {
                            "1": {
                                type: "string",
                                value: "url",
                            },
                            "2": {
                                type: "string",
                                value: "title",
                            },
                            "3": {
                                type: "string",
                                value: "snippet 2",
                            },
                        },
                        "10": {
                            "1": {
                                type: "string",
                                value: "url",
                            },
                            "2": {
                                type: "string",
                                value: "title",
                            },
                            "3": {
                                type: "string",
                                value: "snippet 2",
                            },
                        },
                        "11": {
                            "1": {
                                type: "string",
                                value: "key",
                            },
                            "2": {
                                "1": {
                                    type: "string",
                                    value: "url",
                                },
                                "2": {
                                    type: "string",
                                    value: "title",
                                },
                                "3": {
                                    type: "string",
                                    value: "snippet 2",
                                },
                            },
                        },
                    },
                },
            },
        });
    }
</script>

<div>Hello World</div>
<button onclick={addRequest}>Add Request</button>

<div class="container flex-row">
    {#each requests.requests as r}
        <div class="flex flex-column">
            <div class="basis-1/4 flex-row">
                <div class="basis-1/2">
                    {r.url}
                </div>
                <div class="text-xs basis-1/2">
                    {r.requestTime}
                </div>

            </div>
            <div class="basis-1/2">
                <JsonView json={r.data} />
            </div>
            <div class="basis-1/2">
                <JsonView json={r.response?.data} />
            </div>
        </div>
    {/each}
</div>
