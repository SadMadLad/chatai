<script setup>
import { ref } from "vue";
import { PhSlidersHorizontal, PhX } from "@phosphor-icons/vue";

import Quiz from "@/components/quiz/Quiz.vue";
import { getQuizzes } from "@/services/apis/quiz";

const { isLoading, isError, fetchedData } = getQuizzes();

const isFilterSidebarOpen = ref(true);
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="isError">Error</div>
  <section v-else class="flex flex-col items-center sm:flex-row sm:items-start">
    <Transition name="filters">
      <aside
        v-if="isFilterSidebarOpen"
        class="relative top-0 w-60 flex-shrink-0 sm:sticky sm:top-12 md:top-20"
      >
        <div class="overflow-auto px-4">
          <div class="flex justify-between">
            <h4 class="text-xl font-bold">Filters</h4>
            <button @click="isFilterSidebarOpen = false">
              <PhX size="16" />
            </button>
          </div>
        </div>
      </aside>
    </Transition>
    <div class="@container w-full flex-grow px-8">
      <button
        @click="isFilterSidebarOpen = !isFilterSidebarOpen"
        class="text-primary-500 border-primary-500 relative top-0 z-10 mb-4 flex items-center gap-2 rounded border bg-white px-3 py-1.5 shadow-lg backdrop-blur-md sm:sticky sm:top-12 md:top-20"
      >
        <PhSlidersHorizontal :size="20" />
        Filters
      </button>
      <div class="@3xl:columns-3 @xl:columns-2 break-inside-avoid gap-4">
        <Quiz v-for="quiz in fetchedData" v-bind="quiz" />
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
