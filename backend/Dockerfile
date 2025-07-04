# ---------- Build Stage ----------
FROM golang:1.24 AS builder

WORKDIR /app

# Only copy go.mod and go.sum first (leverage cache)
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the source code
COPY . .

# Static build
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -installsuffix cgo -trimpath -o server .

# ---------- Runtime Stage ----------
# Minimal base image for static Go binaries
# Note: This image does not include a shell nor CA certificates
FROM scratch

# Copy binary from the builder
COPY --from=builder /app/server /app/server

# Set working directory
WORKDIR /app

# Expose the port your Go server listens on
EXPOSE 3000

# Run the binary
CMD ["./server"]


# Run the following commands to build and run the Docker container:
# docker build -t random-choice-devops-backend .
# docker run -d -p 3000:3000 --name random-picker-backend-container random-choice-devops-backend
