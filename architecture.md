
---

## 🛠️ Tecnologías Utilizadas

| Capa | Tecnología | Justificación |
|------|-----------|-------------|
| **Frontend** | Next.js (App Router) | Framework React optimizado para SSR, SEO y despliegue en Vercel |
| **Backend** | Next.js API Routes | Permite usar un solo stack; compatible con Vercel y serverless |
| **Base de Datos** | PostgreSQL en [Neon.tech](https://neon.tech) | Gratis, en la nube, compatible con Prisma y Vercel |
| **ORM** | Prisma | Facilita consultas seguras, migraciones y tipado |
| **Autenticación** | JWT + bcrypt | Seguro, sin estado, ideal para serverless |
| **Despliegue** | Vercel | Integración nativa con Next.js, rápido y confiable |


---

## 📁 Estructura del Proyecto

```bash
sistema-nomina-ingesoft/
├── package.json
├── next.config.js
├── .gitignore
├── README.md
├── ARCHITECTURE.md        # ← Este archivo
│
├── frontend/
│   ├── pages/
│   │   ├── index.js       # Login
│   │   ├── dashboard.js   # Dashboard por rol
│   │   ├── empleados/     # CRUD empleados
│   │   ├── nomina/        # Cálculo y recibos
│   │   └── reportes/      # Dashboards y exportación
│   ├── components/
│   │   ├── ProtectedRoute.js  # Rutas por rol
│   │   └── Recibo.js      # Vista detallada
│   ├── public/
│   └── styles/
│
├── backend/
│   ├── api/
│   │   ├── auth/
│   │   │   └── login.js
│   │   ├── empleados/
│   │   ├── nomina/
│   │   └── recibos/
│   ├── controllers/
│   │   ├── empleadoController.js
│   │   ├── nominaController.js
│   │   └── reciboController.js
│   ├── utils/
│   │   ├── calcularBonificacion.js
│   │   ├── calcularIPS.js
│   │   └── numeroALetras.js
│   └── models/
│       └── db.js          # Prisma Client
│
├── prisma/
│   ├── schema.prisma      # Modelo de datos (DER)
│   └── migrations/        # Migraciones versionadas
│
├── docs/
│   ├── arquitectura.png
│   ├── flujo.png
│   └── der.png
│
└── .env.local            