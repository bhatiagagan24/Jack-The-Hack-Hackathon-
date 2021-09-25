<!-- Form to uupload Image for being displayed on the App -->

<script>
    // var image_name = "";
    let files;
    $: files
</script>

<main>
    <form>
       <input type="file" bind:files />
    <h4>
        File Name
        {#if files}
        <p>
            {files[0].name}
        </p>
        {/if}
    </h4>
    <input type="submit" />
</form>
</main>
