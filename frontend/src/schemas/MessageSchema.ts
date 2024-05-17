import { z } from "zod";

const MessageSchema = z.object({
  content: z.string().trim().min(1, { message: "Content must be present" }),
});

export default MessageSchema;
