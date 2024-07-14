import { createWebHistory, createRouter } from "vue-router";
import { privateRoute, publicOnlyRoute } from "@/router/guards";

import AboutView from "@/views/static/AboutView.vue";
import CollectionsView from "@/views/collections/CollectionsView.vue";
import DashboardView from "@/views/dashboards/DashboardView.vue";
import FlashCardsView from "@/views/flash_cards/FlashCardsView.vue";
import HomeView from "@/views/static/HomeView.vue";
import LoginView from "@/views/auth/LoginView.vue";
import NotFoundView from "@/views/errors/NotFoundView.vue";
import QuizView from "@/views/quizzes/QuizView.vue";
import QuizUndertakingView from "@/views/quizzes/QuizUndertakingView.vue";
import QuizzesView from "@/views/quizzes/QuizzesView.vue";
import SignUpView from "@/views/auth/SignUpView.vue";

import ApplicationLayout from "@/layouts/ApplicationLayout.vue";
import SessionsLayout from "@/layouts/SessionsLayout.vue";

const routes = [
  {
    path: "/sessions",
    component: SessionsLayout,
    beforeEnter: [publicOnlyRoute],
    children: [
      {
        path: "/login",
        name: "login",
        component: LoginView,
      },
      {
        path: "/sign-up",
        name: "sign-up",
        component: SignUpView,
      },
    ],
  },
  {
    path: "/",
    component: ApplicationLayout,
    children: [
      {
        path: "/",
        name: "home",
        component: HomeView,
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
        path: "/flash_cards",
        name: "flash-cards",
        component: FlashCardsView,
        beforeEnter: [privateRoute],
      },
      {
        path: "/collections",
        name: "collections",
        component: CollectionsView,
        beforeEnter: [privateRoute],
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
