#!/bin/bash

# Caminho de destino
DEST=~/kubeconfig-cluster.yaml

# Garante que o kubeconfig base exista
mkdir -p ~/.kube
sudo cp /etc/kubernetes/admin.conf ~/.kube/config

# IP fixo fornecido manualmente
CLUSTER_IP="192.168.153.130"

echo "🌐 IP fixo da VM: $CLUSTER_IP"

# Copia o config e substitui IP
cp ~/.kube/config "$DEST"
sed -i "s|server: https://127.0.0.1:6443|server: https://$CLUSTER_IP:6443|" "$DEST"

echo "✅ kubeconfig exportado com IP externo:"
echo "   Arquivo salvo em: $DEST"
echo ""
echo "💡 Agora copie esse arquivo para o outro computador e coloque em: ~/.kube/config"
