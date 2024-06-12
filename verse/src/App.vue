<script setup>
import { computed } from "vue";
import { useAuthStore } from "@/storage/auth";

const userIsAuthed = computed(() => {
  const { isAuthenticated } = useAuthStore();
  return isAuthenticated
});
</script>

<template>
  <nav>
    <RouterLink :to="{ name: 'home' }">Go to Home</RouterLink>
    <RouterLink :to="{ name: 'about' }">Go to About</RouterLink>
    {{ userIsAuthed }}
    <div v-if="!userIsAuthed">
      <RouterLink :to="{ name: 'login' }">Go To Login</RouterLink>
    </div>
    <div v-else>You are logged in.</div>
  </nav>
  <main>
    <RouterView />
  </main>
</template>
