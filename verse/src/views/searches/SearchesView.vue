<script setup>
import { computed, reactive, ref } from "vue";
import FlashCard from "@/components/flash_card/FlashCard.vue";
import { FlashCardStyler } from "@/services/styler";
import { RailsRoutes } from "@/services/routes";
import Quiz from "@/components/quiz/Quiz.vue";
import { stringify } from "qs";
import { useFetch } from '@/services/utils';

const flashCardStyler = new FlashCardStyler();

const searchParams = reactive({
  recommendation_search: {
    search_text: null
  }
});

const { url, method } = RailsRoutes.searches;
const recommendationsUrl = ref(queryParams());

const { isLoading, error, fetchedData } = useFetch(recommendationsUrl, method);

const recommendations = computed(() => fetchedData.value?.recommendations)
const flashCards = computed(() => recommendations.value?.flash_cards);
const quizzes = computed(() => recommendations.value?.quizzes);

function queryParams() {
  return url(stringify({ ...searchParams }, { arrayFormat: "brackets" }));
}

function handleSubmit() {
  recommendationsUrl.value = queryParams();
}
</script>

<template>
  <h1 class="text-4xl font-black text-center mx-4 my-12">Check Out our AI Search and get recommended resources</h1>
  <section class="flex-center">
      <form class="flex flex-row gap-2.5 items-center">
        <input class="px-2 h-10 border border-gray-400 focus:outline-primary-500 rounded-lg w-80" placeholder="Query your search" v-model="searchParams.recommendation_search.search_text"/>
        <button @click="handleSubmit" :disabled="isLoading || error" class="inline-block rounded-xl text-white font-bold px-3.5 py-2.5 bg-primary-500 hover:bg-primary-400 disabled:bg-primary-200">Send</button>
      </form>
    </section>
  <span v-if="isLoading">isLoading</span>
  <span v-else-if="error">Error</span>
  <section v-else class="mx-8">
    <section v-if="quizzes && quizzes.isPresent()" class="@container flex flex-col gap-4">
      <h4 class="text-2xl font-bold">Quizzes</h4>
      <div class="@5xl:columns-4 @3xl:columns-3 @xl:columns-2 break-inside-avoid gap-4">
        <Quiz v-for="quiz in quizzes" v-bind="quiz" />
      </div>
    </section>
    <section v-if="flashCards && flashCards.isPresent()" class="@container">
      <h4 class="text-2xl font-bold">Flash Cards</h4>
      <div class="my-4 @7xl:grid-cols-4 @4xl:grid-cols-3 @3xl:grid-cols-2 mx-4 grid grid-cols-1 gap-4">
        <FlashCard v-for="card in flashCards" :key="card.id" v-bind="card"
          :button-class="flashCardStyler.buttonClass(card)" :front-class="flashCardStyler.frontClass(card)"
          :tag-class="flashCardStyler.tagClass(card)" />
      </div>
    </section>
  </section>
</template>
