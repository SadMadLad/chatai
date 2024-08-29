<script setup>
import { PhCards, PhCaretLineLeft, PhCaretLineRight, PhChalkboard, PhGear, PhSealQuestion, PhStack } from "@phosphor-icons/vue";
import { ref } from "vue";

const isOpen = ref(true);

const navLinks = [
  {
    name: 'dashboard',
    text: 'Dashboard',
    icon: PhChalkboard
  },
  {
    name: 'quizzes-dashboard',
    text: 'Quizzes',
    icon: PhSealQuestion
  },
  {
    name: 'flash-cards-dashboard',
    text: 'Flash Cards',
    icon: PhCards
  },
  {
    name: 'collections-dashboard',
    text: 'Collections',
    icon: PhStack
  },
  {
    name: 'settings-dashboard',
    text: 'Settings',
    icon: PhGear
  }
];
</script>

<template>
  <aside class="flex-shrink-0 transition-all" :class="{ 'w-44': isOpen, 'w-11 overflow-hidden': !isOpen }">
    <button class="hover:bg-gray-50 rounded mr-2.5 p-2 my-2.5" @click="isOpen = !isOpen">
      <PhCaretLineLeft :size="20" v-if="isOpen" />
      <PhCaretLineRight :size="20" v-if="!isOpen" />
    </button>
    <ul class="flex flex-col gap-2.5">
      <li v-for="{ name, text, icon } in navLinks">
        <RouterLink :to="{ name: name }" class="flex flex-row gap-4 items-center px-3 py-2 transition-all duration-200"
          exactActiveClass="text-white font-semibold text-white bg-primary-500 rounded">
          <span>
            <component :is="icon" :size="20" />
          </span>
          <span class="whitespace-nowrap">{{ text }}</span>
        </RouterLink>
      </li>
    </ul>
  </aside>
</template>
