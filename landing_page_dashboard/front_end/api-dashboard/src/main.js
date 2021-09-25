import App from './App.svelte';

const app = new App({
	target: document.body,
	props: {
		name: 'Admin'
	}
});

// const app = new Home({target: document.body});
export default app;