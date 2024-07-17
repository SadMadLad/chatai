import { createApp } from "vue";
import App from "@/App.vue";
import { router } from "@/router/index";
import "@/style.css";

import "@/extensions/array";
import "@/extensions/number";
import "@/extensions/string";

import { createPinia } from "pinia";
import piniaPluginPersistedstate from "pinia-plugin-persistedstate";

const pinia = createPinia();
pinia.use(piniaPluginPersistedstate);

createApp(App).use(pinia).use(router).mount("#app");
