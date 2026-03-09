# Stage 1: Build
FROM node:20-alpine AS builder

WORKDIR /app

# Copy package files and install production dependencies only
COPY package.json package-lock.json* ./
RUN npm ci --omit=dev

# Stage 2: Runtime
FROM node:20-alpine AS runtime

# Upgrade OS packages, then remove npm and its bundled deps entirely.
# The app only needs the node binary at runtime — npm is build-time tooling.
RUN apk upgrade --no-cache \
    && rm -rf /usr/local/lib/node_modules/npm \
    && rm -f /usr/local/bin/npm /usr/local/bin/npx /usr/local/bin/corepack

# Create non-root user for security
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy installed dependencies from builder
COPY --from=builder /app/node_modules ./node_modules

# Copy application source
COPY src/ ./src/
COPY package.json ./

# Set ownership and switch to non-root user
RUN chown -R appuser:appgroup /app
USER appuser

EXPOSE 3001

ENV NODE_ENV=production \
    PORT=3001

HEALTHCHECK --interval=30s --timeout=5s --start-period=15s --retries=3 \
  CMD wget -qO- http://localhost:3001/health || exit 1

CMD ["node", "src/index.js"]
