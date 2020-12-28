docker build -t sla686/multi-client:latest -t sla686/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sla686/multi-server:latest -t sla686/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sla686/multi-worker:latest -t sla686/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sla686/multi-client:latest
docker push sla686/multi-server:latest
docker push sla686/multi-worker:latest

docker push sla686/multi-client:$SHA
docker push sla686/multi-server:$SHA
docker push sla686/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sla686/multi-server:$SHA
kubectl set image deployments/client-deployment client=sla686/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sla686/multi-worker:$SHA