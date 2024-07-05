<script setup>
import Quiz from "@/components/quiz/Quiz.vue";
import { getQuizzes } from "@/services/apis/quiz";

const { isLoading, isError, fetchedData } = getQuizzes();
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error</div>
  <div v-else class="grid grid-cols-3">
    <Quiz v-for="quiz in fetchedData" v-bind="quiz" />
  </div>
</template>
