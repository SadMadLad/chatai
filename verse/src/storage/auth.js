import { defineStore } from "pinia";
import { ref } from "vue";

export const useAuthStore = defineStore("auth", () => {
  const avatarUrl = ref(null);
  const isAuthenticated = ref(false);
  const fullName = ref(null);
  const token = ref(null);

  function logout() {
    avatarUrl.value = null;
    isAuthenticated.value = false;
    fullName.value = null;
    token.value = null;
  }

  function login(newAvatarUrl, newFullName, newToken) {
    avatarUrl.value = newAvatarUrl;
    fullName.value = newFullName;
    token.value = newToken;
  }

  return { avatarUrl, isAuthenticated, fullName, token, logout, login };
});
