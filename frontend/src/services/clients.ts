function client(
  route: RequestInfo,
  method: string,
  body: Object | null | undefined = null,
  headerOptions: { [key: string]: string } | null = null,
) {
  const headers = new Headers();
  headers.append("Content-Type", "application/json");

  if (headerOptions) {
    Object.keys(headerOptions).forEach((key) => {
      headers.append(key, headerOptions[key]);
    });
  }

  const request = new Request(route, {
    method: method,
    headers: headers,
    body: JSON.stringify(body),
  });

  return request;
}

export { client };
