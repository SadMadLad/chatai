<script setup>
import { getQuizzes } from "@/services/apis/quiz";

const { isLoading, errorMessage, fetchedData } = getQuizzes();
</script>

<template>
  <h1>Quizzes Page</h1>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="errorMessage">Error</div>
  <div v-else>
    <div v-for="{ id, timed, timer } in fetchedData">
      <RouterLink :to="{ name: 'quiz', params: { id: id } }">
        {{ id }}
        {{ timed }}
        {{ timer }}
      </RouterLink>
    </div>
  </div>
</template>
