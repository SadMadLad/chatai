<script setup>
  import { useRoute } from "vue-router";
  import { getQuiz } from "@/services/apis/quiz";

  const route = useRoute();

  const { isLoading, error, fetchedData } = getQuiz(route.params.id);
</script>

<template>
  {{ $route.params.id }}
</template>
