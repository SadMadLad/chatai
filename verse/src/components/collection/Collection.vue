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
  <div class="p-8 border rounded-xl shadow-xl">
    <span>
      <FavoriteButton v-model="isFavorited" :favoritable-id="id" favoritable-type="Collection" style-class="text-rose-500" />
    </span>
  </div>
</template>
