// prisma/test-client.js
const { PrismaClient } = require('@prisma/client');

const prisma = new PrismaClient();

async function main() {
  console.log("Probando conexión con Prisma Client...");

  // Intenta contar cuántos empleados hay (aunque la tabla esté vacía)
  const count = await prisma.empleado.count();
  console.log("Número de empleados en la BD:", count);

  console.log("✅ ¡Prisma Client está funcionando correctamente!");
}

main()
  .catch((e) => {
    console.error("❌ Error al usar Prisma Client:", e);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });