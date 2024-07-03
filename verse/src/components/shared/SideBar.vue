<script setup>
import { ref } from "vue";
import {
  PhHouse,
  PhKey,
  PhList,
  PhQuestion,
  PhRanking,
  PhSealQuestion,
  PhSignIn,
  PhX,
} from "@phosphor-icons/vue";

defineProps({
  userIsAuthed: Boolean,
});

const emit = defineEmits(["logout"]);

const authEnum = {
  publicOnly: 1,
  privateOnly: 2,
  both: 3,
};

const navLinks = [
  {
    name: "home",
    text: "Home",
    icon: PhHouse,
    auth: authEnum.both,
  },
  {
    name: "about",
    text: "About",
    icon: PhQuestion,
    auth: authEnum.both,
  },
  {
    name: "quizzes",
    text: "Quizzes",
    icon: PhSealQuestion,
    auth: authEnum.both,
  },
  {
    name: "dashboard",
    text: "Dashboard",
    icon: PhRanking,
    auth: authEnum.privateOnly,
  },
  {
    name: "login",
    text: "Login",
    icon: PhSignIn,
    auth: authEnum.publicOnly,
  },
  {
    name: "sign-up",
    text: "Sign Up",
    icon: PhKey,
    auth: authEnum.publicOnly,
  },
];

const isOpen = ref(false);

function handleLogout() {
  emit("logout");
  isOpen.value = false;
}
</script>

<template>
  <div @click="isOpen = true">
    <PhList :size="20" />
  </div>
  <Transition name="sidebar">
    <div
      v-if="isOpen"
      @click.stop="isOpen = false"
      class="fixed left-0 top-0 h-screen w-screen bg-black bg-opacity-50"
    ></div>
  </Transition>
  <Transition name="sidebar">
    <aside v-if="isOpen" class="fixed left-0 top-0 h-screen bg-white p-4">
      <button class="absolute right-2.5 top-2.5" @click.stop="isOpen = false">
        <PhX />
      </button>
      <div class="flex-center mb-8">
        <img src="/logo.png" class="h-14 w-auto" />
      </div>
      <nav>
        <ul class="flex w-32 flex-col gap-2.5">
          <li
            v-for="{ name, text, icon, auth } in navLinks"
            class="flex gap-2.5"
          >
            <RouterLink
              v-if="
                auth === authEnum.both ||
                (auth === authEnum.publicOnly && !userIsAuthed) ||
                (auth === authEnum.privateOnly && userIsAuthed)
              "
              :to="{ name: name }"
              @click.stop="isOpen = false"
              class="flex w-full flex-row items-center gap-2 rounded px-2.5 py-1.5"
              activeClass="bg-primary-500 text-white"
            >
              <component :is="icon" /><span>{{ text }}</span>
            </RouterLink>
          </li>
          <li v-if="userIsAuthed" class="flex gap-2.5">
            <button
              @click="handleLogout"
              class="flex w-full flex-row items-center gap-2 rounded px-2.5 py-1.5"
            >
              Logout
            </button>
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
