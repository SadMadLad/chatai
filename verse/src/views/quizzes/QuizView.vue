<script setup>
import { computed } from "vue";
import { useRoute } from "vue-router";
import { getQuiz } from "@/services/apis/quiz";

const route = useRoute();

const { isLoading, error, fetchedData: fetchedQuiz } = getQuiz(route.params.id);
const quiz = computed(() => fetchedQuiz.value?.quiz);
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="error">Error</div>
  <div v-else>
    {{ quiz.title }}
    {{ quiz.cover_url }}
    {{ quiz.description }}
    {{ quiz.questions_count }}
    <hr />
    <RouterLink :to="{ name: 'quiz-undertaking', params: { id: quiz?.id } }"
      >Take the Quiz</RouterLink
    >
  </div>
</template>
