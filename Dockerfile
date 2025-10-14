# --- Stage 1: The Builder ---
# We use a full Node.js image to install dependencies
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
# Install only the dependencies needed for production
RUN npm install --only=production

# --- Stage 2: The Final Image ---
# We start from a fresh, clean base image
FROM node:18-alpine
WORKDIR /app
# Copy the installed dependencies from the 'builder' stage
COPY --from=builder /app/node_modules ./node_modules
# Copy the application code
COPY app.js .
# Tell Docker the container listens on port 8080
EXPOSE 8080
# The command to run when the container starts
CMD ["node", "app.js"]
