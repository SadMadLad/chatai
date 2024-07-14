<script setup>
import Collection from "@/components/collection/Collection.vue"
import { getCollections } from "@/services/apis/collection";

const { isLoading, error, fetchedData: collections } = getCollections();
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="error">Error</div>
  <section v-else class="flex flex-wrap gap-6">
    <Collection v-for="collection in collections" v-bind="collection" />
  </section>
</template>
