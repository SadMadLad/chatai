<script setup>
import FlashCard from "@/components/flash_card/FlashCard.vue";
import { FlashCardStyler } from "@/services/styler";
import { getFlashCards } from "@/services/apis/flash_card";
import { computed } from "vue";

const { isLoading, error, fetchedData: flashCards } = getFlashCards();
const isFlashCardsEmpty = computed(
  () => flashCards.value === null || flashCards.value?.length === 0,
);

const flashCardStyler = new FlashCardStyler();
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="error">Error</div>
  <section v-else class="@container container my-8 w-full">
    <div v-if="isFlashCardsEmpty">No Flash Card found</div>
    <div
      v-else
      class="@7xl:grid-cols-4 @4xl:grid-cols-3 @3xl:grid-cols-2 mx-4 grid grid-cols-1 gap-4"
    >
      <FlashCard
        v-for="card in flashCards"
        :key="card.id"
        v-bind="card"
        :button-class="flashCardStyler.buttonClass(card)"
        :front-class="flashCardStyler.frontClass(card)"
        :tag-class="flashCardStyler.tagClass(card)"
      />
    </div>
  </section>
</template>
