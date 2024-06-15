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
  <header class="flex flex-row items-center text-primary-500 p-4 ">
    <img src="/logo.png" class="w-12 h-12 mr-12" />
    <nav class="flex gap-4 font-semibold">
      <div class="flex flex-row gap-2.5">
        <RouterLink :class="routerClass" :to="{ name: 'home' }" activeClass="text-secondary-300">Home</RouterLink>
        <RouterLink :class="routerClass" :to="{ name: 'about' }" activeClass="text-secondary-300">About</RouterLink>
      </div>
      <div v-if="!userIsAuthed">
        <RouterLink :class="routerClass" :to="{ name: 'login' }" activeClass="text-secondary-300">Login</RouterLink>
      </div>
      <div class="flex gap-4" v-else>
        <RouterLink :class="routerClass" :to="{ name: 'dashboard' }" activeClass="text-secondary-300">Dashboard</RouterLink>
        <RouterLink :class="routerClass" :to="{ name: 'quizzes' }" activeClass="text-secondary-300">Quizzes</RouterLink>
      </div>
    </nav>
  </header>

</template>
