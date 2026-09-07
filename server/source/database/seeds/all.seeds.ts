import { main as seedAccounts } from "./account.seeds.ts";
import { main as seedRoles } from "./role.seeds.ts";

async function runSeeds() {
    console.log("🚀 Iniciando o processo de seeding...");

    try {
        await seedAccounts();
        console.log("✅ Accounts seed concluído.");

        await seedRoles();
        console.log("✅ Roles seed concluído.");

        console.log("🎉 Todos os seeds foram executados com sucesso!");
    } catch (error) {
        console.error("❌ Erro ao executar os seeds:", error);
        process.exit(1);
    }
}

await runSeeds();
