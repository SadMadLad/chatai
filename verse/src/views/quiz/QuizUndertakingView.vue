<script setup>
import { computed, reactive, ref, watch, Transition } from "vue";
import {
  getNewQuizUndertaking,
  createQuizUndertaking,
} from "@/services/apis/quiz";
import Question from "@/components/quiz/Question.vue";
import { useAuthStore } from "@/storage/auth";
import { useQuizStore } from "@/storage/quiz";
import { useRoute, useRouter } from "vue-router";

const route = useRoute();
const router = useRouter();
const { removeToken } = useAuthStore();

const result = reactive({
  isResultLoading: true,
  isResultError: null,
  score: null,
});

const { getAllSelectedOptions, initializeQuizzesArray } = useQuizStore();
const { isLoading, isError, fetchedData } = getNewQuizUndertaking(
  route.params.id,
);

const quiz = computed(() => fetchedData.value?.quiz);
const questions = computed(() => fetchedData.value?.quiz?.questions);

const currentQuestionIndex = ref(0);
const isFinished = ref(false);

watch(fetchedData, (data) => {
  if (data) initializeQuizzesArray(data.quiz.questions);
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
            const { score } = jsonResponse;
            result.score = score;
          });
        }
      })
      .catch(() => (result.isResultError = true))
      .finally(() => (result.isResultLoading = false));
  }
});
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error...</div>
  <div v-else>
    <div v-if="isFinished">
      <div v-if="result.isResultLoading">
        The Quiz is finished. Now I am fetching results.
      </div>
      <div v-else-if="result.isResultError">
        Error while calculating your result.
      </div>
      <div v-else>
        {{ result.score }}
        <RouterLink :to="{ name: 'quiz', params: { id: route.params.id } }"
          >Re-take the quiz</RouterLink
        >
      </div>
    </div>
    <div v-else>
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
  transition: opacity 0.5s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  position: absolute;
}
</style>
