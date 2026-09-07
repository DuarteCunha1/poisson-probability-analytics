import { Hono } from "@hono/hono";
import { client } from "./source/database/server.ts";

const app = new Hono();

app.get("/", (c) => {
  return c.text("Olá do servidor Deno com Hono! 🚀");
});

if (import.meta.main) {
  try {
    const testClient = await client.connect();
    testClient.release();
    console.log("Base de dados conectada com sucesso!");

    Deno.serve({ port: 8000 }, app.fetch);
    console.log("Servidor a correr em http://localhost:8000");
  } catch (err) {
    console.error("Erro ao iniciar o servidor:", err);
  }
}
