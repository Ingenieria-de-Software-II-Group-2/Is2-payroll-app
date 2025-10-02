const { ROLES } = require("../auth/roles");

module.exports = function mockUser(role = ROLES.ASISTENTE_RRHH) {
  return (req, _res, next) => {
    req.user = { id: 1, role };
    console.log("[mockUser] role =", role); // <-- LOG
    next();
  };
};