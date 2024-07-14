<script setup>
import FavoriteButton from "@/components/favorite/FavoriteButton.vue";
import { ref } from "vue";

const { favorited } = defineProps({
  id: Number,
  favorited: Boolean,
  itemsCount: Number,
  tags: Array,
  title: String,
});

const isFavorited = ref(favorited);
</script>

<template>
  <div class="bg-red-500 p-8 shadow-xl">
    {{ title }}
    <span>
      <FavoriteButton v-model="isFavorited" :favoritable-id="id" favoritable-type="Collection" />
    </span>
  </div>
</template>
