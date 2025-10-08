# ----------------------------
# Stage 1: Build the Next.js app
# ----------------------------
FROM node:18-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json* ./
RUN npm ci

# Copy source and build
COPY . .
RUN npm run build

# ----------------------------
# Stage 2: Production image
# ----------------------------
FROM node:18-alpine AS runner
WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy standalone output
COPY --from=builder /app/package.json ./
COPY --from=builder /app/.next/standalone ./
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

USER appuser
ENV NODE_ENV=production
EXPOSE 3000

CMD ["node", "server.js"]
