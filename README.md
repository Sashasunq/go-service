Application Go-Service

You can create a simple HTTP service in Go that responds to an HTTP GET request with the timestamp and the hostname of the server by using the net/http package. Below is a step-by-step guide to build such a service.

1. First, you need to have Go installed on your machine. You can download and install it from the official website: https://golang.org/dl/
2. Next, create a new directory for your project and navigate to it:

```
mkdir go-service
cd go-service
```

3. Create a new file named main.go and open it in your text editor.
4. Run the service:

```
go run main.go
```

This will start an HTTP server on port 8080.

5. Test the service by sending an HTTP GET request. You can do this using a web browser or a tool like curl from the command line:

```
curl http://localhost:8080
```

You should see a response like this:

`Timestamp: 2023-06-13T14:10:30Z Hostname: your-hostname`

Docker image creation

To package your Go service into a Docker image, you need to write a Dockerfile. This Dockerfile will be multi-stage to make the resulting image as small as possible. Here's a step-by-step guide:

1. First, you need to have Docker installed on your machine. You can download and install Docker from the official website: https://www.docker.com/products/docker-desktop
2. Build your Docker image based on Dockerfile

```
docker build -t go-timestamp-hostname-service .
```

3. Run your Docker image:

```
docker run -p 8080:8080 go-timestamp-hostname-service
```

Your service will now be accessible at http://localhost:8080 as before, but it's running inside a Docker container.

Note that this Dockerfile assumes you are using Go modules (go.mod and go.sum files) for dependency management. If you aren't using Go modules, you can remove the lines related to them.

Add the Prometheus Go client to your project with updated import prometeus golang:

```
go get github.com/prometheus/client_golang/prometheus
go get github.com/prometheus/client_golang/prometheus/promhttp
```

Kubernetes deployment:

Start Minikube and Deploy Application

1. Start Minikube:

```
minikube start
```

2. Set the Docker daemon to use Minikube:

```
eval $(minikube docker-env)
```

3. Rebuild the Docker image:

```
docker build -t my-go-service .
```

4. Apply the Kubernetes manifests to create the deployment and service:

```
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

5. Access the Go service via Minikube:

```
minikube service go-service
```

6. Deploy Prometheus and Grafana for Monitoring

Apply the Prometheus configuration, deployment, and service manifests:

```
kubectl apply -f prometheus-config.yaml
kubectl apply -f prometheus-deployment.yaml
kubectl apply -f prometheus-service.yaml
```

7. Deploy Grafana:

```
kubectl apply -f grafana-deployment.yaml
kubectl apply -f grafana-service.yaml
```

8. Access Prometheus: 

```
minikube service prometheus
```

9. Access Grafana:

```
minikube service grafana
```
Use admin for both the username and password. Add Prometheus as a data source in Grafana and create a dashboard for visualizing the metrics.

Congratulations! You have deployed a Go application with monitoring enabled in Kubernetes.

This README provides a more streamlined set of instructions, breaking down the process into three main steps: Application Go-Service, Docker image creation, Kubernetes Deployment with metrics
