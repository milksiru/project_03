# project_03 Local LLM

`project_02`의 KubePilot AI가 사용할 로컬 LLM 서비스입니다. Kubernetes 내부에 Ollama를 배포하고, 대시보드 AI 비서가 ClusterIP로 접근하도록 구성합니다.

## 기본 구성

- 기본 모델: `exaone3.5:2.4b`
- 이미지 레지스트리: `192.168.55.139:5050`
- Ollama 이미지: `192.168.55.139:5050/ollama/ollama:0.12.9`
- PVC StorageClass: `synology-nfs`

현재 클러스터 노드는 각 4 CPU / 약 8Gi memory / GPU 없음인 CPU-only 환경입니다. 한국어 응답 품질을 위해 EXAONE 2.4B를 사용하고, `project_02`에서 타임아웃과 규칙 기반 fallback을 함께 둡니다.

## 배포

```powershell
.\scripts\deploy.ps1
```

배포 후 내부 주소:

```text
http://ollama.ollama.svc.cluster.local:11434
```

`ollama-image-cache` DaemonSet이 모든 노드에 Ollama 이미지를 미리 pull합니다.

## 모델 변경

`k8s/pull-model-job.yaml`의 `MODEL` 값을 바꾸고, `project_02/k8s/deployment.yaml`의 `OLLAMA_MODEL`도 같은 값으로 맞추세요.

권장 후보:

```text
exaone3.5:2.4b
qwen2.5:1.5b
qwen2.5:3b
llama3.2:3b
llama3.1:8b
```
