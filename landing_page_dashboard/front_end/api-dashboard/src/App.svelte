<script>
	// export let name;
	import HomeMenu from './components/HomeMenu.svelte';
	import AppImageForm from './components/appImageForm.svelte';
	
</script>

<main>
	<HomeMenu></HomeMenu>
	<hr>
	<h3>Upload Images to Display them on App Home Screen</h3>
	<!-- <h1>Hello {name}!</h1> -->
	<AppImageForm></AppImageForm>
</main>

<style>
	main {
		text-align: center;
		padding: 1em;
		max-width: 240px;
		margin: 0 auto;
	}

	h3 {
		color: red;
		text-transform: uppercase;
		font-size: 2em;
		font-weight: 200;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>