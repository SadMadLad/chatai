<script setup>
import { computed, ref, reactive } from "vue";
import { stringify } from "qs";

import { getTags } from "@/services/apis/tag";
import { PhSlidersHorizontal } from "@phosphor-icons/vue";
import { RailsRoutes } from "@/services/routes";
import { useFetch } from "@/services/utils";

import CurrentQuizFilters from "@/components/quiz/CurrentQuizFilters.vue";
import Quiz from "@/components/quiz/Quiz.vue";
import QuizFiltersSidebar from "@/components/quiz/QuizFiltersSidebar.vue";

const { url, method } = RailsRoutes.quizzes;

// Refs
const isFilterSidebarOpen = ref(true);

const searchParams = reactive({
  search: { title_like: null, tags: [] },
});
const currentSearchParams = reactive({
  search: { title_like: null, tags: [] },
});
const quizzesUrl = ref(queryParams());

// Fetching Data
const { isLoading, error, fetchedData: quizzes } = useFetch(quizzesUrl, method);

const {
  isLoading: areTagsLoading,
  error: errorWhenLoadingTags,
  fetchedData: tags,
} = getTags();

// Computed
const isQuizzesEmpty = computed(
  () => quizzes.value === null || quizzes.value?.length === 0,
);
const resultsText = computed(
  () => (resultCount) =>
    `${resultCount} ${resultCount === 1 ? "result" : "results"}`,
);

// Methods
function queryParams() {
  return url(stringify({ ...searchParams }, { arrayFormat: "brackets" }));
}

function handleSearch() {
  quizzesUrl.value = queryParams();

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
  removeTag(filter_tag);
  handleSearch();
}

function addTag(tag) {
  const currentSearchTags = [...searchParams.search.tags];
  currentSearchTags.unshift(tag);

  const selectedTagsSet = new Set(currentSearchTags);
  const tagsSet = new Set(tags.value);

  tags.value = [...tagsSet.difference(selectedTagsSet)];
  searchParams.search.tags = [...selectedTagsSet];
}

function removeTag(tag) {
  tags.value.unshift(tag);
  tags.value = tags.value.unique();

  searchParams.search.tags = searchParams.search.tags.filter((t) => t !== tag);
}
</script>

<template>
  <div class="flex flex-col items-center sm:flex-row sm:items-start">
    <Transition name="filters">
      <QuizFiltersSidebar
        v-show="isFilterSidebarOpen"
        :are-tags-loading="areTagsLoading"
        :error-when-loading-tags="errorWhenLoadingTags"
        :search-params="searchParams"
        :tags="tags"
        @add-tag="addTag"
        @handle-search="handleSearch"
        @remove-tag="removeTag"
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
      <p v-if="quizzes?.length" class="mb-2 text-right">
        {{ resultsText(quizzes.length) }}
      </p>
      <div v-if="isLoading">Loading...</div>
      <div v-else-if="error">Error</div>
      <div
        v-else
        class="@5xl:columns-4 @3xl:columns-3 @xl:columns-2 break-inside-avoid gap-4"
      >
        <div v-if="isQuizzesEmpty">No Quizzes Found</div>
        <div v-else>
          <Quiz v-for="quiz in quizzes" v-bind="quiz" />
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped>
.filters-enter-from {
  opacity: 0;
}

.filters-enter-active,
.filters-leave-active {
  transition: all 0.25s ease;
}

.filters-enter-from,
.filters-leave-to {
  opacity: 0;
}
</style>
