# Start from official Golang image
FROM golang:1.24

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the code
COPY . .

# Build the Go app
RUN go build -o main .

# Set the default command to run the built binary
CMD ["./main"]

# Expose the port your app listens on
EXPOSE 3000

# Run the following commands to build and run the Docker container:
# docker build -t random-choice-devops-backend .
# docker run -d -p 3000:3000 --name random-picker-backend-container random-choice-devops-backend
