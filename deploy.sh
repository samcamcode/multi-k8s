docker build -t samcamcode/multi-client:latest -t samcamcode/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t samcamcode/multi-server:latest -t samcamcode/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t samcamcode/multi-worker:latest -t samcamcode/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push samcamcode/multi-client:latest
docker push samcamcode/multi-server:latest
docker push samcamcode/multi-worker:latest
docker push samcamcode/multi-client:$SHA
docker push samcamcode/multi-server:$SHA
docker push samcamcode/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=samcamcode/multi-server:$SHA
kubectl set image deployments/client-deployment client=samcamcode/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=samcamcode/multi-worker:$SHA