<script setup>
import { computed, ref } from "vue";
import { PhArrowBendUpLeft } from "@phosphor-icons/vue";

const isFlipped = ref(false);

defineProps({
  id: Number,
  answer: String,
  card_style: String,
  color: String,
  frontClass: String,
  frontStyle: Object,
  prompt: String,
  tags: Array,
});

const filteredTags = computed(
  () => (tags) => tags.filter((tag) => tag.tag_type === "display"),
);

</script>

<template>
  <Transition name="flip" mode="out-in">
    <div v-if="!isFlipped" @click="isFlipped = true" class="cursor-pointer flex-center w-60 h-72 mx-auto mb-6 p-4"
      :class="frontClass" :style="frontStyle">
      <p class="text-xl text-center">{{ prompt }}</p>
    </div>
    <div v-else class="relative flex-center w-60 h-72 mx-auto mb-6 p-4" :class="frontClass" :style="frontStyle">
      <PhArrowBendUpLeft :size="32" class="cursor-pointer absolute top-2.5 left-2.5" @click="isFlipped = false" />
      <div class="flex flex-col gap-4 items-center">
        <p>{{ answer }}</p>
        <ul class="flex flex-wrap gap-1">
          <span
            v-for="{ tag } in filteredTags(tags)"
            class="px-1.5 text-xs py-1 rounded-lg bg-fuchsia-500 bg-opacity-20"
          >
            {{ tag }}
          </span>
        </ul>
      </div>
    </div>
  </Transition>
</template>

<style scoped>
.flip-enter-from {
  transform: rotateY(-90deg);
}

.flip-enter-active,
.flip-leave-active {
  transition: all .25s;
}

.flip-enter,
.flip-leave-to {
  transform: rotateY(-90deg);
}
</style>
