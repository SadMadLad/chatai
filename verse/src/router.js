import { createWebHistory, createRouter } from "vue-router";

import NotFoundView from "@/views/errors/NotFoundView.vue";
import PokemonView from "@/views/PokemonView.vue";
import RootView from "@/views/RootView.vue";

const routes = [
  { path: "/", name: "root", component: RootView },
  { path: "/pokemon", name: "pokemon", component: PokemonView },
  { path: "/:pathMatch(.*)*", name: "not-found", component: NotFoundView },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export { router };
