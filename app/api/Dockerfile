# ----------------------------
# Stage 1: Build the Next.js app
# ----------------------------
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json* ./
RUN npm ci

# Copy the rest of the app source
COPY . .

# Build the Next.js app with standalone output
RUN npm run build

# ----------------------------
# Stage 2: Production image
# ----------------------------
FROM node:18-alpine AS runner
WORKDIR /app

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy only standalone build and public assets
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/.next/standalone ./      # minimal standalone server
COPY --from=builder /app/.next/static ./.next/static
COPY --from=builder /app/public ./public

# Switch to non-root
USER appuser

# Set env and expose port
ENV NODE_ENV=production
EXPOSE 3000

# Run the standalone Next.js server
CMD ["node", "server.js"]
