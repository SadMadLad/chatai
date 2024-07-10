<script setup>
import NavBar from "@/components/shared/NavBar.vue";
</script>

<template>
  <NavBar />
  <main class="flex flex-col items-center">
    <RouterView />
  </main>
</template>
