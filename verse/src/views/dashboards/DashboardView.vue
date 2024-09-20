<script setup>
import { getDashboardStatistics } from "@/services/apis/dashboard";

const { isLoading, error, fetchedData: dashboardStatistics } = getDashboardStatistics();
</script>

<template>
  <h1 class="text-center text-4xl font-black">
    This is a dashboard page after login successfully.

  </h1>
  <div v-if="isLoading">
    Loading...
  </div>
  <div v-else-if="error">
    Error
  </div>
  <section v-else>
    {{  dashboardStatistics  }}
  </section>
</template>
