import { client } from "@/services/clients";
import { ref } from "vue";
import { useAuthStore } from "@/storage/auth";
import { useRouter } from "vue-router";

function requestHelper(url, method, clientOptions = {}) {
  const { token, removeToken } = useAuthStore();
  const router = useRouter();

  const isLoading = ref(true);
  const errorMessage = ref(null);
  const fetchedData = ref(null);

  const mergedOptions = {...{ authToken: token }, ...clientOptions };
  fetch(client(url, method, mergedOptions))
    .then((response) => {
      if (response.status === 401) {
        removeToken();
        router.push({ name: "login" });
      } else {
        return response.json().then((responseJson) => {
          const { error } = responseJson;
          if (response.status >= 400) {
            errorMessage.value = error;
          } else {
            fetchedData.value = responseJson;
          }
        });
      }
    })
    .catch(() => {
      errorMessage.value = "Something went wrong.";
    })
    .finally(() => {
      isLoading.value = false;
    });

  return { isLoading, errorMessage, fetchedData };
}

export { requestHelper };
