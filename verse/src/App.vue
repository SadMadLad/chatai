<script setup>
  import { useAuthStore } from "@/storage/auth";
  import { reactive } from "vue";

  const { isAuthenticated } = useAuthStore();
</script>

<template>
  <nav>
    <RouterLink to="/">Go to Home</RouterLink>
    <RouterLink to="/about">Go to About</RouterLink>
    {{ isAuthenticated }}
    <div v-if="!isAuthenticated">
      <RouterLink to="/login">Go To Login</RouterLink>
    </div>
    <div v-else>
      You are logged in.
    </div>
  </nav>
  <main>
    <RouterView />
  </main>
</template>
