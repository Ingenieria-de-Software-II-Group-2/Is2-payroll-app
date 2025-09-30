// generar-hash.js

const bcrypt = require('bcrypt');

const password = '123456'; // ← Cambia esto por la contraseña que quieras hashear
const saltRounds = 10;     // Nivel de complejidad (10 es recomendado)

bcrypt.hash(password, saltRounds, function(err, hash) {
  if (err) {
    console.error('Error al generar el hash:', err);
    return;
  }
  console.log('Contraseña:', password);
  console.log('Hash generado:');
  console.log(hash);
});