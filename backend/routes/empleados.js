// backend/routes/empleados.js
const express = require("express");
const router = express.Router();
const { authorizeByPermission, authorizeByRole } = require("../middleware/authorize");
const { PERMISSIONS, ROLES } = require("../auth/roles");

// LISTAR → Admin, Gerente, Asistente
router.get("/", authorizeByPermission(PERMISSIONS.EMPLEADO_READ_ALL), (req, res) =>
  res.json({ ok: true, recurso: "empleados:list" })
);

// CREAR → Admin, Asistente
router.post("/", authorizeByPermission(PERMISSIONS.EMPLEADO_CREATE), (req, res) =>
  res.status(201).json({ ok: true, recurso: "empleados:create", body: req.body })
);

// **ACTUALIZAR** → usa el permiso que tengas definido (ajusta el nombre si difiere)
router.put(
  "/:id",
  authorizeByPermission(PERMISSIONS.EMPLEADO_UPDATE), // o EMPLEADO_EDIT si así lo llamaste
  (req, res) => {
    const { id } = req.params;
    res.json({ ok: true, recurso: "empleados:update", id, body: req.body });
  }
);

// BORRAR → solo Admin
router.delete("/:id", authorizeByRole(ROLES.ADMIN), (req, res) =>
  res.json({ ok: true, recurso: "empleados:delete", id: req.params.id })
);

// GET por id (para probar en navegador)
router.get("/:id", authorizeByPermission(PERMISSIONS.EMPLEADO_READ_ALL), (req, res) =>
  res.json({ ok: true, recurso: "empleados:get", id: req.params.id })
);

module.exports = router;
