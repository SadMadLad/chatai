<script setup>
import { getQuizzes } from "@/services/apis/quiz";

const quizUndertakingCountDisplay = (count) =>
  `${count} ${count === 1 ? "time" : "times"}`;
const quizQuestionsCountDisplay = (count) =>
  `${count} ${count === 1 ? "question" : "questions"}`;

const { isLoading, isError, fetchedData } = getQuizzes();
</script>

<template>
  <h1>Quizzes Page</h1>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error</div>
  <div v-else class="flex flex-col gap-5">
    <div
      v-for="{
        id,
        questions_count,
        quiz_undertakings_count,
        ratings_count,
        title,
        total_rating,
        tags,
      } in fetchedData"
      class="rounded-lg border p-4"
    >
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
    </div>
  </div>
</template>
