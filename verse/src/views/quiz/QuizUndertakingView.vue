<script setup>
import { computed, onUnmounted, reactive, ref, Transition, watch } from "vue";
import {
  getNewQuizUndertaking,
  createQuizUndertaking,
} from "@/services/apis/quiz";

import { useAuthStore } from "@/storage/auth";
import { useQuizStore } from "@/storage/quiz";
import { useRoute, useRouter } from "vue-router";

import CorrectedQuiz from "@/components/quiz/CorrectedQuestion.vue";
import Question from "@/components/quiz/Question.vue";

// Hooks
const route = useRoute();
const router = useRouter();
const { removeToken } = useAuthStore();

// Initial Data
const { getAllSelectedOptions, initializeQuizzesArray } = useQuizStore();
const { isLoading, isError, fetchedData } = getNewQuizUndertaking(
  route.params.id,
);

// Refs
const countdownTimer = ref(null);
const currentQuestionIndex = ref(0);
const isFinished = ref(false);
const timer = ref(null);

// Reactives
const quizResult = reactive({
  isResultLoading: true,
  isResultError: null,
  score: null,
  correctedQuiz: null,
  showCorrectAnswers: false,
});

// Computed Values
const isTimed = computed(() => fetchedData.value?.quiz?.timed);
const questions = computed(() => fetchedData.value?.quiz?.questions);
const quiz = computed(() => fetchedData.value?.quiz);
const quizResultText = computed(() =>
  quizResult.showCorrectAnswers ? "Hide" : "Show",
);

// Watchers
watch(fetchedData, (data) => {
  if (data) {
    initializeQuizzesArray(data.quiz.questions);
    if (data.quiz.timer) {
      timer.value = data.quiz.timer;
      countdownTimer.value = setInterval(() => timer.value--, 1000);
    }
  }
});

watch(isFinished, async (finished) => {
  if (finished) {
    createQuizUndertaking(route.params.id, getAllSelectedOptions())
      .then((response) => {
        if (response.status == 401) {
          removeToken();
          router.push({ name: "login" });
        } else {
          return response.json().then((jsonResponse) => {
            const { score, quiz } = jsonResponse;
            quizResult.score = score;
            quizResult.correctedQuiz = quiz;
          });
        }
      })
      .catch(() => (quizResult.isResultError = true))
      .finally(() => (quizResult.isResultLoading = false));
    if (isTimed) clearInterval(countdownTimer.value);
  }
});

watch(timer, async (timerValue) => {
  if (timerValue && timerValue <= 0) isFinished.value = true;
});

// Lifecycle Methods
onUnmounted(() => {
  if (countdownTimer.value) {
    clearInterval(countdownTimer.value);
    countdownTimer.value = null;
  }
});
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error...</div>
  <div v-else>
    <div v-if="isFinished">
      <div v-if="quizResult.isResultLoading">
        The Quiz is finished. Now I am fetching results.
      </div>
      <div v-else-if="quizResult.isResultError">
        Error while calculating your result.
      </div>
      <div v-else>
        {{ quizResult.score }}
        <RouterLink :to="{ name: 'quiz', params: { id: route.params.id } }"
          >Re-take the quiz</RouterLink
        >
        <button
          @click="
            quizResult.showCorrectAnswers = !quizResult.showCorrectAnswers
          "
        >
          {{ quizResultText }} Correct Answers
        </button>

        <div v-if="quizResult.showCorrectAnswers">
          <div v-for="(question, index) in quizResult.correctedQuiz.questions">
            <CorrectedQuiz v-bind="question" :index="index" />
          </div>
        </div>
      </div>
    </div>
    <div v-else>
      {{ timer }}

      <ul class="flex flex-wrap items-center justify-center gap-1.5">
        <li
          v-for="index in questions.length"
          class="flex-center h-8 w-8 cursor-pointer overflow-hidden rounded-full text-sm"
          :class="{
            'bg-green-500 font-semibold text-white':
              currentQuestionIndex === index - 1,
          }"
          @click="currentQuestionIndex = index - 1"
        >
          {{ index }}
        </li>
      </ul>

      <h2 class="text-2xl font-black">{{ quiz.title }}</h2>
      <div>{{ currentQuestionIndex + 1 }} / {{ questions.length }}</div>

      <Transition name="fade">
        <Question
          v-bind="questions[currentQuestionIndex]"
          :index="currentQuestionIndex"
          :key="currentQuestionIndex"
        />
      </Transition>

      <hr />

      <div class="flex gap-4">
        <button
          @click="currentQuestionIndex = Math.max(currentQuestionIndex - 1, 0)"
        >
          Back
        </button>
        <button
          @click="
            currentQuestionIndex = Math.min(
              currentQuestionIndex + 1,
              questions.length - 1,
            )
          "
        >
          Next
        </button>
      </div>

      <hr />

      <button @click="isFinished = true">Finish</button>
    </div>
  </div>
</template>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  position: absolute;
}
</style>
