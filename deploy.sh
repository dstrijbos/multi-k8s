docker build -t david3dimerce/multi-client:latest -t david3dimerce/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t david3dimerce/multi-server:latest -t david3dimerce/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t david3dimerce/multi-worker:latest -t david3dimerce/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push david3dimerce/multi-client:latest
docker push david3dimerce/multi-server:latest
docker push david3dimerce/multi-worker:latest

docker push david3dimerce/multi-client:$GIT_SHA
docker push david3dimerce/multi-server:$GIT_SHA
docker push david3dimerce/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=david3dimerce/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=david3dimerce/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=david3dimerce/multi-worker:$GIT_SHA