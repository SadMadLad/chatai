import { createWebHistory, createRouter } from "vue-router";
import { privateRoute, publicOnlyRoute } from "@/router/guards";

import AboutView from "@/views/static/AboutView.vue";
import CollectionsDashboardView from "@/views/dashboards/collections/CollectionsDashboardView.vue";
import CollectionView from "@/views/collections/CollectionView.vue";
import CollectionsView from "@/views/collections/CollectionsView.vue";
import DashboardView from "@/views/dashboards/DashboardView.vue";
import FlashCardsDashboardView from "@/views/dashboards/flash_cards/FlashCardsDashboardView.vue";
import FlashCardsView from "@/views/flash_cards/FlashCardsView.vue";
import HomeView from "@/views/static/HomeView.vue";
import LoginView from "@/views/auth/LoginView.vue";
import NotFoundView from "@/views/errors/NotFoundView.vue";
import QuizView from "@/views/quizzes/QuizView.vue";
import QuizUndertakingView from "@/views/quizzes/QuizUndertakingView.vue";
import QuizzesDashboardView from "@/views/dashboards/quizzes/QuizzesDashboardView.vue";
import QuizzesView from "@/views/quizzes/QuizzesView.vue";
import SearchesView from "@/views/searches/SearchesView.vue";
import SignUpView from "@/views/auth/SignUpView.vue";

import ApplicationLayout from "@/layouts/ApplicationLayout.vue";
import DashboardLayout from "@/layouts/DashboardLayout.vue";
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
        path: "dashboard",
        component: DashboardLayout,
        beforeEnter: [privateRoute],
        children: [
          {
            path: "",
            name: "dashboard",
            component: DashboardView,
          },
          {
            path: "collections",
            name: "collections-dashboard",
            component: CollectionsDashboardView,
          },
          {
            path: "flash_cards",
            name: "flash-cards-dashboard",
            component: FlashCardsDashboardView,
          },
          {
            path: "quizzes",
            name: "quizzes-dashboard",
            component: QuizzesDashboardView,
          },
        ]
      },
      {
        path: "/flash_cards",
        name: "flash-cards",
        component: FlashCardsView,
        beforeEnter: [privateRoute],
      },
      {
        path: "/searches",
        name: "searches",
        component: SearchesView,
        beforeEnter: [privateRoute],
      },
      {
        path: "/collections",
        beforeEnter: [privateRoute],
        children: [
          {
            path: "",
            name: "collections",
            component: CollectionsView,
          },
          {
            path: ":id",
            name: "collection",
            component: CollectionView,
          },
        ],
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
