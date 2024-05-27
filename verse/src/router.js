import { createWebHistory, createRouter } from "vue-router";
import RootPage from "@/views/RootPage.vue";
import PokemonPage from "@/views/PokemonPage.vue";

const routes = [
  { path: "/", name: "root", component: RootPage },
  { path: "/pokemon", name: "pokemon", component: PokemonPage },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export { router };
