<script setup>
import FavoriteButton from "@/components/favorite/FavoriteButton.vue";
import { ref } from "vue";

const { favorited } = defineProps({
  id: Number,
  favorited: Boolean,
  itemsCount: Number,
  tags: Array,
  styleClass: String,
  title: String,
});

const isFavorited = ref(favorited);
</script>

<template>
  <div
    class="relative my-auto mt-6 rounded-e-xl rounded-bl-xl border-t-8 shadow before:absolute before:-top-4 before:left-0 before:h-3 before:w-4/5 before:rounded-tl-md before:rounded-tr-xl before:content-['']"
    :class="styleClass"
  >
    <div class="flex max-w-60 flex-row items-center gap-2.5 p-4">
      <h4 class="font-semibold">{{ title }}</h4>
      <span>
        <FavoriteButton
          v-model="isFavorited"
          :favoritable-id="id"
          favoritable-type="Collection"
        />
      </span>
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
