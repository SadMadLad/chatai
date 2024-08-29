<script setup>
import DashboardSidebar from "@/components/shared/DashboardSidebar.vue";
</script>

<template>
  <main class="flex flex-row">
    <DashboardSidebar />
    <section class="flex-grow">
      <RouterView />
    </section>
  </main>
</template>
