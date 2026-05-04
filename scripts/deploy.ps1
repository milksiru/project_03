$ErrorActionPreference = "Stop"

kubectl -n ollama delete job ollama-pull-model --ignore-not-found
kubectl apply -k k8s
kubectl -n ollama rollout status daemonset/ollama-image-cache --timeout=600s
kubectl -n ollama rollout status deployment/ollama --timeout=300s
kubectl -n ollama wait --for=condition=complete job/ollama-pull-model --timeout=900s

Write-Host "Ollama service: http://ollama.ollama.svc.cluster.local:11434"
Write-Host "Default model: exaone3.5:2.4b"
Write-Host "Registry image: 192.168.55.139:5050/ollama/ollama:0.12.9"
