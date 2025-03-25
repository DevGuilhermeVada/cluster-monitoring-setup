#!/bin/bash

set -e

echo "🚀 Instalando Helm..."

# Baixar e instalar o Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

echo "✅ Helm instalado com sucesso."
helm version

echo "📦 Adicionando repositório Helm da Grafana..."
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

echo "📁 Criando namespace 'monitoring'..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -

echo "📊 Instalando Loki Stack (Grafana + Loki + Promtail)..."
helm install loki-stack grafana/loki-stack   --namespace monitoring   --set grafana.enabled=true   --set grafana.service.type=NodePort   --set grafana.service.nodePort=30001   --set promtail.enabled=true

echo ""
echo "✅ Stack de monitoramento instalado com sucesso!"
echo "🌐 Acesse: http://192.168.153.130:30001"
echo "🔐 Login padrão do Grafana:"
echo "  Usuário: admin"
echo -n "  Senha: "
kubectl get secret --namespace monitoring loki-stack-grafana -o jsonpath="{.data.admin-password}" | base64 -d && echo
