import { client } from "@/services/clients";
import { ref, reactive } from "vue";
import { useAuthStore } from "@/storage/auth";
import { useRouter } from "vue-router";

function requestHelper(url, method, clientOptions = {}) {
  const { token, removeToken } = useAuthStore();
  const router = useRouter();

  const isLoading = ref(true);
  const isError = ref(false);
  const fetchedData = ref(null);

  const mergedOptions = { ...{ authToken: token }, ...clientOptions };
  fetch(client(url, method, mergedOptions))
    .then((response) => {
      if (response.status === 401) {
        removeToken();
        router.push({ name: "login" });
      } else {
        return response.json().then((responseJson) => {
          if (response.status >= 400) {
            isError.value = true;
          } else {
            fetchedData.value = responseJson;
          }
        });
      }
    })
    .catch(() => {
      isError.value = true;
    })
    .finally(() => {
      isLoading.value = false;
    });

  return { isLoading, isError, fetchedData };
}

export { requestHelper };
