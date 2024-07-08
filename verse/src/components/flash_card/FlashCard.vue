<script setup>
defineProps({
  id: Number,
  answer: String,
  color: String,
  frontClass: String,
  frontStyle: Object,
  prompt: String,
  card_style: String,
})
</script>

<template>
  <div class="break-inside-avoid flex-center max-w-56 min-h-72 mx-auto mb-6 p-4" :class="frontClass" :style="frontStyle">
    <p class="text-xl text-center">{{ prompt }}</p>
  </div>
</template>
