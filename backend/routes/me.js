const express = require("express");
const router = express.Router();
const { authorizeByPermission } = require("../middleware/authorize");
const { PERMISSIONS } = require("../auth/roles");

router.get("/profile", authorizeByPermission(PERMISSIONS.SELF_EDIT_PERFIL), (req, res) => {
  res.json({ ok: true, profile: { id: req.user.id, nombre: "Empleado Demo", cedula: "5.555.555", cargo: "Analista", fecha_ingreso: "2023-02-01" } });
});

router.get("/paystubs", authorizeByPermission(PERMISSIONS.SELF_VER_RECIBOS), (req, res) => {
  res.json({ ok: true, paystubs: [{ id: "2025-08", periodo: "Agosto 2025", neto: 3500000 }, { id: "2025-09", periodo: "Septiembre 2025", neto: 3550000 }] });
});

module.exports = router;
