# Stage 1: Build the Go binary
FROM golang:1.17 as builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files to download dependencies
COPY go.mod ./

# Download all dependencies
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go app for a linux target and disable CGO for an even smaller binary.
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

# Stage 2: Create a minimal image from scratch
FROM scratch

# Copy the binary from the builder stage to the current stage
COPY --from=builder /app/main /main

# This container exposes port 8080 to the outside world
EXPOSE 8080

# Run the binary
ENTRYPOINT ["/main"]
