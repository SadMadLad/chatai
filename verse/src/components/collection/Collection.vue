<script setup>
import { computed, ref } from "vue";
import FavoriteButton from "@/components/favorite/FavoriteButton.vue";

const { items_count, favorited, favorites_count, tags } = defineProps({
  id: Number,
  favorited: Boolean,
  favorites_count: Number,
  items_count: Number,
  styleClass: String,
  tagClass: String,
  tags: Array,
  title: String,
});

const isFavorited = ref(favorited);
const favoritesCount = ref(favorites_count);

const itemsCount = computed(
  () => `${items_count} ${items_count.isOne() ? "item" : "items"}`,
);
const filteredTags = computed(
  () => (tags) => tags.filter((tag) => tag.tag_type === "display"),
);
</script>

<template>
  <div
    class="relative my-auto mt-6 w-80 rounded-e-xl rounded-bl-xl border-t-8 shadow before:absolute before:-top-4 before:left-0 before:h-3 before:w-4/5 before:rounded-tl-md before:rounded-tr-xl before:content-['']"
    :class="styleClass"
  >
    <div class="flex flex-col gap-4 p-4">
      <div class="flex flex-row items-center justify-between gap-2.5">
        <RouterLink
          :to="{ name: 'collection', params: { id: id } }"
          class="flex flex-col gap-0 hover:underline"
        >
          <h4 class="font-semibold">{{ title }}</h4>
          <span class="text-xs">{{ itemsCount }}</span>
        </RouterLink>
        <span>
          <FavoriteButton
            v-model:favorited="isFavorited"
            v-model:favorites-count="favoritesCount"
            :has-favorites-count="true"
            :favoritable-id="id"
            :icon-size="24"
            favoritable-type="Collection"
          />
        </span>
      </div>
      <div
        v-if="tags.isPresent()"
        class="flex flex-row flex-wrap justify-center gap-1"
      >
        <span v-for="{ tag } in filteredTags(tags)" :class="tagClass">
          {{ tag }}
        </span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.folder {
  width: 150px;
  height: 105px;
  margin: 0 auto;
  margin-top: 50px;
  position: relative;
  background-color: #708090;
  border-radius: 0 6px 6px 6px;
}

.folder:before {
  content: "";
  width: 50%;
  height: 12px;
  border-radius: 0 20px 0 0;
  background-color: #708090;
  position: absolute;
  top: -12px;
  left: 0px;
}
</style>
