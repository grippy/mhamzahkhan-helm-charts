# YUKIMOCHI Activity-Relay Helm Chart

This is a [Helm](https://helm.sh/) chart for installing [YUKIMOCHI Activity-Relay](https://github.com/yukimochi/Activity-Relay) into a Kubernetes cluster. The basic usage is:

## TL;DR

```bash
$ helm repo add mhamzahkhan https://charts.hamzahkhan.com/
$ helm install activityrelay mhamzahkhan/activityrelay
```

## Parameters


## Configuration

The following table lists the configurable parameters of the Activityrelay chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `image.repository` | Registry to pull the image from | `"docker.io/yukimochi/activity-relay"` |
| `image.pullPolicy` | Image pull policy | `"IfNotPresent"` |
| `image.tag` | Image tag (defaults to appVersion) | `""` |
| `imagePullSecrets` | Image pull secret | `[]` |
| `nameOverride` |  | `""` |
| `fullnameOverride` |  | `""` |
| `serviceAccount.create` |  | `true` |
| `serviceAccount.annotations` |  | `{}` |
| `serviceAccount.name` |  | `""` |
| `service.type` | Service object type (ClusterIP/LoadBalancer) | `"ClusterIP"` |
| `activityrelay.config.relay_domain` |  | `"relay.example.com"` |
| `activityrelay.config.relay_servicename` |  | `"Example ActivityPub Relay Service"` |
| `activityrelay.config.job_concurrency` |  | `"50"` |
| `activityrelay.actor.existingSecret` |  | `""` |
| `activityrelay.server.replicaCount` |  | `1` |
| `activityrelay.server.port` |  | `8080` |
| `activityrelay.server.extraArgs` |  | `["--verbose"]` |
| `activityrelay.server.podAnnotations` |  | `{}` |
| `activityrelay.server.podSecurityContext` |  | `{}` |
| `activityrelay.server.securityContext.readOnlyRootFilesystem` |  | `false` |
| `activityrelay.server.securityContext.allowPrivilegeEscalation` |  | `false` |
| `activityrelay.server.securityContext.capabilities.drop` |  | `["all"]` |
| `activityrelay.server.securityContext.capabilities.add` |  | `["NET_BIND_SERVICE"]` |
| `activityrelay.server.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution` |  | `[{"labelSelector": {"matchLabels": {"app.kubernetes.io/component": "workers"}}, "topologyKey": "kubernetes.io/hostname"}]` |
| `activityrelay.server.resources` |  | `{}` |
| `activityrelay.workers.replicaCount` |  | `3` |
| `activityrelay.workers.extraArgs` |  | `["--verbose"]` |
| `activityrelay.workers.podAnnotations` |  | `{}` |
| `activityrelay.workers.podSecurityContext` |  | `{}` |
| `activityrelay.workers.securityContext.readOnlyRootFilesystem` |  | `false` |
| `activityrelay.workers.securityContext.allowPrivilegeEscalation` |  | `false` |
| `activityrelay.workers.securityContext.capabilities.drop` |  | `["all"]` |
| `activityrelay.workers.affinity.podAntiAffinity.requiredDuringSchedulingIgnoredDuringExecution` |  | `[{"labelSelector": {"matchLabels": {"app.kubernetes.io/component": "workers"}}, "topologyKey": "kubernetes.io/hostname"}]` |
| `activityrelay.workers.resources` |  | `{}` |
| `redis.enabled` |  | `true` |
| `redis.architecture` |  | `"standalone"` |
| `redis.auth.enabled` |  | `false` |
| `redis.externalRedis.host` |  | `"localhost"` |
| `redis.externalRedis.port` |  | `6379` |
| `podAnnotations` |  | `{}` |
| `podSecurityContext.runAsUser` |  | `991` |
| `podSecurityContext.runAsGroup` |  | `991` |
| `podSecurityContext.fsGroup` |  | `991` |
| `podSecurityContext.runAsNonRoot` |  | `true` |
| `securityContext` |  | `{}` |
| `nodeSelector.kubernetes.io/os` |  | `"linux"` |
| `tolerations` |  | `[]` |
| `affinity` |  | `{}` |

## Example Deployment

### Deploy with external redis - external-redis-values.yaml
```yaml
service:
  type: ClusterIP

activityrelay:
  config:
    relay_domain: "relay.intahnet.co.uk"
    relay_servicename: "ActivityRelay@intahnet.co.uk"
    job_concurrency: "50"

  actor:
    existingSecret: "actor-key"

  server:
    replicaCount: 1

  workers:
    replicaCount: 6

redis:
  enabled: false

  externalRedis:
    host: "redis.activityrelay.svc.cluster.local."
    port: 6379
```

### Deploy on cluster
```bash
$ helm repo add mhamzahkhan https://charts.hamzahkhan.com/
$ helm install activityrelay mhamzahkhan/activityrelay --values external-redis-values.yaml
```
