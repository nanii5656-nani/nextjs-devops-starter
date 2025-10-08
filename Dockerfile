# ----------------------------
# Stage 1: Build the Next.js app
# ----------------------------
FROM node:18-alpine AS builder
WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci

COPY . .
RUN npm run build

# ----------------------------
# Stage 2: Production image
# ----------------------------
FROM node:18-alpine AS runner
WORKDIR /app

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy standalone output
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

USER appuser
ENV NODE_ENV=production
EXPOSE 3000

# ✅ Correct CMD pointing to the standalone server.js
CMD ["node", "server.js"]
