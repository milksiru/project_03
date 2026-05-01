# project_03 Local LLM

`project_02`의 KubePilot AI가 사용할 로컬 LLM 서비스입니다. Kubernetes 내부에 Ollama를 배포하고, 대시보드 AI 비서가 ClusterIP로 접근하도록 구성합니다.

## 기본 선택

- 기본 모델: `exaone3.5:2.4b`
- 선택 이유: 현재 클러스터 노드는 각 4 CPU / 약 8Gi memory, GPU 없음인 CPU-only 환경입니다. 한국어 응답 품질을 위해 Qwen 1.5B보다 EXAONE 2.4B를 우선 사용하되, CPU 응답 지연을 고려해 `project_02`에서 25초 타임아웃과 규칙 기반 fallback을 함께 둡니다.
- 더 빠른 응답: `qwen2.5:1.5b`
- 더 높은 품질: 16Gi 이상 메모리 노드에서는 3B급, GPU 또는 24Gi+ 노드에서는 7B/8B급 모델 권장

## 배포

```powershell
.\scripts\deploy.ps1
```

배포 후 내부 주소:

```text
http://ollama.ollama.svc.cluster.local:11434
```

`project_02/k8s/deployment.yaml`의 `OLLAMA_URL`은 위 주소를 바라봅니다.

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
