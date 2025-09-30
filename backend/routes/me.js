const express = require("express");
const router = express.Router();
const { authorizeByPermission, authorizeByRole } = require("../middleware/authorize");
const { PERMISSIONS, ROLES } = require("../auth/roles");

// Opción: toda la sección /me solo para EMPLEADO (descomenta si querés)
// router.use(authorizeByRole(ROLES.EMPLEADO));

// Perfil del usuario logueado (mock)
router.get(
  "/profile",
  authorizeByPermission(PERMISSIONS.SELF_EDIT_PERFIL),
  (req, res) => {
    const mockProfile = { id: req.user.id, nombre: "Empleado Demo", cedula: "5.555.555", cargo: "Analista", fecha_ingreso: "2023-02-01" };
    res.json({ ok: true, profile: mockProfile });
  }
);

// Recibos del usuario logueado (mock)
router.get(
  "/paystubs",
  authorizeByPermission(PERMISSIONS.SELF_VER_RECIBOS),
  (req, res) => {
    const paystubs = [
      { id: "2025-08", periodo: "Agosto 2025", neto: 3500000 },
      { id: "2025-09", periodo: "Septiembre 2025", neto: 3550000 },
    ];
    res.json({ ok: true, paystubs });
  }
);

module.exports = router;
