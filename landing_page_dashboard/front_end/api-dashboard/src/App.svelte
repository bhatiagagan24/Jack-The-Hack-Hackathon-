<script>
	export let name;
	import home from './components/home.svelte';
	import AppImageForm from './components/appImageForm.svelte';
</script>

<main>
	<h1>Hello {name}!</h1>
	<AppImageForm></AppImageForm>
</main>

<style>
	main {
		text-align: center;
		padding: 1em;
		max-width: 240px;
		margin: 0 auto;
	}

	h1 {
		color: #ff3e00;
		text-transform: uppercase;
		font-size: 4em;
		font-weight: 100;
	}

	@media (min-width: 640px) {
		main {
			max-width: none;
		}
	}
</style>