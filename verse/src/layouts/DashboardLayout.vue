<script setup>
import { PhCards, PhChalkboard, PhSealQuestion, PhStack } from "@phosphor-icons/vue";

const navLinks = [
  {
    name: 'dashboard',
    text: 'Dashboard',
    icon: PhChalkboard
  },
  {
    name: 'flash-cards-dashboard',
    text: 'Flash Cards',
    icon: PhCards
  },
  {
    name: 'quizzes-dashboard',
    text: 'Quizzes',
    icon: PhSealQuestion
  },
  {
    name: 'collections-dashboard',
    text: 'Collections',
    icon: PhStack
  }
];
</script>

<template>
  <main class="flex flex-row">
    <aside class="w-40">
      <ul class="flex flex-col gap-2.5">
        <li v-for="{ name, text, icon } in navLinks">
          <RouterLink
            :to="{ name: name }"
            class="flex flex-row gap-4 items-center px-3 py-2.5 transition-all duration-200"
            exactActiveClass="text-white font-semibold text-white bg-primary-500 rounded"
          >
            <span><component :is="icon" :size="20"/></span>
            <span>{{ text }}</span>
          </RouterLink>
        </li>
      </ul>
    </aside>
    <section class="flex-grow">
      <RouterView />
    </section>
  </main>
</template>
