{{/*
Expand the name of the chart.
*/}}
{{- define "sftp-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "sftp-server.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "sftp-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "sftp-server.labels" -}}
helm.sh/chart: {{ include "sftp-server.chart" . }}
{{ include "sftp-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "sftp-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "sftp-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "sftp-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "sftp-server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Get users from configuration
*/}}
{{- define "sftp-server.getUsers" -}}
{{- $users := .Values.sftp.users }}
{{- if .Values.sftp.usersSecret }}
  {{- $secret := lookup "v1" "Secret" .Release.Namespace .Values.sftp.usersSecret -}}
  {{- $secretKey := "users.conf" }}
  {{- if and $secret (hasKey $secret "data") (hasKey $secret.data $secretKey) }}
    {{- $users = fromYamlArray (index $secret.data $secretKey | b64dec) -}}
  {{- else }}
    {{- fail (printf "Secret '%s' does not exist or does not contain the expected key: %s" .Values.sftp.usersSecret $secretKey) }}
  {{- end }}
{{- end }}
{{- $users | toYaml -}}
{{- end }}
