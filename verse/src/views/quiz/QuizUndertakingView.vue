<script setup>
import { computed, ref, watch } from "vue";
import { getNewQuizUndertaking, createQuizUndertaking } from "@/services/apis/quiz";
import Question from "@/components/quiz/Question.vue";
import { useQuizStore } from "@/storage/quiz";
import { useRoute } from "vue-router";

const route = useRoute();
const quizStore = useQuizStore();

const isResultLoading = ref(true);
const isResultError = ref(null);
const fetchedResultData = ref(null);

const { getAllSelectedOptions, initializeQuizzesArray } = quizStore;
const { isLoading, isError, fetchedData } = getNewQuizUndertaking(route.params.id);

const quiz = computed(() => fetchedData.value?.quiz);
const questions = computed(() => fetchedData.value?.quiz?.questions);

const currentQuestionIndex = ref(0);
const isFinished = ref(false);

watch(fetchedData, (data) => {
  if (data) {
    initializeQuizzesArray(data.quiz.questions);
  }
});

watch(isFinished, async (finished) => {
  if (finished) {
    const { isLoading: isRLoading, isError: isRError, fetchedData: fetchedRData } =
      await createQuizUndertaking(route.params.id, getAllSelectedOptions());

    isResultLoading.value = isRLoading.value;
    isResultError.value = isRError.value;
    fetchedResultData.value = fetchedRData;
  }
});
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error...</div>
  <div v-else>
    <div v-if="isFinished">
      <div v-if="isResultLoading">
        The Quiz is finished. Now I am fetching results.
      </div>
      <div v-else-if="isResultError">
        Error while calculating your result.
      </div>
      <div>
        {{ fetchedResultData }}
      </div>
    </div>
    <div v-else>
      <h2 class="text-2xl font-black">{{ quiz.title }}</h2>
      <div>{{ currentQuestionIndex + 1 }} / {{ questions.length }}</div>

      <Question v-bind="questions[currentQuestionIndex]" :index="currentQuestionIndex" :key="currentQuestionIndex" />

      <hr />

      <div class="flex gap-4">
        <button @click="currentQuestionIndex = Math.max(currentQuestionIndex - 1, 0)">
          Back
        </button>
        <button @click="
          currentQuestionIndex = Math.min(
            currentQuestionIndex + 1,
            questions.length - 1,
          )
          ">
          Next
        </button>
      </div>

      <hr />

      <button @click="isFinished = true">Finish</button>
    </div>
  </div>
</template>
