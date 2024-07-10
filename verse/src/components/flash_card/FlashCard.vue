<script setup>
import { computed, ref, toRef } from "vue";
import { PhArrowBendUpLeft } from "@phosphor-icons/vue";

const isFlipped = ref(false);

const { color } = defineProps({
  id: Number,
  answer: String,
  card_style: String,
  color: String,
  frontClass: String,
  frontStyle: Object,
  prompt: String,
  tags: Array,
});

const colorRef = toRef(color);
const invertedColorHex = (16777215 - Number(`0x${colorRef.value.substring(1)}`)).toString(16).padStart(6, '0');

const filteredTags = computed(
  () => (tags) => tags.filter((tag) => tag.tag_type === "display"),
);


</script>

<template>
  <Transition name="flip" mode="out-in">
    <div
      v-if="!isFlipped"
      @click="isFlipped = true"
      class="flex-center mx-auto mb-6 h-72 w-60 cursor-pointer p-4"
      :class="frontClass"
      :style="frontStyle"
    >
      <p class="text-center text-xl">{{ prompt }}</p>
    </div>
    <div
      v-else
      class="flex-center relative mx-auto mb-6 h-72 w-60 p-4"
      :class="frontClass"
      :style="frontStyle"
    >
      <PhArrowBendUpLeft
        :size="32"
        class="absolute left-2.5 top-2.5 cursor-pointer"
        @click="isFlipped = false"
      />
      <div class="flex flex-col items-center gap-4">
        <p>{{ answer }}</p>
        <ul class="flex flex-wrap gap-1">
          <span
            v-for="{ tag } in filteredTags(tags)"
            class="rounded-lg px-1.5 py-1 text-xs bg-opacity-25"
            :style="{ backgroundColor: `rgb(from #${invertedColorHex} r g b / 0.33)` }"
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
  transition: all 0.25s;
}

.flip-enter,
.flip-leave-to {
  transform: rotateY(-90deg);
}
</style>
