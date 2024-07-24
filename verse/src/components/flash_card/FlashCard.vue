<script setup>
import CollectableButton from "@/components/collection/CollectableButton.vue";
import FavoriteButton from "@/components/favorite/FavoriteButton.vue";
import { ref } from "vue";
import { PhArrowBendUpLeft } from "@phosphor-icons/vue";

const isFlipped = ref(false);

const { color, card_style, favorited } = defineProps({
  id: Number,
  answer: String,
  buttonClass: String,
  card_style: String,
  color: String,
  favorited: Boolean,
  frontClass: String,
  prompt: String,
  tagClass: String,
  tags: Array,
});

const isFavorited = ref(favorited);
</script>

<template>
  <Transition name="flip" mode="out-in">
    <div
      v-if="!isFlipped"
      class="flex-center relative mx-auto mb-6 h-72 w-60 p-4"
      :class="frontClass"
    >
      <span class="absolute right-6 top-6 flex flex-row gap-2.5">
        <CollectableButton
          :collectable-id="id"
          :collectable-title="`Add Flash Card '${prompt}' to a collection`"
          collectable-type="FlashCard"
        />
        <FavoriteButton
          v-model:favorited="isFavorited"
          :has-favorites-count="false"
          :favoritable-id="id"
          favoritable-type="FlashCard"
        />
      </span>
      <div class="flex flex-col items-center gap-2">
        <p class="text-center text-xl">{{ prompt }}</p>
        <button :class="buttonClass" @click="isFlipped = true">
          Flip Card
        </button>
      </div>
    </div>
    <div
      v-else
      class="flex-center relative mx-auto mb-6 h-72 w-60 p-4"
      :class="frontClass"
    >
      <PhArrowBendUpLeft
        :size="32"
        class="absolute left-2.5 top-2.5 cursor-pointer"
        @click="isFlipped = false"
      />
      <div class="flex flex-col items-center gap-4">
        <p>{{ answer }}</p>
        <ul class="flex flex-wrap justify-center gap-1">
          <span v-for="{ tag } in tags" :class="tagClass">
            {{ tag }}
          </span>
        </ul>
      </div>
    </div>
  </Transition>
</template>

<style scoped>
.flip-enter-from {
  transform: rotateY(90deg);
}

.flip-enter-active,
.flip-leave-active {
  transition: all 0.25s;
}

.flip-enter,
.flip-leave-to {
  transform: rotateY(-90deg);
}
</style>
