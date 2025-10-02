// backend/middleware/authorize.js
const { ROLE_PERMISSIONS } = require("../auth/roles");

function authorizeByPermission(...requiredPermissions) {
  return (req, res, next) => {
    try {
      const user = req.user;
      if (!user?.role) return res.status(401).json({ message: "No autenticado" });

      const userPerms = ROLE_PERMISSIONS[user.role] || [];
      const ok = requiredPermissions.every(p => userPerms.includes(p));

      console.log("[authorizeByPermission]", {
        role: user.role,
        requiredPermissions,
        userPerms,
        ok
      }); // <-- LOG

      if (!ok) return res.status(403).json({ message: "Acceso denegado" });
      next();
    } catch (e) {
      res.status(500).json({ message: "Error autorización", error: e.message });
    }
  };
}

function authorizeByRole(...allowedRoles) {
  return (req, res, next) => {
    const role = req.user?.role;
    console.log("[authorizeByRole]", { role, allowedRoles }); // <-- LOG
    if (!role) return res.status(401).json({ message: "No autenticado" });
    if (!allowedRoles.includes(role)) return res.status(403).json({ message: "Acceso denegado" });
    next();
  };
}

module.exports = { authorizeByPermission, authorizeByRole };