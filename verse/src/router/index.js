import { createWebHistory, createRouter } from "vue-router";
import { privateRoute, publicOnlyRoute } from "@/router/guards";

import AboutView from "@/views/static/AboutView.vue";
import DashboardView from "@/views/dashboard/DashboardView.vue";
import LoginView from "@/views/auth/LoginView.vue";
import NotFoundView from "@/views/errors/NotFoundView.vue";
import QuizView from "@/views/quiz/QuizView.vue";
import QuizUndertakingView from "@/views/quiz/QuizUndertakingView.vue";
import QuizzesView from "@/views/quiz/QuizzesView.vue";
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
    path: "/dashboard",
    name: "dashboard",
    component: DashboardView,
    beforeEnter: [privateRoute],
  },
  {
    path: "/login",
    name: "login",
    component: LoginView,
    beforeEnter: [publicOnlyRoute],
  },
  {
    path: "/quizzes",
    beforeEnter: [privateRoute],
    children: [
      {
        path: "",
        name: "quizzes",
        component: QuizzesView,
      },
      {
        path: ":id",
        children: [
          {
            path: "",
            name: "quiz",
            component: QuizView,
          },
          {
            path: "undertaking",
            name: "quiz-undertaking",
            component: QuizUndertakingView,
          },
        ],
      },
    ],
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
