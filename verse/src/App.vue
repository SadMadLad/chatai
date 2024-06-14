<script setup>
import { computed } from "vue";
import { useAuthStore } from "@/storage/auth";

const routerClass = "hover:underline transition-colors duration-300";

const userIsAuthed = computed(() => {
  const { isAuthenticated } = useAuthStore();
  return isAuthenticated;
});
</script>

<template>
  <nav class="bg-primary-500 flex gap-4 p-4 font-semibold text-white">
    <RouterLink
      :class="routerClass"
      :to="{ name: 'home' }"
      activeClass="text-secondary-300"
      >Go to Home</RouterLink
    >
    <RouterLink
      :class="routerClass"
      :to="{ name: 'about' }"
      activeClass="text-secondary-300"
      >Go to About</RouterLink
    >
    <div v-if="!userIsAuthed">
      <RouterLink
        :class="routerClass"
        :to="{ name: 'login' }"
        activeClass="text-secondary-300"
        >Go To Login</RouterLink
      >
    </div>
    <div v-else>
      <RouterLink
        :class="routerClass"
        :to="{ name: 'quizzes' }"
        activeClass="text-secondary-300"
      >Go To Quizzes</RouterLink>
    </div>
  </nav>
  <main>
    <RouterView />
  </main>
</template>
