<script setup>
import Collection from "@/components/collection/Collection.vue";
import { CollectionStyler, FlashCardStyler } from "@/services/styler";
import { computed } from "vue";
import FavoriteButton from "@/components/favorite/FavoriteButton.vue";
import FlashCard from "@/components/flash_card/FlashCard.vue";
import { getCollection } from "@/services/apis/collection";
import Quiz from "@/components/quiz/Quiz.vue";
import { useRoute } from "vue-router";

const route = useRoute();
const flashCardStyler = new FlashCardStyler();
const collectionStyler = new CollectionStyler();

const { isLoading, error, fetchedData } = getCollection(route.params.id);

const collection = computed(() => fetchedData.value.collection);
const collections = computed(() => collection.value?.collections);
const flashCards = computed(() => collection.value?.flash_cards);
const quizzes = computed(() => collection.value?.quizzes);
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="error">Error</div>
  <section v-else :key="route.params.id">
    <div class="mx-8">
      <section class="flex flex-col items-center gap-2.5 mt-16 mb-12">
        <div class="flex flex-row gap-4 justify-center items-center">
          <h1 class="text-4xl font-extrabold text-center">{{ collection.title }}</h1>
          <FavoriteButton v-model:favorited="collection.favorited" v-model:favorites-count="collection.favorites_count"
            :has-favorites-count="true" :favoritable-id="collection.id" favoritable-type="Collection"
            style-class="text-rose-500" />
        </div>
        <p v-if="collection.description.isPresent()" class="text-xl text-center">
          {{ collection.description }}
        </p>
      </section>
      <div class="flex flex-col gap-6">
        <section v-if="collections.isEmpty() && quizzes.isEmpty() && flashCards.isEmpty()" class="text-center">
          The Collection is Empty
        </section>
        <section v-if="quizzes.isPresent()" class="@container flex flex-col gap-4">
          <h4 class="text-2xl font-bold">Quizzes</h4>
          <div class="@5xl:columns-4 @3xl:columns-3 @xl:columns-2 break-inside-avoid gap-4">
            <Quiz v-for="quiz in quizzes" v-bind="quiz" />
          </div>
        </section>
        <section v-if="flashCards.isPresent()" class="@container">
          <h4 class="text-2xl font-bold">Flash Cards</h4>
          <div class="my-4 @7xl:grid-cols-4 @4xl:grid-cols-3 @3xl:grid-cols-2 mx-4 grid grid-cols-1 gap-4">
            <FlashCard v-for="card in flashCards" :key="card.id" v-bind="card"
              :button-class="flashCardStyler.buttonClass(card)" :front-class="flashCardStyler.frontClass(card)"
              :tag-class="flashCardStyler.tagClass(card)" />
          </div>
        </section>
        <section v-if="collections.isPresent()" class="@container">
          <h4 class="text-2xl font-bold">Collections</h4>
          <div
            class="my-4 @7xl:grid-cols-4 @4xl:grid-cols-3 @3xl:grid-cols-2 mx-4 grid grid-cols-1 gap-4 place-items-center">
            <Collection v-for="collection in collections" v-bind="collection"
              :style-class="collectionStyler.displayClass(collection)"
              :tag-class="collectionStyler.tagClass(collection)" />
          </div>
        </section>
      </div>
    </div>
  </section>
</template>
