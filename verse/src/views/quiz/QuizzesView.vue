<script setup>
import { computed, ref, reactive } from "vue";
import { stringify } from "qs";

import CurrentQuizFilters from "@/components/quiz/CurrentQuizFilters.vue";
import { PhSlidersHorizontal } from "@phosphor-icons/vue";
import QuizFiltersSidebar from "@/components/quiz/QuizFiltersSidebar.vue";
import { RailsRoutes } from "@/services/routes";
import { useFetch } from "@/services/utils";

import Quiz from "@/components/quiz/Quiz.vue";

const { url, method } = RailsRoutes.quizzes;

const searchParams = reactive({ search: { title_like: null, tags: [] } });
const currentSearchParams = reactive({
  search: { title_like: null, tags: [] },
});

const quizzesUrl = ref(url());
const isFilterSidebarOpen = ref(true);

const { isLoading, error, fetchedData } = useFetch(quizzesUrl, method);

const isQuizzesEmpty = computed(
  () => fetchedData.value === null || fetchedData.value?.length === 0,
);

function handleSearch() {
  quizzesUrl.value = url(
    stringify({ ...searchParams }, { arrayFormat: "brackets" }),
  );

  currentSearchParams.search = { ...searchParams.search };
}

function removeFilter(filter_param) {
  searchParams.search[filter_param] = null;
  handleSearch();
}

function removeTagFilter(filter_tag) {
  searchParams.search.tags = searchParams.search.tags.filter(
    (t) => t !== filter_tag,
  );
  handleSearch();
}
</script>

<template>
  <section class="flex flex-col items-center sm:flex-row sm:items-start">
    <Transition name="filters">
      <QuizFiltersSidebar
        v-if="isFilterSidebarOpen"
        :search-params="searchParams"
        @handle-search="handleSearch"
      />
    </Transition>
    <div class="@container w-full flex-grow px-8">
      <button
        @click="isFilterSidebarOpen = !isFilterSidebarOpen"
        class="text-primary-500 border-primary-500 relative top-0 z-10 mb-4 flex items-center gap-2 rounded border bg-white px-3 py-1.5 shadow-lg backdrop-blur-md sm:sticky sm:top-12 md:top-20"
      >
        <PhSlidersHorizontal :size="20" />
        Filters
      </button>
      <CurrentQuizFilters
        v-bind="currentSearchParams.search"
        @remove-filter="removeFilter"
        @remove-tag-filter="removeTagFilter"
      />
      <div v-if="isLoading">Loading...</div>
      <div v-else-if="error">Error</div>
      <div v-else class="@3xl:columns-3 @xl:columns-2 break-inside-avoid gap-4">
        <div v-if="isQuizzesEmpty">No Quizzes Found</div>
        <div v-else>
          <Quiz v-for="quiz in fetchedData" v-bind="quiz" />
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.filters-enter-active,
.filters-leave-active {
  transition: opacity 0.25s ease;
}

.filters-enter-from,
.filters-leave-to {
  opacity: 0;
  position: absolute;
}
</style>
