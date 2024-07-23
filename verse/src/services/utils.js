import { client } from "@/services/clients";
import { ref, toValue, watchEffect } from "vue";
import { useAuthStore } from "@/storage/auth";
import { useRouter } from "vue-router";

function useFetch(url, method, clientOptions = {}) {
  const { token, logout } = useAuthStore();
  const router = useRouter();

  const error = ref(null);
  const fetchedData = ref(null);
  const isEmptyUrl = ref(null);
  const isLoading = ref(true);

  watchEffect(async () => {
    const urlValue = toValue(url);
    const clientOptionsValue = toValue(clientOptions);

    const mergedOptions = { ...{ authToken: token }, ...clientOptionsValue };

    error.value = null;
    fetchedData.value = null;
    isEmptyUrl.value = urlValue === null || urlValue.isBlank();
    isLoading.value = true;

    try {
      if (!isEmptyUrl.value) {
        const response = await fetch(client(urlValue, method, mergedOptions));
        if (response.status === 401) {
          logout();
          router.push({ name: "home" });
        } else {
          fetchedData.value = await response.json();
        }
      }
    } catch (e) {
      error.value = e;
    } finally {
      isLoading.value = false;
    }
  });

  return { isLoading, isEmptyUrl, error, fetchedData, router };
}

export { useFetch };
