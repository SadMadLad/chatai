<script setup>
import { getQuizzes } from "@/services/apis/quiz";

const { isLoading, isError, fetchedData } = getQuizzes();
</script>

<template>
  <h1>Quizzes Page</h1>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error</div>
  <div v-else>
    <div v-for="{ id, title } in fetchedData">
      <RouterLink :to="{ name: 'quiz', params: { id: id } }">
        {{ title }}
      </RouterLink>
    </div>
  </div>
</template>
