<script setup>
import Collection from "@/components/collection/Collection.vue";
import { CollectionStyler } from "@/services/styler";
import { getCollections } from "@/services/apis/collection";

const collectionStyler = new CollectionStyler();

const { isLoading, error, fetchedData: collections } = getCollections();
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="error">Error</div>
  <section v-else class="flex flex-wrap justify-center gap-8">
    <Collection
      v-for="collection in collections"
      v-bind="collection"
      :style-class="collectionStyler.displayClass(collection)"
    />
  </section>
</template>
