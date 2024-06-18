<script setup>
import { computed } from "vue";
import { useAuthStore } from "@/storage/auth";

const routerClass = "hover:underline transition-colors duration-300";

const userIsAuthed = computed(() => {
  const { isAuthenticated } = useAuthStore();
  return isAuthenticated;
});
</script>

<template>
  <header
    class="text-primary-500 flex flex-row items-center justify-between bg-white px-12 py-2.5"
  >
    <div class="flex items-center gap-8">
      <img src="/logo.png" class="h-10 w-10" />
      <nav class="flex gap-4 font-semibold">
        <div class="flex flex-row gap-2.5">
          <RouterLink
            :class="routerClass"
            :to="{ name: 'home' }"
            activeClass="text-secondary-300"
            >Home</RouterLink
          >
          <RouterLink
            :class="routerClass"
            :to="{ name: 'about' }"
            activeClass="text-secondary-300"
            >About</RouterLink
          >
        </div>
        <div class="flex gap-4" v-if="userIsAuthed">
          <RouterLink
            :class="routerClass"
            :to="{ name: 'dashboard' }"
            activeClass="text-secondary-300"
            >Dashboard
          </RouterLink>
          <RouterLink
            :class="routerClass"
            :to="{ name: 'quizzes' }"
            activeClass="text-secondary-300"
            >Quizzes
          </RouterLink>
        </div>
      </nav>
    </div>
    <div>
      <div v-if="!userIsAuthed">
        <RouterLink
          class="text-white font-semibold bg-primary-500 rounded py-2 px-3.5"
          :to="{ name: 'login' }"
          >Login</RouterLink
        >
      </div>
    </div>
  </header>
</template>
