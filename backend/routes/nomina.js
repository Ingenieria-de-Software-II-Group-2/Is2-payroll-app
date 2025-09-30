const express = require("express");
const router = express.Router();
const { authorizeByPermission } = require("../middleware/authorize");
const { PERMISSIONS } = require("../auth/roles");

router.post("/generar", authorizeByPermission(PERMISSIONS.NOMINA_GENERAR), (req, res) => {
  res.json({ ok: true, recurso: "nomina:generar" });
});

router.get("/:id", authorizeByPermission(PERMISSIONS.NOMINA_VER_DETALLE), (req, res) => {
  res.json({ ok: true, recurso: "nomina:detalle", id: req.params.id });
});

module.exports = router;
