<script setup>
// import NavBar from "@/components/shared/NavBar.vue";
import SideBar from "@/components/shared/SideBar.vue";
</script>

<template>
  <nav
    class="mx-12 flex flex-row items-center justify-between text-sm font-semibold"
  >
    <div class="flex flex-row gap-8">
      <RouterLink :to="{ name: 'home' }">
        <img src="/logo.png" class="h-20 w-auto" />
      </RouterLink>
      <ul class="flex flex-row items-center gap-4">
        <li>
          <RouterLink
            :to="{ name: 'home' }"
            class="hover:text-primary-400"
            activeClass="text-primary-500"
            >Home</RouterLink
          >
        </li>
        <li>
          <RouterLink
            :to="{ name: 'about' }"
            class="hover:text-primary-400"
            activeClass="text-primary-500"
            >About</RouterLink
          >
        </li>
        <li>
          <RouterLink
            :to="{ name: 'explore' }"
            class="hover:text-primary-400"
            activeClass="text-primary-500"
            >Explore</RouterLink
          >
        </li>
      </ul>
    </div>
    <ul class="flex flex-row gap-8">
      <li>
        <RouterLink
          :to="{ name: 'login' }"
          class="hover:outline-primary-500 hover:text-primary-500 rounded-lg px-8 py-2.5 outline outline-2 -outline-offset-2 outline-black"
          >Login</RouterLink
        >
      </li>
      <li>
        <RouterLink
          :to="{ name: 'sign-up' }"
          class="hover:bg-primary-500 rounded-lg bg-black px-8 py-2.5 text-white -outline-offset-2"
          >Sign Up</RouterLink
        >
      </li>
    </ul>
  </nav>
  <SideBar />
  <main>
    <RouterView />
  </main>
</template>
