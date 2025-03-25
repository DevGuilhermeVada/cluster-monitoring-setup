# 🧭 Passo a Passo: Cluster Kubernetes Local com Monitoramento

Este guia resume todas as instalações realizadas para configurar um ambiente Kubernetes single-node com Grafana, Loki, Promtail e Prometheus.

---

## ✅ 1. Criar o Cluster Kubernetes (Single Node)

**Arquivo:** `k8s-single-node-fixed-ip.sh`

```bash
chmod +x k8s-single-node-fixed-ip.sh
./k8s-single-node-fixed-ip.sh
```

### O que este script faz:

- Instala containerd, kubeadm, kubectl, kubelet
- Inicializa o cluster com IP fixo: `192.168.153.130`
- Instala o Calico como rede
- Permite agendamento de pods no nó master

---

## ✅ 2. Gerar kubeconfig para acesso remoto

**Arquivo:** `generate-kubeconfig.sh`

```bash
chmod +x generate-kubeconfig.sh
./generate-kubeconfig.sh
```

### O que este script faz:

- Copia e ajusta o kubeconfig para IP externo
- Salva como `kubeconfig-cluster.yaml`
- Usar no computador cliente:

```bash
mkdir -p ~/.kube
mv kubeconfig-cluster.yaml ~/.kube/config
```

---

## ✅ 3. Instalar Helm + Loki Stack (Grafana, Loki, Promtail)

**Arquivo:** `install-helm-and-monitoring.sh`

```bash
chmod +x install-helm-and-monitoring.sh
./install-helm-and-monitoring.sh
```

### Acesso ao Grafana:

- URL: [http://192.168.153.130:30001](http://192.168.153.130:30001)
- Usuário: `admin`
- Senha:

```bash
kubectl get secret --namespace monitoring loki-stack-grafana -o jsonpath="{.data.admin-password}" | base64 -d && echo
```

---

## ✅ 4. Instalar Prometheus Stack

**Arquivo:** `install-prometheus-stack.sh`

```bash
chmod +x install-prometheus-stack.sh
./install-prometheus-stack.sh
```

### O que este script faz:

- Instala `kube-prometheus-stack` via Helm
- Componentes:
  - Prometheus
  - kube-state-metrics
  - node-exporter
  - Alertmanager

---

## ✅ Verificações rápidas

### Ver status dos pods:

```bash
kubectl get pods -n monitoring
```

### Ver serviços:

```bash
kubectl get svc -n monitoring
```

### Testar Prometheus local:

```bash
kubectl port-forward svc/prometheus-operated -n monitoring 9090:9090
```

Acesse: [http://localhost:9090](http://localhost:9090)

---

## 🔚 Fim da instalação base

Você agora possui:

- Cluster Kubernetes single-node
- Acesso remoto via kubeconfig
- Stack de monitoramento: Grafana + Loki + Promtail + Prometheus
