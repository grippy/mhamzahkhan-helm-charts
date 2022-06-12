{{/* vim: set filetype=mustache: */}}

{{/*
Expand the name of the chart.
*/}}
{{- define "cloudflared.name" -}}
{{- printf "%s-%s" .Chart.Name .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create labels
*/}}
{{- define "cloudflared.labels" -}}
app.kubernetes.io/name: {{ include "cloudflared.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Expand the name of the configmap.
*/}}
{{- define "cloudflared.configName" -}}
{{- default (include "cloudflared.name" .) .Values.controller.config.name -}}
{{- end -}}
