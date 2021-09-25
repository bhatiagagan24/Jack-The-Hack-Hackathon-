<!-- Form to uupload Image for being displayed on the App -->

<script>
    // var image_name = "";
    let files;
    $: files
</script>

<main>
    <form>
        <input type="file" bind:files />
    </form>
    <h1>
        File Name ->
        {#if files}
        <p>
            {files[0].name}
        </p>
        {:else}
        <p>
            Please select the file
        </p>
        {/if}
    </h1>
</main>
