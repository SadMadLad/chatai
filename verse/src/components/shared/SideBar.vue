<script setup>
import { ref } from "vue";
import {
  PhBinoculars,
  PhHouse,
  PhKey,
  PhList,
  PhQuestion,
  PhSignIn,
} from "@phosphor-icons/vue";

const navLinks = [
  {
    name: "home",
    text: "Home",
    icon: PhHouse,
  },
  {
    name: "about",
    text: "About",
    icon: PhQuestion,
  },
  {
    name: "explore",
    text: "Explore",
    icon: PhBinoculars,
  },
  {
    name: "login",
    text: "Login",
    icon: PhSignIn,
  },
  {
    name: "sign-up",
    text: "Sign Up",
    icon: PhKey,
  },
];

const isOpen = ref(false);
</script>

<template>
  <div @click="isOpen = true"><PhList :size="20" /></div>
  <Transition name="sidebar">
    <div
      v-if="isOpen"
      @click.stop="isOpen = false"
      class="fixed left-0 top-0 z-10 h-screen w-screen bg-black bg-opacity-50"
    ></div>
  </Transition>
  <Transition name="sidebar">
    <aside v-if="isOpen" class="fixed left-0 top-0 z-20 h-screen bg-white p-4">
      <button @click="isOpen = false">Close</button>
      <nav>
        <ul class="flex w-32 flex-col gap-4">
          <li v-for="{ name, text, icon } in navLinks" class="flex gap-2.5">
            <RouterLink
              :to="{ name: name }"
              @click.stop="isOpen = false"
              class="flex w-full flex-row items-center gap-2 rounded px-2.5 py-0.5"
              activeClass="bg-primary-500 text-white"
              ><component :is="icon" /><span>{{ text }}</span></RouterLink
            >
          </li>
        </ul>
      </nav>
    </aside>
  </Transition>
</template>

<style scoped>
.sidebar-enter-active,
.sidebar-leave-active {
  transition: opacity 0.25s ease;
}

.sidebar-enter-from,
.sidebar-leave-to {
  opacity: 0;
}
</style>
