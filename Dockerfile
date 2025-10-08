# ----------------------------
# Stage 1: Build the Next.js app
# ----------------------------
FROM node:18-alpine AS builder
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json* ./
RUN npm ci

# Copy source code
COPY . .

# Build Next.js app for standalone output
RUN npm run build

# ----------------------------
# Stage 2: Production image
# ----------------------------
FROM node:18-alpine AS runner
WORKDIR /app

# Create a non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy standalone output
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/.next/standalone ./ 
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

# Switch to non-root user
USER appuser

# Production environment
ENV NODE_ENV=production
EXPOSE 3000

# Run the standalone server
CMD ["node", "server.js"]
