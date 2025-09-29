// backend/middleware/roleMiddleware.js

function checkRole(rolesPermitidos) {
  return (req, res, next) => {
    try {
      const user = req.user; // Esto debería estar cargado por el middleware de autenticación

      if (!user) {
        return res.status(401).json({ message: "Usuario no autenticado" });
      }

      if (!rolesPermitidos.includes(user.role)) {
        return res.status(403).json({ message: "Acceso denegado" });
      }

      next();
    } catch (error) {
      return res.status(500).json({ message: "Error en el middleware de roles" });
    }
  };
}

module.exports = checkRole;
