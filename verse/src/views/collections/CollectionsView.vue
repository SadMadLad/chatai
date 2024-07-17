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
  <section v-else>
    <section class="my-12 flex flex-col items-center gap-4">
      <h1
        class="from-secondary-500 to-primary-500 bg-gradient-to-r bg-clip-text text-5xl font-black text-transparent"
      >
        Collections
      </h1>
      <p class="text-primary-500 text-xl font-bold">
        Browse different collections, add them to your collections
      </p>
    </section>
    <section class="mx-6 flex flex-wrap justify-center gap-8">
      <Collection
        v-for="collection in collections"
        v-bind="collection"
        :style-class="collectionStyler.displayClass(collection)"
        :tag-class="collectionStyler.tagClass(collection)"
      />
    </section>
  </section>
</template>
