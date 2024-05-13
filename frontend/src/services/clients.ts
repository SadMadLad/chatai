function client(
  route: RequestInfo,
  method: string,
  body: Object | null | undefined = null,
  headerOptions: { [key: string]: string } | null = null,
  params: Record<string, string> | null | undefined = null,
) {
  const headers = new Headers();
  headers.append("Content-Type", "application/json");

  if (headerOptions) {
    Object.keys(headerOptions).forEach((key) => {
      headers.append(key, headerOptions[key]);
    });
  }

  const requestOptions: RequestInit = { method: method, headers: headers };
  if (method !== "GET") requestOptions.body = JSON.stringify(body);
  const fullRoute =
    route + `${params ? "?" + new URLSearchParams(params).toString() : ""}`;

  const request = new Request(fullRoute, requestOptions);
  return request;
}

export { client };
