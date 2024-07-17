<script setup>
import { getCollection } from "@/services/apis/collection";

const { isLoading, error, fetchedData: collection } = getCollection(1);
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="error">Error</div>
  <section v-else></section>
</template>
