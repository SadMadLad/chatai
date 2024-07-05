<script setup>
import { computed } from "vue";

defineProps({
  id: Number,
  cover_url: String,
  questions_count: Number,
  quiz_undertakings_count: Number,
  ratings_count: Number,
  title: String,
  total_rating: Number,
  tags: Array,
});

const quizUndertakingCountDisplay = computed(
  () => (count) => `${count} ${count === 1 ? "time" : "times"}`,
);
const quizQuestionsCountDisplay = computed(
  () => (count) => `${count} ${count === 1 ? "question" : "questions"}`,
);

const filteredTags = computed(
  () => (tags) => tags.filter((tag) => tag.tag_type === "display"),
);
</script>

<template>
  <RouterLink :to="{ name: 'quiz', params: { id: id } }">
    <img :src="cover_url" />
    <div class="flex flex-col gap-1">
      <h4 class="font-xl font-black">{{ title }}</h4>
      <p>The quiz has {{ quizQuestionsCountDisplay(questions_count) }}</p>
      <p class="text-xs">{{ total_rating / ratings_count }} / 5</p>
      <p class="text-xs">
        The quiz was taken
        {{ quizUndertakingCountDisplay(quiz_undertakings_count) }}.
      </p>
    </div>
    <div class="flex flex-wrap gap-2">
      <span
        v-for="{ tag, tag_type } in filteredTags(tags)"
        class="bg-primary-200 rounded-full px-3.5 py-1.5 text-xs font-semibold shadow-sm"
      >
        <span>
          {{ tag }}
        </span>
      </span>
    </div>
  </RouterLink>
</template>
