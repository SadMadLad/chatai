<script setup>
import { computed } from "vue";
import { useAuthStore } from "@/storage/auth";

const routerClass = "hover:text-secondary-500 transition-all duration-100 py-4";

const userIsAuthed = computed(() => {
  const { isAuthenticated } = useAuthStore();
  return isAuthenticated;
});
</script>

<template>
  <header
    class="text-primary-500 sticky top-0 flex flex-row items-center justify-between border-b bg-white bg-opacity-40 px-12 shadow backdrop-blur"
  >
    <div class="flex items-center gap-8">
      <RouterLink :to="{ name: 'home' }">
        <img src="/logo.png" class="h-10 w-auto" />
      </RouterLink>
      <nav class="flex items-center gap-4 font-semibold">
        <div class="flex flex-row gap-2.5">
          <RouterLink
            :class="routerClass"
            :to="{ name: 'home' }"
            activeClass="border-b-2 border-b-primary-500"
            >Home</RouterLink
          >
          <RouterLink
            :class="routerClass"
            :to="{ name: 'about' }"
            activeClass="border-b-2 border-b-primary-500"
            >About</RouterLink
          >
        </div>
        <div class="flex gap-4" v-if="userIsAuthed">
          <RouterLink
            :class="routerClass"
            :to="{ name: 'dashboard' }"
            activeClass="border-b-2 border-b-primary-500"
            >Dashboard
          </RouterLink>
          <RouterLink
            :class="routerClass"
            :to="{ name: 'quizzes' }"
            activeClass="border-b-2 border-b-primary-500"
            >Quizzes
          </RouterLink>
        </div>
      </nav>
    </div>
    <div>
      <div v-if="!userIsAuthed">
        <RouterLink
          class="hover:bg-secondary-500 bg-primary-500 rounded px-3.5 py-2 font-semibold text-white"
          :to="{ name: 'login' }"
          >Login</RouterLink
        >
      </div>
    </div>
  </header>
</template>
