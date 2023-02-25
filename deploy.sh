docker build -t gabrielmorettii/multi-client-k8s:latest -t gabrielmorettii/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t gabrielmorettii/multi-server-k8s-pgfix:latest -t gabrielmorettii/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t gabrielmorettii/multi-worker-k8s:latest -t gabrielmorettii/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push gabrielmorettii/multi-client-k8s:latest
docker push gabrielmorettii/multi-server-k8s-pgfix:latest
docker push gabrielmorettii/multi-worker-k8s:latest

docker push gabrielmorettii/multi-client-k8s:$SHA
docker push gabrielmorettii/multi-server-k8s-pgfix:$SHA
docker push gabrielmorettii/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gabrielmorettii/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=gabrielmorettii/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=gabrielmorettii/multi-worker-k8s:$SHA