// app/api/auth/login/route.js

import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcrypt';

const prisma = new PrismaClient();

export async function POST(request) {
  try {
    const { username, password } = await request.json();

    // 1. Validar que se envíen ambos campos
    if (!username || !password) {
      return Response.json(
        { error: 'Usuario y contraseña son requeridos' },
        { status: 400 }
      );
    }

    // 2. Buscar el usuario por nombre de usuario
    const usuario = await prisma.usuario.findUnique({
      where: { nombre_usuario: username },
      include: {
        empleado: true,
        rol_usuario: true
      }
    });

    // 3. Verificar si el usuario existe
    if (!usuario) {
      return Response.json(
        { error: 'Usuario o contraseña incorrectos' },
        { status: 401 }
      );
    }

    // 4. Verificar si el usuario está activo
    if (!usuario.estado) {
      return Response.json(
        { error: 'El usuario está inactivo' },
        { status: 401 }
      );
    }

    // 5. Comparar la contraseña con bcrypt
    const isPasswordValid = await bcrypt.compare(password, usuario.clave);

    if (!isPasswordValid) {
      return Response.json(
        { error: 'Usuario o contraseña incorrectos' },
        { status: 401 }
      );
    }

    // 6. ✅ Login exitoso
    // En producción: genera un JWT real con `jsonwebtoken`
    // Por ahora, usamos un token simulado (lo reemplazaremos después)
    const token = `jwt.${usuario.id_usuario}.${Date.now()}`;

    return Response.json({
      token,
      user: {
        id: usuario.id_usuario,
        username: usuario.nombre_usuario,
        role: usuario.rol_usuario.nombre,
        empleado: {
          id: usuario.empleado.id_empleado,
          nombre: usuario.empleado.nombre,
          apellido: usuario.empleado.apellido,
          cedula: usuario.empleado.cedula
        }
      }
    });
  } catch (error) {
    console.error('Error en login:', error);
    return Response.json(
      { error: 'Error del servidor' },
      { status: 500 }
    );
  }
}