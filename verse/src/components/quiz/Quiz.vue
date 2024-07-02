<script setup>
defineProps({
  id: Number,
  questions_count: Number,
  quiz_undertakings_count: Number,
  ratings_count: Number,
  title: String,
  total_rating: Number,
  tags: Array,
});

const quizUndertakingCountDisplay = (count) =>
  `${count} ${count === 1 ? "time" : "times"}`;
const quizQuestionsCountDisplay = (count) =>
  `${count} ${count === 1 ? "question" : "questions"}`;
</script>

<template>
  <RouterLink :to="{ name: 'quiz', params: { id: id } }">
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
        v-for="{ tag, color } in tags"
        :style="{ backgroundColor: '#' + color }"
        class="rounded-full px-3.5 py-1.5 text-xs font-semibold"
      >
        {{ tag }}
      </span>
    </div>
  </RouterLink>
</template>
