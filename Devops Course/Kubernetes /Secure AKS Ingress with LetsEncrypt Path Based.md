# Deploy NGINX Ingress Controller with Custom Domain and TLS in AKS
- youtube : https://www.youtube.com/watch?v=Kt2p21ZRPHI&list=PLDkX8OJhBFVsVqsbjvSNscAsxZsD6ZWza&index=12
## Overview
This guide provides steps to deploy an NGINX ingress controller in an Azure Kubernetes Service (AKS) cluster, configure a custom domain, and use Let’s Encrypt certificates for SSL/TLS.
- Create a namespace ingress-basic for Ingress Controller where all ingress controller-related resources will be created.
- Create a DNS Zone and Alias record for the custom domain.
- Install cert-manager for SSL certificates in ingress-basic namespace using Helm.
- Create a CA cluster issuer for issuing certificates.
- Create first application and service.
- Create Second application and service.
- Create an ingress route to configure the rules that route traffic to one of the two applications.
- Verify the automatic created certificate.
- Test the applications using Custom Domain.
---

## Steps

### 1. Create Namespace for Ingress Resources
Create a dedicated namespace for ingress-related resources:
```bash
kubectl create namespace ingress-basic
```

---

### 2. Deploy NGINX Ingress Controller
Add the NGINX ingress Helm repository and deploy the ingress controller:
```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
helm install ingress-nginx ingress-nginx/ingress-nginx \
    --namespace ingress-basic \
    --set controller.replicaCount=2
```

---

### 3. Configure DNS Zone and A Record
- Create a DNS zone in Azure and add an A record pointing to the **ingress controller'**s public IP.
- ![image](https://github.com/user-attachments/assets/b89c71e1-4883-41d2-9d9c-8d06a5ee9a4b)
- Retrieve the static public IP:
  ```bash
  kubectl get services -n ingress-basic
  ```

---

### 4. Install cert-manager for SSL Certificates
1. Label the namespace:
   ```bash
   kubectl label namespace ingress-basic cert-manager.io/disable-validation=true
   ```

2. Add the Jetstack Helm repository:
   ```bash
   helm repo add jetstack https://charts.jetstack.io
   helm repo update
   ```

3. Install cert-manager CRDs:
   ```bash
   kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml
   ```

4. Deploy cert-manager:
   ```bash
   helm install cert-manager jetstack/cert-manager \
       --namespace ingress-basic \
       --version v1.7.1
   ```

---

### 5. Create a ClusterIssuer for Let’s Encrypt
Create a `cluster-issuer.yaml` file:
```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: your-email@example.com
    privateKeySecretRef:
      name: letsencrypt
    solvers:
    - http01:
        ingress:
          class: nginx
```
Apply the cluster issuer:
```bash
kubectl apply -f cluster-issuer.yaml --namespace ingress-basic
```

---

### 6. Deploy Demo Applications
#### Application 1: aks-helloworld-one
Create `aks-helloworld-one.yaml`:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: aks-helloworld-one
spec:
  replicas: 1
  selector:
    matchLabels:
      app: aks-helloworld-one
  template:
    metadata:
      labels:
        app: aks-helloworld-one
    spec:
      containers:
      - name: aks-helloworld-one
        image: mcr.microsoft.com/azuredocs/aks-helloworld:v1
        ports:
        - containerPort: 80
        env:
        - name: TITLE
          value: "Welcome to Azure Kubernetes Service (AKS)"
---
apiVersion: v1
kind: Service
metadata:
  name: aks-helloworld-one
spec:
  type: ClusterIP
  ports:
  - port: 80
  selector:
    app: aks-helloworld-one
```

#### Application 2: aks-helloworld-two
Create `aks-helloworld-two.yaml`:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: aks-helloworld-two
spec:
  replicas: 1
  selector:
    matchLabels:
      app: aks-helloworld-two
  template:
    metadata:
      labels:
        app: aks-helloworld-two
    spec:
      containers:
      - name: aks-helloworld-two
        image: mcr.microsoft.com/azuredocs/aks-helloworld:v1
        ports:
        - containerPort: 80
        env:
        - name: TITLE
          value: "AKS Ingress Demo"
---
apiVersion: v1
kind: Service
metadata:
  name: aks-helloworld-two
spec:
  type: ClusterIP
  ports:
  - port: 80
  selector:
    app: aks-helloworld-two
```

Deploy the applications:
```bash
kubectl apply -f aks-helloworld-one.yaml --namespace ingress-basic
kubectl apply -f aks-helloworld-two.yaml --namespace ingress-basic
```

---

### 7. Configure an Ingress Route
Create `hello-world-ingress.yaml`:
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-world-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    cert-manager.io/cluster-issuer: letsencrypt
    nginx.ingress.kubernetes.io/rewrite-target: /$1
    nginx.ingress.kubernetes.io/use-regex: "true"
spec:
  tls:
  - hosts:
    - mydevsecops.com
    secretName: tls-secret
  rules:
  - host: mydevsecops.com
    http:
      paths:
      - path: /hello-world-one(/|$)(.*)
        pathType: Prefix
        backend:
          service:
            name: aks-helloworld-one
            port:
              number: 80
      - path: /hello-world-two(/|$)(.*)
        pathType: Prefix
        backend:
          service:
            name: aks-helloworld-two
            port:
              number: 80
```
Apply the ingress route:
```bash
kubectl apply -f hello-world-ingress.yaml --namespace ingress-basic
```

---

### 8. Verify the Certificate
Verify the creation of the TLS certificate:
```bash
kubectl describe certificate tls-secret --namespace ingress-basic
```

---

### 9. Test the Configuration
1. Open a web browser and test the applications:
   - `https://mydevsecops.com/hello-world-one`
   - `https://mydevsecops.com/hello-world-two`

2. Ensure both applications are secured with SSL/TLS and accessible via the custom domain.

---

### Result
- Two demo applications are deployed and secured with Let’s Encrypt certificates.
- Traffic is routed using host-based rules with the NGINX ingress controller.
