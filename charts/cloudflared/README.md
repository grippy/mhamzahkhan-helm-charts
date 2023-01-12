# Cloudflare Tunnel Helm Chart

This is a [Helm](https://helm.sh/) chart for installing [cloudflared](https://github.com/cloudflare/cloudflared) into a Kubernetes cluster. The basic usage is:

## TL;DR

```bash
$ helm repo add mhamzahkhan https://charts.hamzahkhan.com/
$ helm install cloudflared mhamzahkhan/cloudflared
```

## Parameters

| Name | Description | Value |
| --- | --- | --- |
| `image.repository` | Registry to pull the image from | `docker.io/cloudflare/cloudflared` |
| `image.tag` | Image tag | `2022.11.0` |
| `image.imagePullPolicy` | Image pull policy | `IfNotPresent` |
| `kind` | Deployment type - deployment or daemonset | `deployment` |
| `replicaCount` | Number of replicas (if using kind: deployment) | `1` |
| `nodeSelector` | Select which nodes to run on | `{}` |
| `tolerations` | Define tolerations | `{}` |
| `affinity` | Define node affinity | `{}` |
| `topologySpreadConstraints` | Define topology spread constraints | `{}` |
| `resources` | Define pod resource requests/limits | `{}` |
| `strategy.type` | Define roll out strategy | `RollingUpdate` |
| `disruptionBudget.enabled` | Enable PodDisruptionBudget | `true` |
| `disruptionBudget.maxUnavailable` | Maximum unavailable pods | 1 |
| `tunnelID` | Argo Tunnel ID | `""` |
| `auth.accountTag` | Argo Tunnel Account Tag | `""` |
| `auth.tunnelName` | Argo Tunnel Tunnel Name | `""` |
| `auth.tunnelSecret` | Argo Tunnel Secret | `""` |
| `ingress` | Ingress rules | `{}` |

## Example Deployment

### tunnel-1-values.yaml
```yaml
replicaCount: 2

kind: deployment

affinity:
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchExpressions:
              - key: app.kubernetes.io/name
                operator: In
                values:
                  - cloudflared-tunnel-1
          topologyKey: kubernetes.io/hostname

tunnelID: "00000000-0000-0000-0000-000000000000"

auth:
  accountTag: "00000000000000000000000000000000"
  tunnelName: "tunnel-1"
  tunnelSecret: "00000000000000000000000000000000000000000000"
```

### Deploy on cluster
```bash
$ helm repo add mhamzahkhan https://charts.hamzahkhan.com/
$ helm install tunnel-1 mhamzahkhan/cloudflared --values tunnel-1-values.yaml
```
