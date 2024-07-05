<script setup>
import { computed } from "vue";

defineProps({
  id: Number,
  cover_url: String,
  questions_count: Number,
  quiz_undertakings_count: Number,
  ratings_count: Number,
  title: String,
  total_rating: Number,
  tags: Array,
});

const quizUndertakingCountDisplay = computed(
  () => (count) => `${count} ${count === 1 ? "time" : "times"}`,
);
const quizQuestionsCountDisplay = computed(
  () => (count) => `${count} ${count === 1 ? "question" : "questions"}`,
);

const filteredTags = computed(
  () => (tags) => tags.filter((tag) => tag.tag_type === "display"),
);
</script>

<template>
  <div class="group mb-6 overflow-hidden rounded-lg border shadow-lg">
    <RouterLink :to="{ name: 'quiz', params: { id: id } }">
      <div v-if="cover_url" class="max-h-56 w-auto overflow-hidden">
        <img :src="cover_url" class="h-full w-full object-cover" />
      </div>
      <div class="p-6">
        <div class="flex flex-col gap-1">
          <h4 class="font-xl font-black group-has-[:hover]:text-lime-500">
            {{ title }}
          </h4>
          <p>The quiz has {{ quizQuestionsCountDisplay(questions_count) }}</p>
          <p class="text-xs">{{ total_rating / ratings_count }} / 5</p>
          <p class="text-xs">
            The quiz was taken
            {{ quizUndertakingCountDisplay(quiz_undertakings_count) }}.
          </p>
        </div>
        <div class="flex flex-wrap gap-2">
          <span
            v-for="{ tag, tag_type } in filteredTags(tags)"
            class="bg-primary-200 rounded-full px-3.5 py-1.5 text-xs font-semibold shadow-sm"
          >
            <span>
              {{ tag }}
            </span>
          </span>
        </div>
      </div>
    </RouterLink>
  </div>
</template>
