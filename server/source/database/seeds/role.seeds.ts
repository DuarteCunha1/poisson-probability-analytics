import { db } from "../server.ts";
import { roles } from "../schemas/schemas.ts";

export async function main() {
    console.log("Iniciando o seed das roles...");

    const seedData = [
        {
            role: "Guest",
            description: "Usuário não autenticado com acesso limitado.",
        },
        {
            role: "User",
            description: "Usuário padrão com acesso às funcionalidades básicas.",
        },
        {
            role: "Admin",
            description: "Administrador com acesso total ao sistema.",
        },
    ];
    try {
        for (const item of seedData) {
            await db.insert(roles).values(item).onConflictDoNothing({ target: roles.role });
            console.log(`Role '${item.role}' adicionado com sucesso.`);
        }
        console.log("Seed finalizada com sucesso!");
    } catch (error) {
        console.error("Erro ao executar o seed:", error);
        Deno.exit(1);
    }
}
