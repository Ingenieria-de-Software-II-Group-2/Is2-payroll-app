// app/api/test/route.js

import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export async function GET() {
  try {
    const empleados = await prisma.empleado.findMany({
      include: {
        historial_cargos: {
          include: {
            cargo: true
          },
          where: {
            fecha_fin: null // Solo el cargo actual
          }
        },
        usuario: true,
        estado_civil: true
      }
    });

    // Aplanar el resultado para tener `cargo` directamente
    const resultado = empleados.map(emp => ({
      ...emp,
      cargo: emp.historial_cargos.length > 0 ? emp.historial_cargos[0].cargo : null,
      historial_cargos: undefined // opcional: remover si no lo necesitas
    }));

    return Response.json(resultado);
  } catch (error) {
    console.error('Error al obtener empleados:', error);
    return Response.json(
      { error: 'Error del servidor', details: error.message },
      { status: 500 }
    );
  } finally {
    await prisma.$disconnect();
  }
}