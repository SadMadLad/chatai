<script setup>
import { computed } from "vue";
import RatingStar from "@/components/shared/RatingStar.vue";

defineProps({
  id: Number,
  cover_url: String,
  questions_count: Number,
  quiz_undertakings_count: Number,
  ratings_count: Number,
  title: String,
  total_rating: Number,
  total_score: Number,
  tags: Array,
});

const quizUndertakingCountDisplay = computed(
  () => (count) => `${count} ${count === 1 ? "time" : "times"}`,
);
const quizQuestionsCountDisplay = computed(
  () => (count) => `${count === 1 ? "question" : "questions"}`,
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
      <div class="p-6 flex flex-col gap-2.5">
        <div class="flex flex-col gap-1">
          <h4 class="font-xl font-black group-has-[:hover]:text-lime-500">
            {{ title }}
          </h4>
          <p class="text-sm"><span class="font-semibold text-primary-600">{{ questions_count }}</span> {{ quizQuestionsCountDisplay(questions_count) }}</p>
          <p class="text-sm">Maximum Achievable Score is <span class="font-semibold text-primary-600">{{ total_score }}</span></p>
          <p class="text-xs">
            Taken
            {{ quizUndertakingCountDisplay(quiz_undertakings_count) }}.
          </p>
          <span v-if="ratings_count > 0" class="flex flex-row items-center gap-1">
            <RatingStar :id="id" :percentage="(total_rating / ratings_count)*100 / 5" :size="20"/>
            <span class="text-sm">{{ total_rating / ratings_count }}</span>
          </span>
        </div>
        <div class="flex flex-wrap gap-2">
          <span
            v-for="{ tag } in filteredTags(tags)"
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
