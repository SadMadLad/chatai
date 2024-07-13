import { client } from "@/services/clients";
import { ref, toValue, watchEffect } from "vue";
import { useAuthStore } from "@/storage/auth";
import { useRouter } from "vue-router";

function useFetch(url, method, clientOptions = {}) {
  const { token, logout } = useAuthStore();
  const router = useRouter();

  const isLoading = ref(true);
  const error = ref(null);
  const fetchedData = ref(null);

  watchEffect(async () => {
    const urlValue = toValue(url);
    const clientOptionsValue = toValue(clientOptions);

    const mergedOptions = { ...{ authToken: token }, ...clientOptionsValue };

    isLoading.value = true;
    error.value = null;
    fetchedData.value = null;

    try {
      const response = await fetch(client(urlValue, method, mergedOptions));
      if (response.status === 401) {
        logout();
        router.push({ name: "home" });
      } else {
        fetchedData.value = await response.json();
      }
    } catch (e) {
      error.value = e;
    } finally {
      isLoading.value = false;
    }
  });

  return { isLoading, error, fetchedData };
}

export { useFetch };
