<script setup>
import { PhX } from "@phosphor-icons/vue";

defineProps({
  title_like: String,
  tags: Array,
});

const tagClass =
  "bg-primary-300 flex cursor-pointer flex-row items-center gap-0.5 rounded-full px-3 py-1 text-xs";

defineEmits(["removeFilter", "removeTagFilter"]);
</script>

<template>
  <div class="mb-2 flex flex-wrap gap-2">
    <span
      v-if="title_like && title_like.isPresent()"
      :class="tagClass"
      @click="$emit('removeFilter', 'title_like')"
    >
      <PhX size="12" /><span>{{ title_like }}</span>
    </span>
    <span
      v-for="tag in tags"
      :class="tagClass"
      @click="$emit('removeTagFilter', tag)"
    >
      <PhX size="12" /><span>{{ tag }}</span>
    </span>
  </div>
</template>
