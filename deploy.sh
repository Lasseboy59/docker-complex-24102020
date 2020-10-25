docker build -t lasse1900/multi-client:latest -t lasse1900/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lasse1900/multi-server:latest -t lasse1900/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lasse1900/multi-worker:latest -t lasse1900/multi-worker:$SHA -f ./worker/Dorkerfile ./worker

docker push lasse1900/multi-client:latest
docker push lasse1900/multi-server:latest
docker push lasse1900/multi-worker:latest

docker push lasse1900/multi-client:$SHA
docker push lasse1900/multi-server:$SHA
docker push lasse1900/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lasse1900/multi-server:$SHA
kubectl set image deployments/client-deployment client=lasse1900/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lasse1900/multi-worker:$SHA