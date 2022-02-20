# Kubernetes Setup

Der Kubernetes-Cluster für das Homelab basiert auf K3S. Es ist Metallb als Loadbalancer installiert.

Damit Metallb genutzt werden kann darf der Service Loadbalancer (klipper), den K3S standardmässig mitbringt nicht installiert sein.
Ebenso wird Traefik nicht mitinstalliert. Wir werden eine aktuellere Version via *Helm* installieren und ein paar Änderungen an der Konfiguration vornehmen

## Master-Node installieren
Der **Master** wird mit folgendem Befehl installiert:

```
curl -sfL https://get.k3s.io | sh -s - --write-kubeconfig-mode 644 --disable servicelb --disable traefik
```

Der Server wird installiert und ist danach einsatzbereit. Standard-Tools wie *kubectl*, *crictl*, *ctr* sowie ein Deinstallations- (*/usr/local/bin/k3s-uninstall.sh*) und ein Killall-Script (*/usr/local/bin/k3s-killall.sh*) werden ebenfalls mit installiert.

- Die kubeconfig Datei findet sich hier: `/etc/rancher/k3s/k3s.yaml`
- Das Token um weitere Nodes zu joinen ist hier: `/var/lib/rancher/k3s/server/token`

### Metallb installieren
```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.11.0/manifests/metallb.yaml
```
Konfiguration für Metallb mit ConfigMap
```
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 192.168.1.221-192.168.1.240

```

### Traefik via Helm installieren

```
helm repo add traefik https://helm.traefik.io/traefik
helm repo update
helm install traefik traefik/traefik
```

Das Traefik-Dashboard via 
```
# dashboard.yaml
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRoute
metadata:
  name: dashboard
spec:
  entryPoints:
    - web
  routes:
    - match: Host(`traefik.k8s.homenet`) && (PathPrefix(`/dashboard`) || PathPrefix(`/api`))
      kind: Rule
      services:
        - name: api@internal
          kind: TraefikService
```

## External DNS installieren




## Rancher installieren
```
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
kubectl create namespace cattle-system

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.6.1 \
  --set installCRDs=true

#kubectl wait

# Finally install Rancher
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.k8s.homenet \
  --set bootstrapPassword=admin 
```


## Worker-Nodes
**Worker-Nodes** zum Master hinzufügen:

```
curl -sfL https://get.k3s.io | K3S_URL=https://<MASTER_URL>:6443 K3S_TOKEN=<TOKEN> sh -
```

