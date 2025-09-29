const express = require("express");
const router = express.Router();
const { authorizeByPermission, authorizeByRole } = require("../middleware/authorize");
const { PERMISSIONS, ROLES } = require("../auth/roles");

// Ver todos los empleados → Admin, Gerente RRHH y Asistente RRHH
router.get(
  "/",
  authorizeByPermission(PERMISSIONS.EMPLEADO_READ_ALL),
  (req, res) => res.json({ ok: true, recurso: "empleados:list" })
);

// Crear empleado → Admin y Asistente RRHH
router.post(
  "/",
  authorizeByPermission(PERMISSIONS.EMPLEADO_CREATE),
  (req, res) => res.status(201).json({ ok: true, recurso: "empleados:create" })
);

// Borrar empleado → solo Admin
router.delete(
  "/:id",
  authorizeByRole(ROLES.ADMIN),
  (req, res) => res.json({ ok: true, recurso: "empleados:delete" })
);

// GET por id (para probar en el navegador)
router.get("/:id", authorizeByPermission(PERMISSIONS.EMPLEADO_READ_ALL), (req, res) => {
  res.json({ ok: true, recurso: "empleados:get", id: req.params.id });
});

module.exports = router;
