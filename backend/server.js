const express = require("express");
const cors = require("cors");
const { ROLES } = require("./auth/roles");
const mockUser = require("./middleware/mockUser");

const empleadosRoutes = require("./routes/empleados");
const nominaRoutes = require("./routes/nomina");

const app = express();
app.use(cors());
app.use(express.json());

// Simular usuario logueado (cambiá el rol acá para probar)
//app.use(mockUser(ROLES.ASISTENTE_RRHH));
app.use(mockUser(ROLES.ADMIN));
// app.use(mockUser(ROLES.GERENTE_RRHH));
// app.use(mockUser(ROLES.EMPLEADO));

// Prefijos de API
app.use("/api/empleados", empleadosRoutes);
app.use("/api/nomina", nominaRoutes);

// Healthcheck
app.get("/health", (_req, res) => res.json({ status: "ok" }));

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => console.log(`API escuchando en http://localhost:${PORT}`));



