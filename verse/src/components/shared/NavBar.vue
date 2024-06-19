<script setup>
import { computed } from "vue";
import { useAuthStore } from "@/storage/auth";

const routerClass = "hover:text-secondary-500 transition-all duration-100 py-4";

const userIsAuthed = computed(() => {
  const { isAuthenticated } = useAuthStore();
  return isAuthenticated;
});
</script>

<template>
  <header
    class="text-primary-500 flex sticky top-0 backdrop-blur bg-opacity-40 flex-row items-center justify-between bg-white px-12 border-b shadow"
  >
    <div class="flex items-center gap-8">
      <RouterLink :to="{ name: 'home' }">
        <img src="/logo.png" class="h-10 w-auto" />
      </RouterLink>
      <nav class="flex gap-4 font-semibold items-center">
        <div class="flex flex-row gap-2.5">
          <RouterLink
            :class="routerClass"
            :to="{ name: 'home' }"
            activeClass="border-b-2 border-b-primary-500"
            >Home</RouterLink
          >
          <RouterLink
            :class="routerClass"
            :to="{ name: 'about' }"
            activeClass="border-b-2 border-b-primary-500"
            >About</RouterLink
          >
        </div>
        <div class="flex gap-4" v-if="userIsAuthed">
          <RouterLink
            :class="routerClass"
            :to="{ name: 'dashboard' }"
            activeClass="border-b-2 border-b-primary-500"
            >Dashboard
          </RouterLink>
          <RouterLink
            :class="routerClass"
            :to="{ name: 'quizzes' }"
            activeClass="border-b-2 border-b-primary-500"
            >Quizzes
          </RouterLink>
        </div>
      </nav>
    </div>
    <div>
      <div v-if="!userIsAuthed">
        <RouterLink
          class="text-white font-semibold hover:bg-secondary-500 bg-primary-500 rounded py-2 px-3.5"
          :to="{ name: 'login' }"
          >Login</RouterLink
        >
      </div>
    </div>
  </header>
</template>
