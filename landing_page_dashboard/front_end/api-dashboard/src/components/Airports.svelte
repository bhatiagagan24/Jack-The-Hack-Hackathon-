<!-- Component for Displaying as well as Adding new Airports -->

<script>
    import {onMount} from 'svelte';
let final_res = [];
let resp1 = 'yo';

onMount(async () => {
    const res = await fetch('http://192.168.1.10:5000/airports/get').then(response => response.json);
    resp1 = res;
    resp1 = resp1;
    const final_res = await res.json();
    final_res = final_res;
});

</script>

<main>
    <h1>Airport List: - </h1>
    {final_res}
    {#each final_res as airport}
        <h2>Not Empty</h2>
    {/each}
    {resp1}
</main>