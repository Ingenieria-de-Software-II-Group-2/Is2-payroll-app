"use client"; // necesario para usar hooks

import { useEffect, useState } from "react";

export default function MiPerfil() {
  const [profile, setProfile] = useState(null);
  const [paystubs, setPaystubs] = useState([]);

  useEffect(() => {
    fetch("http://localhost:4000/api/me/profile")
      .then(res => res.json())
      .then(data => setProfile(data.profile));

    fetch("http://localhost:4000/api/me/paystubs")
      .then(res => res.json())
      .then(data => setPaystubs(data.paystubs));
  }, []);

  return (
    <div className="p-8 max-w-xl mx-auto">
      <h1 className="text-2xl font-bold mb-4">Mi Perfil</h1>

      {profile ? (
        <div className="mb-6 space-y-2">
          <p><b>Nombre:</b> {profile.nombre}</p>
          <p><b>Cédula:</b> {profile.cedula}</p>
          <p><b>Cargo:</b> {profile.cargo}</p>
          <p><b>Fecha de ingreso:</b> {profile.fecha_ingreso}</p>
        </div>
      ) : (
        <p>Cargando perfil...</p>
      )}

      <h2 className="text-xl font-semibold">Mis Recibos</h2>
      <ul className="list-disc pl-5 mt-2">
        {paystubs.map(p => (
          <li key={p.id}>
            {p.periodo} — Neto: ₲ {p.neto.toLocaleString()}
          </li>
        ))}
      </ul>
    </div>
  );
}
