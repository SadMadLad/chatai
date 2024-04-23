export default function client(
  route: RequestInfo,
  method: string,
  body: Object | null | undefined = null,
) {
  const headers = new Headers();
  headers.append("Content-Type", "application/json");

  const request = new Request(route, {
    method: method,
    headers: headers,
    body: JSON.stringify(body),
  });

  return request;
}
