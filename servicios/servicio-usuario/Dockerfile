# Imagen del servicio de usuario (Express + Prisma) para despliegue local con Docker.
# Se ejecuta con tsx en runtime: el codigo usa imports ESM sin extension y "node"
# plano falla con ERR_MODULE_NOT_FOUND, mientras que tsx los resuelve correctamente.
FROM node:22-alpine

# openssl es requerido por el engine de Prisma en Alpine.
RUN apk add --no-cache openssl

WORKDIR /usr/src/app

# Copiar manifiestos primero para aprovechar la cache de capas de Docker.
COPY package*.json ./

# Instalar todas las dependencias (tsx y prisma estan en devDependencies y se
# necesitan en runtime para arrancar y aplicar migraciones).
RUN npm ci

# Copiar el resto del codigo fuente (incluye prisma/, src/, etc.).
COPY . .

# Generar el cliente de Prisma dentro de la imagen.
RUN npx prisma generate --schema prisma/schema.prisma

# Puerto del servicio (coincide con USER_SERVICE_PORT por defecto en server.ts).
EXPOSE 4102

# El entrypoint aplica migraciones y luego levanta el servidor.
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

CMD ["docker-entrypoint.sh"]
