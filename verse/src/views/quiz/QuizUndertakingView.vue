<script setup>
import { computed } from "vue";
import { useRoute } from "vue-router";
import { getQuizUndertaking } from "@/services/apis/quiz";

const route = useRoute();

const { isLoading, isError, fetchedData } = getQuizUndertaking(route.params.id);

const quiz = computed(() => fetchedData.value?.quiz);
const questions = computed(() => fetchedData.value?.quiz?.questions);

console.log(questions)

</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error...</div>
  <div v-else>
    <h2 class="text-2xl font-black">{{ quiz.title }}</h2>
    {{ questions }}
  </div>
</template>
