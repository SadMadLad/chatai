<script setup>
import FlashCard from "@/components/flash_card/FlashCard.vue";
import { getFlashCards } from "@/services/apis/flash_card";
import { computed } from "vue";

const { isLoading, error, fetchedData: flashCards } = getFlashCards();
const isFlashCardsEmpty = computed(
  () => flashCards.value === null || flashCards.value?.length === 0,
);

function cardFrontClass(cardStyle) {
  const cardFrontClasses = {
    basic: "text-white font-bold rounded-xl shadow-xl",
    fancy: "font-serif font-bold border border-8 font-bold",
    brutalism: "font-cursive font-semibold text-white offset-box-shadow",
  };

  return cardFrontClasses[cardStyle];
}

function cardFrontStyle(cardStyle, color) {
  const cardFrontStyles = {
    basic: { backgroundColor: color, color: "white" },
    fancy: { borderColor: color, color: color },
    brutalism: { backgroundColor: color, color: "white" },
  };

  return cardFrontStyles[cardStyle];
}

function cardFlipButtonClass(cardStyle) {
  const cardFlipButtonClasses = {
    basic: "font-sans hover:bg-white/30",
    fancy: "font-serif hover:bg-black/10",
    brutalism: "font-cursive hover:bg-white/30",
  };

  return `px-2 py-1 text-sm rounded border-2 font-bold ${cardFlipButtonClasses[cardStyle]}`;
}
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
        :button-class="cardFlipButtonClass(card.card_style)"
        :front-class="cardFrontClass(card.card_style)"
        :front-style="cardFrontStyle(card.card_style, card.color)"
      />
    </div>
  </section>
</template>
