<script setup>
import { computed } from "vue";
import { useRouter } from "vue-router";

import SideBar from "@/components/shared/SideBar.vue";
import { useAuthStore } from "@/storage/auth";

const router = useRouter();

const userIsAuthed = computed(() => {
  const { isAuthenticated } = useAuthStore();

  return isAuthenticated;
});

function handleLogout() {
  const { logout } = useAuthStore();
  logout();
  router.push({ name: "home" });
}
</script>

<template>
  <header class="bg-white bg-opacity-50 backdrop-blur-md">
    <nav
      class="mx-12 flex flex-row items-center justify-between text-sm font-semibold"
    >
      <div class="flex flex-row gap-8">
        <RouterLink :to="{ name: 'home' }">
          <img src="/logo.png" class="h-12 w-auto md:h-20" />
        </RouterLink>
        <ul class="hidden flex-row items-center gap-4 md:flex">
          <li>
            <RouterLink
              :to="{ name: 'home' }"
              class="hover:text-primary-400"
              activeClass="text-primary-500"
              >Home
            </RouterLink>
          </li>
          <li>
            <RouterLink
              :to="{ name: 'about' }"
              class="hover:text-primary-400"
              activeClass="text-primary-500"
              >About
            </RouterLink>
          </li>
          <li>
            <RouterLink
              :to="{ name: 'quizzes' }"
              class="hover:text-primary-400"
              activeClass="text-primary-500"
              >Quizzes
            </RouterLink>
          </li>
        </ul>
      </div>
      <ul
        v-if="userIsAuthed"
        class="hidden flex-row items-center gap-8 md:flex"
      >
        <li>
          <button
            @click="handleLogout"
            class="hover:outline-primary-500 hover:text-primary-500 rounded-lg px-8 py-2.5 outline outline-2 -outline-offset-2 outline-black"
          >
            Logout
          </button>
        </li>
      </ul>
      <ul v-else class="hidden flex-row items-center gap-8 md:flex">
        <li>
          <RouterLink
            :to="{ name: 'login' }"
            class="hover:outline-primary-500 hover:text-primary-500 rounded-lg px-8 py-2.5 outline outline-2 -outline-offset-2 outline-black"
          >
            Login</RouterLink
          >
        </li>
        <li>
          <RouterLink
            :to="{ name: 'sign-up' }"
            class="hover:bg-primary-500 rounded-lg bg-black px-8 py-2.5 text-white -outline-offset-2"
            >Sign Up
          </RouterLink>
        </li>
      </ul>
      <div class="block md:hidden">
        <SideBar :userIsAuthed="userIsAuthed" @logout="handleLogout" />
      </div>
    </nav>
  </header>
</template>
