<script setup>
import { PhClover, PhQuotes, PhSparkle } from "@phosphor-icons/vue";

const underlineClass =
  "decoration-primary-400 decoration-12 -underline-offset-6 decoration-no-skip-ink underline";
</script>

<template>
  <section class="my-24">
    <div class="flex flex-col items-center gap-6">
      <h4
        class="relative mx-6 w-full text-balance text-center text-2xl font-semibold md:w-2/3 md:text-3xl lg:w-3/5 lg:text-4xl"
      >
        The Best Collection of Quizzes for Your
        <span :class="underlineClass">Knowledge</span>,
        <span :class="underlineClass">Preparation</span> and
        <span :class="underlineClass">Enjoyment</span>
        <PhQuotes
          size="32"
          class="text-primary-500 absolute -top-10 right-12"
        />
        <PhSparkle
          size="32"
          class="text-primary-500 absolute -top-12 left-16"
        />
      </h4>
      <div
        class="relative mx-6 flex w-full flex-col items-center gap-2 text-center text-lg md:w-2/3 lg:w-3/5"
      >
        <p class="text-balance">
          Write your own quizzes, take any quiz, prepare and have a good time!
        </p>
        <RouterLink
          :to="{ name: 'quizzes' }"
          class="bg-primary-500 hover:bg-primary-400 rounded px-6 py-1.5 font-semibold text-white"
          >Explore Quizzes
        </RouterLink>
        <PhClover
          size="32"
          class="text-primary-500 absolute bottom-0 left-4 sm:left-20"
        />
      </div>
    </div>
  </section>
</template>
