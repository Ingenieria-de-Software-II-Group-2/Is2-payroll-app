const express = require("express");
const router = express.Router();
const { authorizeByPermission, authorizeByRole } = require("../middleware/authorize");
const { PERMISSIONS, ROLES } = require("../auth/roles");
const prisma = require("../prisma");

// Lista
router.get("/", authorizeByPermission(PERMISSIONS.EMPLEADO_READ_ALL), async (req, res) => {
  const empleados = await prisma.empleado.findMany({
    orderBy: { id_empleado: "asc" },
    select: { id_empleado: true, nombre: true, apellido: true, cedula: true, correo: true, telefono: true, fecha_ingreso: true }
  });
  res.json({ ok: true, empleados });
});

// Detalle
router.get("/:id", authorizeByPermission(PERMISSIONS.EMPLEADO_READ_ALL), async (req, res) => {
  const id = Number(req.params.id);
  const empleado = await prisma.empleado.findUnique({ where: { id_empleado: id } });
  if (!empleado) return res.status(404).json({ error: "Empleado no encontrado" });
  res.json({ ok: true, empleado });
});

// Crear
router.post("/", authorizeByPermission(PERMISSIONS.EMPLEADO_CREATE), async (req, res) => {
  const { nombre, apellido, cedula, correo, telefono, direccion, fecha_nacimiento, fecha_ingreso, afiliado_IPS, id_estado_civil } = req.body;
  const nuevo = await prisma.empleado.create({
    data: {
      nombre, apellido, cedula, correo, telefono, direccion,
      fecha_nacimiento: new Date(fecha_nacimiento),
      fecha_ingreso: new Date(fecha_ingreso),
      afiliado_IPS, id_estado_civil
    }
  });
  res.status(201).json({ ok: true, empleado: nuevo });
});

// Actualizar
router.put("/:id", authorizeByPermission(PERMISSIONS.EMPLEADO_UPDATE), async (req, res) => {
  const id = Number(req.params.id);
  try {
    const actualizado = await prisma.empleado.update({
      where: { id_empleado: id },
      data: {
        nombre: req.body.nombre,
        apellido: req.body.apellido,
        cedula: req.body.cedula,
        correo: req.body.correo,
        telefono: req.body.telefono,
        direccion: req.body.direccion,
        fecha_nacimiento: req.body.fecha_nacimiento ? new Date(req.body.fecha_nacimiento) : undefined,
        fecha_ingreso: req.body.fecha_ingreso ? new Date(req.body.fecha_ingreso) : undefined,
        afiliado_IPS: req.body.afiliado_IPS,
        id_estado_civil: req.body.id_estado_civil
      }
    });
    res.json({ ok: true, empleado: actualizado });
  } catch {
    res.status(404).json({ error: "Empleado no encontrado" });
  }
});

// Borrar (solo ADMIN)
router.delete("/:id", authorizeByRole(ROLES.ADMIN), async (req, res) => {
  const id = Number(req.params.id);
  try {
    await prisma.empleado.delete({ where: { id_empleado: id } });
    res.json({ ok: true, msg: "Empleado eliminado" });
  } catch {
    res.status(404).json({ error: "Empleado no encontrado" });
  }
});

module.exports = router; // <-- IMPORTANTE
