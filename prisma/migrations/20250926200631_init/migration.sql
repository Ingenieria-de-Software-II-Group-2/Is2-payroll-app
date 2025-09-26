-- CreateTable
CREATE TABLE "public"."categoria_salarial" (
    "id_categoria_salarial" SERIAL NOT NULL,
    "monto" INTEGER NOT NULL,

    CONSTRAINT "categoria_salarial_pkey" PRIMARY KEY ("id_categoria_salarial")
);

-- CreateTable
CREATE TABLE "public"."rol_usuario" (
    "id_rol_usuario" SERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "descripcion_rol" VARCHAR(50) NOT NULL,

    CONSTRAINT "rol_usuario_pkey" PRIMARY KEY ("id_rol_usuario")
);

-- CreateTable
CREATE TABLE "public"."nomina" (
    "id_nomina" SERIAL NOT NULL,
    "anho" INTEGER NOT NULL,
    "fecha_generacion" DATE NOT NULL,
    "estado" VARCHAR(20) NOT NULL,
    "mes" INTEGER NOT NULL,

    CONSTRAINT "nomina_pkey" PRIMARY KEY ("id_nomina")
);

-- CreateTable
CREATE TABLE "public"."tipo_concepto_salarial" (
    "id_concepto_salarial" SERIAL NOT NULL,
    "descripcion" VARCHAR(255) NOT NULL,

    CONSTRAINT "tipo_concepto_salarial_pkey" PRIMARY KEY ("id_concepto_salarial")
);

-- CreateTable
CREATE TABLE "public"."estado_civil" (
    "id_estado" SERIAL NOT NULL,
    "descripcion" VARCHAR(20) NOT NULL,

    CONSTRAINT "estado_civil_pkey" PRIMARY KEY ("id_estado")
);

-- CreateTable
CREATE TABLE "public"."departamento" (
    "id_departamento" SERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "ubicacion" VARCHAR(100) NOT NULL,

    CONSTRAINT "departamento_pkey" PRIMARY KEY ("id_departamento")
);

-- CreateTable
CREATE TABLE "public"."empleado" (
    "id_empleado" SERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "cedula" VARCHAR(15) NOT NULL,
    "apellido" VARCHAR(50) NOT NULL,
    "fecha_nacimiento" DATE NOT NULL,
    "correo" VARCHAR(50) NOT NULL,
    "fecha_ingreso" DATE NOT NULL,
    "telefono" VARCHAR(13) NOT NULL,
    "fecha_egreso" DATE,
    "direccion" VARCHAR(100) NOT NULL,
    "afiliado_IPS" BOOLEAN NOT NULL,
    "id_estado_civil" INTEGER NOT NULL,

    CONSTRAINT "empleado_pkey" PRIMARY KEY ("id_empleado")
);

-- CreateTable
CREATE TABLE "public"."concepto_salarial" (
    "id_concepto" SERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "recurrente" BOOLEAN NOT NULL,
    "afecta_IPS" BOOLEAN NOT NULL,
    "afecta_aguinaldo" BOOLEAN NOT NULL,
    "id_concepto_salarial" INTEGER NOT NULL,

    CONSTRAINT "concepto_salarial_pkey" PRIMARY KEY ("id_concepto")
);

-- CreateTable
CREATE TABLE "public"."cargo" (
    "id_cargo" SERIAL NOT NULL,
    "nombre_cargo" VARCHAR(50) NOT NULL,
    "departamento" VARCHAR(50) NOT NULL,
    "id_departamento" INTEGER NOT NULL,
    "Activo" BOOLEAN NOT NULL,
    "id_categoria_salarial" INTEGER NOT NULL,

    CONSTRAINT "cargo_pkey" PRIMARY KEY ("id_cargo")
);

-- CreateTable
CREATE TABLE "public"."usuario" (
    "id_usuario" SERIAL NOT NULL,
    "nombre_usuario" VARCHAR(50) NOT NULL,
    "estado" BOOLEAN NOT NULL,
    "clave" VARCHAR(255) NOT NULL,
    "id_rol_usuario" INTEGER NOT NULL,
    "id_empleado" INTEGER NOT NULL,

    CONSTRAINT "usuario_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "public"."detalle_nomina" (
    "id_detalle" SERIAL NOT NULL,
    "total_descuentos" DECIMAL(12,2) NOT NULL,
    "total_bonificaciones" DECIMAL(12,2) NOT NULL,
    "neto_a_cobrar" INTEGER NOT NULL,
    "creado_por" INTEGER NOT NULL,
    "id_nomina" INTEGER NOT NULL,
    "id_empleado" INTEGER NOT NULL,

    CONSTRAINT "detalle_nomina_pkey" PRIMARY KEY ("id_detalle")
);

-- CreateTable
CREATE TABLE "public"."detalle_nomina_concepto" (
    "id_detalle_conceptos" INTEGER NOT NULL,
    "monto" DECIMAL(12,2) NOT NULL,
    "id_concepto" INTEGER NOT NULL,
    "id_detalle" INTEGER NOT NULL,
    "origen" VARCHAR(10) NOT NULL,

    CONSTRAINT "detalle_nomina_concepto_pkey" PRIMARY KEY ("id_detalle_conceptos")
);

-- CreateTable
CREATE TABLE "public"."registro_acceso" (
    "id_registro" SERIAL NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "ip_origen" VARCHAR(15) NOT NULL,
    "accion" VARCHAR(255) NOT NULL,
    "fecha_hora" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "registro_acceso_pkey" PRIMARY KEY ("id_registro")
);

-- CreateTable
CREATE TABLE "public"."hijo" (
    "id_hijo" SERIAL NOT NULL,
    "nombre" VARCHAR(50) NOT NULL,
    "certificado_vida_residencia" TEXT NOT NULL,
    "fecha_vencimiento_certificado" DATE NOT NULL,
    "id_empleado" INTEGER NOT NULL,
    "discapacidad" BOOLEAN NOT NULL,
    "fecha_nacimiento" DATE NOT NULL,
    "certificado_nacimiento" TEXT NOT NULL,

    CONSTRAINT "hijo_pkey" PRIMARY KEY ("id_hijo")
);

-- CreateTable
CREATE TABLE "public"."historial_cargo" (
    "id_historial" SERIAL NOT NULL,
    "id_empleado" INTEGER NOT NULL,
    "Fecha_Inicio" DATE NOT NULL,
    "fecha_fin" DATE,
    "Salario_Asignado" INTEGER NOT NULL,
    "id_cargo" INTEGER NOT NULL,

    CONSTRAINT "historial_cargo_pkey" PRIMARY KEY ("id_historial")
);

-- CreateTable
CREATE TABLE "public"."concepto_empleado" (
    "id_concepto_empleado" SERIAL NOT NULL,
    "monto" DECIMAL(12,2) NOT NULL,
    "id_empleado" INTEGER NOT NULL,
    "observacion" VARCHAR(255) NOT NULL,
    "activo" BOOLEAN NOT NULL,
    "id_concepto" INTEGER NOT NULL,

    CONSTRAINT "concepto_empleado_pkey" PRIMARY KEY ("id_concepto_empleado")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuario_id_empleado_key" ON "public"."usuario"("id_empleado");

-- AddForeignKey
ALTER TABLE "public"."empleado" ADD CONSTRAINT "empleado_id_estado_civil_fkey" FOREIGN KEY ("id_estado_civil") REFERENCES "public"."estado_civil"("id_estado") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."concepto_salarial" ADD CONSTRAINT "concepto_salarial_id_concepto_salarial_fkey" FOREIGN KEY ("id_concepto_salarial") REFERENCES "public"."tipo_concepto_salarial"("id_concepto_salarial") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."cargo" ADD CONSTRAINT "cargo_id_departamento_fkey" FOREIGN KEY ("id_departamento") REFERENCES "public"."departamento"("id_departamento") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."cargo" ADD CONSTRAINT "cargo_id_categoria_salarial_fkey" FOREIGN KEY ("id_categoria_salarial") REFERENCES "public"."categoria_salarial"("id_categoria_salarial") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."usuario" ADD CONSTRAINT "usuario_id_rol_usuario_fkey" FOREIGN KEY ("id_rol_usuario") REFERENCES "public"."rol_usuario"("id_rol_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."usuario" ADD CONSTRAINT "usuario_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "public"."empleado"("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."detalle_nomina" ADD CONSTRAINT "detalle_nomina_creado_por_fkey" FOREIGN KEY ("creado_por") REFERENCES "public"."usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."detalle_nomina" ADD CONSTRAINT "detalle_nomina_id_nomina_fkey" FOREIGN KEY ("id_nomina") REFERENCES "public"."nomina"("id_nomina") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."detalle_nomina" ADD CONSTRAINT "detalle_nomina_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "public"."empleado"("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."detalle_nomina_concepto" ADD CONSTRAINT "detalle_nomina_concepto_id_concepto_fkey" FOREIGN KEY ("id_concepto") REFERENCES "public"."concepto_salarial"("id_concepto") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."detalle_nomina_concepto" ADD CONSTRAINT "detalle_nomina_concepto_id_detalle_fkey" FOREIGN KEY ("id_detalle") REFERENCES "public"."detalle_nomina"("id_detalle") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."registro_acceso" ADD CONSTRAINT "registro_acceso_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "public"."usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."hijo" ADD CONSTRAINT "hijo_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "public"."empleado"("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."historial_cargo" ADD CONSTRAINT "historial_cargo_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "public"."empleado"("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."historial_cargo" ADD CONSTRAINT "historial_cargo_id_cargo_fkey" FOREIGN KEY ("id_cargo") REFERENCES "public"."cargo"("id_cargo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."concepto_empleado" ADD CONSTRAINT "concepto_empleado_id_empleado_fkey" FOREIGN KEY ("id_empleado") REFERENCES "public"."empleado"("id_empleado") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."concepto_empleado" ADD CONSTRAINT "concepto_empleado_id_concepto_fkey" FOREIGN KEY ("id_concepto") REFERENCES "public"."concepto_salarial"("id_concepto") ON DELETE RESTRICT ON UPDATE CASCADE;
