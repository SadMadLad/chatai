import { z } from "zod";

const loginSchema = z.object({
  email: z
    .string()
    .min(5, { message: "E-mail must be minimum 5 letter long" })
    .max(50, { message: "E-mail must be maximum 50 letters long" })
    .email({ message: "Invalid email" }),
  password: z
    .string()
    .min(6, { message: "Password must be at least 6 letters long" }),
  scope: z
    .string()
});

export default loginSchema;
