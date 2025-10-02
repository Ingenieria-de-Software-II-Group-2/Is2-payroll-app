const express = require("express");
const router = express.Router();
const { authorizeByPermission } = require("../middleware/authorize");
const { PERMISSIONS } = require("../auth/roles");

// Generar nómina → Admin y Asistente RRHH
router.post(
  "/generar",
  authorizeByPermission(PERMISSIONS.NOMINA_GENERAR),
  (req, res) => res.json({ ok: true, recurso: "nomina:generar" })
);

// Ver detalle → Admin, Gerente RRHH, Asistente RRHH
router.get(
  "/:id",
  authorizeByPermission(PERMISSIONS.NOMINA_VER_DETALLE),
  (req, res) => res.json({ ok: true, recurso: "nomina:detalle", id: req.params.id })
);

module.exports = router;
