kubectl create namespace demomanifest
kubectl apply -f ./k8s_manifest -n demomanifest

#kubect delete -f ./k8s_manifest -n demomanifest