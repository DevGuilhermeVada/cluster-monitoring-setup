#!/bin/bash

set -e

echo "📦 Adicionando repositório do Prometheus Community..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo "📁 Criando namespace 'monitoring' (se ainda não existir)..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

echo "🚀 Instalando Prometheus stack (com kube-state-metrics e node-exporter)..."
helm install prometheus prometheus-community/kube-prometheus-stack   --namespace monitoring   --set grafana.enabled=false

echo "✅ Prometheus stack instalado com sucesso!"
echo ""
echo "🔍 Componentes instalados:"
echo "- Prometheus"
echo "- Alertmanager"
echo "- kube-state-metrics"
echo "- node-exporter"
echo ""
echo "⚙️  Agora você pode importar dashboards com a fonte de dados 'Prometheus' no Grafana."
