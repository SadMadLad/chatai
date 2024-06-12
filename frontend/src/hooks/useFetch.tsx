import { useState, useEffect } from "react";

import { client } from "@/services/clients";
import { Method } from "@/types/UtilTypes";
import useAuthStore from "@/storage/useAuthStore";

export default function useFetch(url: string, method: Method) {
  const [fetchedData, setFetchedData] = useState<any>(null);
  const [isLoading, setIsLoading] = useState<boolean | null>(true);
  const [isSuccess, setIsSuccess] = useState<boolean | null>(null);

  const { authToken } = useAuthStore();

  useEffect(() => {
    const abortController = new AbortController();
    const signal = abortController.signal;

    fetch(client(url, method, { authToken: authToken }), { signal })
      .then((response) => response.json())
      .then((data) => {
        setFetchedData(data);
        setIsSuccess(true);
      })
      .catch(() => setIsSuccess(false))
      .finally(() => setIsLoading(false));

    return () => abortController.abort();
  }, [url]);

  return { fetchedData, isLoading, isSuccess };
}
