import { db } from "../server.ts";
import { accounts } from "../schemas/schemas.ts";

export async function main() {
    console.log("Iniciando o seed das accounts...");

    const seedData = [
        {
            account: "Active",
            description: "Conta ativa.",
        },
        {
            account: "Suspended",
            description: "Conta suspensa.",
        },
        {
            account: "Cancelled",
            description: "Conta cancelada.",
        },
    ];
    try {
        for (const item of seedData) {
            await db.insert(accounts).values(item).onConflictDoNothing({ target: accounts.account });
            console.log(`Conta '${item.account}' adicionado com sucesso.`);
        }
        console.log("Seed finalizada com sucesso!");
    } catch (error) {
        console.error("Erro ao executar o seed:", error);
        Deno.exit(1);
    }
}
