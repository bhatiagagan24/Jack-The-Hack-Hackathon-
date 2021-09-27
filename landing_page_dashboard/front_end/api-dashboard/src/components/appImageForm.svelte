<!-- Form to uupload Image for being displayed on the App -->

<script>
    // var image_name = "";
    import Button, {Label} from '@smui/button';
    let files;
    $: files
    // function for sending the form data to the API(endpoint -> /upload)
    async function sendingImages() {
        let formData = new FormData()
        formData.append("__file_to_be_uploaded", files[0])
        const resp = await fetch('http://192.168.1.10:5000/upload', {
            method: 'POST',
            body: formData,
            
        });
        const resp1 = await resp
        console.dir(resp1);
    }

</script>

<main>
    <form>
       <input type="file" bind:files required/>
    <h4>
        File Name
        {#if files}
        <p>
            {files[0].name}
        </p>
        {/if}
    </h4>
    <Button type="submit" on:click="{sendingImages}"> <Label>Upload Image</Label></Button>
</form>
</main>
