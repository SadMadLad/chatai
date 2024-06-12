<script setup>
  import { client } from "@/services/clients";
  import { RailsRoutes } from "@/services/routes";
  import { reactive } from 'vue';
  import { useAuthStore } from "@/storage/auth";
  import { useRouter } from "vue-router";

  const loginData = reactive({
    email: null,
    password: null
  });
  const router = useRouter();

  async function handleLogin(event) {
    event.preventDefault();

    const { login } = useAuthStore();
    const { url, method } = RailsRoutes.login;
    const { email, password } = loginData;
    const response = await fetch(
      client(url, method, { body: { user: { email: email, password: password, scope: 'verse' } } }),
    );

    const {
      token,
      full_name,
      avatar_url,
    } = await response.json();

    if (token) {
      login(avatar_url, full_name, token);
      router.push({ name: 'dashboard' })
    }
  }
</script>

<template>
  <form @submit="handleLogin">
    <label for="email">Email: </label>
    <input class="border" id="email" type="email" v-model.trim="loginData.email"/>

    <hr />

    <label for="password">Password: </label>
    <input class="border" id="password" type="password" v-model="loginData.password" />

    <hr />

    <button type="submit">Login</button>
  </form>
</template>
