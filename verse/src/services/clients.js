import { stringify } from "qs";

function client(route, method, clientOptions) {
  // Prepare headers
  const headers = new Headers();
  headers.append("Content-Type", "application/json");

  // Append Auth Token in headers if provided
  const authToken = clientOptions.authToken;
  if (authToken) headers.append("Authorization", `Bearer ${authToken}`);

  // Append other headers
  const headerOptions = clientOptions.headers;
  if (headerOptions) {
    Object.keys(headerOptions).forEach((key) =>
      headers.append(key, headerOptions[key]),
    );
  }

  // Configure params and the body
  const { body } = clientOptions;
  const requestOptions = { method: method, headers: headers };
  if (method !== "GET") requestOptions.body = JSON.stringify(body);

  const request = new Request(route, requestOptions);
  return request;
}

export { client };
