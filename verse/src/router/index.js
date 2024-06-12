import { createWebHistory, createRouter } from "vue-router";
import { privateRoute, publicOnlyRoute } from "@/router/guards";

import AboutView from "@/views/static/AboutView.vue";
import DashboardView from "@/views/dashboard/DashboardView.vue";
import NotFoundView from "@/views/errors/NotFoundView.vue";
import LoginView from "@/views/auth/LoginView.vue";
import RootView from "@/views/static/RootView.vue";

const routes = [
  {
    path: "/",
    name: "home",
    component: RootView,
  },
  {
    path: "/about",
    name: "about",
    component: AboutView,
  },
  {
    path: "/login",
    name: "login",
    component: LoginView,
    beforeEnter: [publicOnlyRoute],
  },
  {
    path: "/dashboard",
    name: "dashboard",
    component: DashboardView,
    beforeEnter: [privateRoute]
  },
  {
    path: "/:pathMatch(.*)*",
    name: "not-found",
    component: NotFoundView,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export { router };
