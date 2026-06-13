#!/bin/sh
# Entrypoint del servicio de usuario.
# 1) Aplica las migraciones de Prisma sobre la base de datos.
# 2) Arranca el servidor Express con tsx (resuelve los imports ESM sin extension).
set -e

echo "[entrypoint] Aplicando migraciones de Prisma (migrate deploy)..."
npx prisma migrate deploy --schema prisma/schema.prisma

echo "[entrypoint] Iniciando el servidor de usuarios con tsx..."
exec npx tsx src/server.ts
