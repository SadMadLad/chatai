import { defineStore } from "pinia";
import { ref } from "vue";

const useAuthStore = defineStore(
  "auth",
  () => {
    const avatarUrl = ref(null);
    const fullName = ref(null);
    const isAuthenticated = ref(false);
    const token = ref(null);

    function logout() {
      avatarUrl.value = null;
      fullName.value = null;
      isAuthenticated.value = false;
      token.value = null;
    }

    function login(newAvatarUrl, newFullName, newToken) {
      avatarUrl.value = newAvatarUrl;
      isAuthenticated.value = true;
      fullName.value = newFullName;
      token.value = newToken;
    }

    return { avatarUrl, isAuthenticated, fullName, token, logout, login };
  },
  { persist: true },
);

export { useAuthStore };
