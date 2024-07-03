import { defineStore } from "pinia";
import { ref } from "vue";

const useAuthStore = defineStore(
  "auth",
  () => {
    const avatarUrl = ref(null);
    const fullName = ref(null);
    const isAuthenticated = ref(false);
    const token = ref(null);
    const username = ref(null);

    function logout() {
      avatarUrl.value = null;
      fullName.value = null;
      isAuthenticated.value = false;
      token.value = null;
      username.value = null;
    }

    function login(newAvatarUrl, newFullName, newToken, newUsername) {
      avatarUrl.value = newAvatarUrl;
      isAuthenticated.value = true;
      fullName.value = newFullName;
      token.value = newToken;
      username.value = newUsername;
    }

    return { avatarUrl, isAuthenticated, fullName, token, logout, login };
  },
  { persist: true },
);

export { useAuthStore };
