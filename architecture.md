
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



## Principios que cumple nuestro sistema
Arquitectura en Capas	Sí	3 capas claras: Frontend (Next.js), Lógica de Negocio (API Routes + controllers), Datos (Prisma + PostgreSQL)
Separación de Responsabilidades	Sí	Cada carpeta tiene una función clara: frontend/ (UI), backend/api/ (endpoints), controllers/          (lógica)   models/ (BD)
Modularidad	Sí	Módulos independientes: Empleados, Nómina, Conceptos, Reportes. Cada uno puede desarrollarse por separado.
Cohesión Alta	Sí	Cada módulo agrupa funcionalidades relacionadas. Ej: nominaController.js solo maneja cálculo de nómina.
Acoplamiento Bajo	Sí	Los módulos se comunican por API REST, sin depender del código interno del otro.
Escalabilidad	Sí	Sistema desplegado en Vercel (serverless) + PostgreSQL en Neon ? escala automáticamente.
Seguridad por Diseño	Sí	Autenticación con JWT, cifrado con bcrypt, validación de roles en frontend y backend, protección contra SQLi/XSS.

Mantenibilidad	Sí	Estructura clara, documentación (README.md, ARCHITECTURE.md), uso de JIRA y Git.
Configurabilidad	Sí	Salario mínimo vigente y conceptos salariales se pueden configurar sin hardcodear.
Usabilidad y Accesibilidad	Sí	Interfaz web responsive. Cada rol ve solo lo que le corresponde (empleado, asistente, admin, etc.).
Persistencia de Datos	Sí	Uso de PostgreSQL (relacional) con historial de salarios, hijos, conceptos, recibos y salario mínimo por año.
