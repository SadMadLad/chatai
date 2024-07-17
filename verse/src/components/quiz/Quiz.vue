<script setup>
import FavoriteButton from "@/components/favorite/FavoriteButton.vue";
import { computed, ref } from "vue";
import RatingStar from "@/components/shared/RatingStar.vue";

const { favorited } = defineProps({
  id: Number,
  cover_url: String,
  favorited: Boolean,
  questions_count: Number,
  quiz_undertakings_count: Number,
  ratings_count: Number,
  title: String,
  total_rating: Number,
  total_score: Number,
  tags: Array,
});

const isFavorited = ref(favorited);

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
  <div class="relative mb-6 overflow-hidden rounded-lg border shadow-lg">
    <div>
      <span class="absolute right-6 top-6">
        <FavoriteButton
          v-model:favorited="isFavorited"
          :favoritable-id="id"
          :has-favorites-count="false"
          favoritable-type="Quiz"
          style-class="text-rose-500"
        />
      </span>
      <div v-if="cover_url" class="max-h-56 w-auto overflow-hidden">
        <img :src="cover_url" class="h-full w-full object-cover" />
      </div>
      <div
        :class="`${!(cover_url && cover_url.isPresent()) ? 'mt-8' : ''} flex flex-col gap-2.5 p-6`"
      >
        <div class="flex flex-col gap-1">
          <RouterLink :to="{ name: 'quiz', params: { id: id } }">
            <h4 class="font-xl font-black hover:text-lime-500">
              {{ title }}
            </h4>
          </RouterLink>
          <p class="text-sm">
            <span class="text-primary-600 font-semibold">{{
              questions_count
            }}</span>
            {{ quizQuestionsCountDisplay(questions_count) }}
          </p>
          <p class="text-sm">
            Maximum Achievable Score is
            <span class="text-primary-600 font-semibold">{{
              total_score
            }}</span>
          </p>
          <p class="text-xs">
            Taken
            {{ quizUndertakingCountDisplay(quiz_undertakings_count) }}.
          </p>
          <span
            v-if="ratings_count > 0"
            class="flex flex-row items-center gap-1"
          >
            <RatingStar
              :id="id"
              :percentage="((total_rating / ratings_count) * 100) / 5"
              :size="20"
            />
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
    </div>
  </div>
</template>
