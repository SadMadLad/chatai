import { createWebHistory, createRouter } from "vue-router";

import NotFoundView from "@/views/errors/NotFoundView.vue";
import LoginView from "@/views/auth/LoginView.vue";
import RootView from "@/views/RootView.vue";

const routes = [
  { path: "/", name: "root", component: RootView },
  { path: "/login", name: "login", component: LoginView },
  { path: "/:pathMatch(.*)*", name: "not-found", component: NotFoundView },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export { router };
