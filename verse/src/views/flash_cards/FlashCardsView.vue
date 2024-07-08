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
    basic: 'text-white font-bold rounded-xl shadow-xl',
    fancy: 'font-serif font-bold border border-8 font-bold',
    brutalism: 'font-cursive font-semibold text-white offset-box-shadow',
  }
  return cardFrontClasses[cardStyle];
}

function cardFrontStyle(cardStyle, color) {
  const cardFrontStyles = {
    basic: { backgroundColor: color, text: 'white' },
    fancy: { borderColor: color, color: color },
    brutalism: { backgroundColor: color, text: 'white' }, 
  }
  return cardFrontStyles[cardStyle];
}
</script>

<template>
  <div v-if="isLoading">Loading...</div>
  <div v-else-if="error">Error</div>
  <section v-else class="@container w-full">
    <div v-if="isFlashCardsEmpty">No Flash Card found</div>
    <div v-else class="@3xl:columns-3 @xl:columns-2 gap-4">
      <FlashCard
        v-for="card in flashCards"
        :key="card.id"
        v-bind="card"
        :front-class="cardFrontClass(card.card_style)"
        :front-style="cardFrontStyle(card.card_style, card.color)"
      />
    </div>
  </section>
</template>
