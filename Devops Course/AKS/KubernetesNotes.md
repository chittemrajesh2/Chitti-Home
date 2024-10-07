## 1. Control Plane:
This is the brain of the operation. It's responsible for managing the entire 
Kubernetes cluster and ensuring everything runs smoothly. The control plane includes:
- **etcd**: A distributed, consistent key-value store that holds all the configuration data for the 
cluster.
- **API Server**: The central point of access for all interactions with the cluster. It handles 
requests from users, tools, and other components.
- **Scheduler**: Decides which node in the cluster is best suited to run a particular pod. It 
considers factors like resource availability and node health.
- **Controller Manager**: Manages the lifecycle of various Kubernetes objects, like 
deployments, services, and pods. It ensures that the desired state of the cluster is 
maintained.

##Types of Ingress Controller:

### 1. NGINX Ingress Controller
- Description: The most popular and widely used Ingress Controller. It uses NGINX as a reverse proxy and load balancer to route traffic.
- Use Case: Suitable for general purposes and widely supported in the Kubernetes ecosystem.
### 2. Traefik Ingress Controller
- Description: A modern, cloud-native reverse proxy and load balancer that integrates well with Kubernetes.
- Use Case: Known for its simplicity and ease of use, Traefik automatically detects services and routing rules.
### 3. HAProxy Ingress Controller
- Description: Uses HAProxy, a highly customizable and high-performance TCP/HTTP load balancer and proxy.
- Use Case: Useful for users needing high customization and performance at scale.
### 4. Kong Ingress Controller
- Description: Built on top of the Kong API gateway, this controller offers traffic control, API management, and security.
- Use Case: Best for API gateway use cases, including rate limiting, authentication, and load balancing.
### 5. AWS ALB (Application Load Balancer) Ingress Controller
- Description: This controller is used to integrate AWS ALB with Kubernetes for managing ingress traffic.
- Use Case: Ideal for applications running on AWS, as it integrates natively with AWS services.
### 6. GCE (Google Cloud Platform) Ingress Controller
- Description: Google’s default Ingress Controller that integrates with Google Cloud Load Balancer.
- Use Case: Used primarily for applications running on GCP.
### 7. Istio Ingress Gateway
- Description: Part of the Istio service mesh, it provides advanced traffic management, security, and observability.
- Use Case: Best suited for applications leveraging a service mesh architecture.
### 8. Contour Ingress Controller
- Description: Built on top of Envoy, this Ingress Controller is designed for high performance and flexibility.

- Use Case: Preferred for environments that require flexibility in routing and high scalability.
## 2. Nodes: 
These are the worker machines that actually run your containers. Each node has:
- **Kubelet**: An agent that runs on each node and communicates with the control plane. It's 
responsible for managing pods and containers on the node.
- **Container Runtime**: The software that actually runs your containers. Popular options 
include Docker, containerd, and CRI-O.
- **Sidecar** 
- Sidecar containers are the secondary containers that run along with the main application container within the same Pod.
- These containers are used to enhance or to extend the functionality of the primary app container by providing additional services, or functionality such as logging, monitoring, security, or data synchronization, without directly altering the primary application code
- **Proxy**: A network proxy that handles communication between pods and services.
![image](https://github.com/user-attachments/assets/89b416f8-1be2-4634-8ca9-d299b5cd2701)

- **imperative** : verb based commands 
- **Declarative** : define your desired state using YAML files.
- **Pods**: The smallest deployable unit in Kubernetes. 
 A pod represents a single instance of your application, running one or more containers

# Service
1) clusterIp
2) Nodeport
3) Load Balancer
4) Headless
5) External name service
6) External IP service

- **ClusterIP**: Accessible only within the cluster.
- **NodePort**: Accessible from outside the cluster on a specific port on each node.
- **LoadBalancer**: Accessible from outside the cluster through a load 
balancer

# Kubernetes Services

## 1. ClusterIP
- Default service type.
- Only accessible from within the cluster.
- Example: Internal backend service that other microservices access.

```yaml
apiVersion: v1
kind: Service
metadata:
  name: clusterip-service
spec:
  selector:
    app: myapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: ClusterIP
```
## 1. NodePort
- Exposes the service on a static port on each node’s IP.
- Useful when accessing services outside the cluster.
- Example: Exposing a web application externally.
```yaml
apiVersion: v1
kind: Service
metadata:
  name: nodeport-service
spec:
  type: NodePort
  selector:
    app: myapp
  ports:
    - port: 80
      targetPort: 8080
      nodePort: 30007

```
## 3. LoadBalancer
- Automatically provisions an external load balancer and routes external traffic to pods.
- Example: Exposing an externally available web application behind a load balancer.
```yaml  
apiVersion: v1
kind: Service
metadata:
  name: loadbalancer-service
spec:
  type: LoadBalancer
  selector:
    app: myapp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080

```
## 4. Headless Service
- Used when you don’t need a load balancer or single IP. Primarily for StatefulSets.
- Example: A distributed database where clients need to connect directly to individual pods.
```yaml  
apiVersion: v1
kind: Service
metadata:
  name: headless-service
spec:
  clusterIP: None
  selector:
    app: myapp
  ports:
    - port: 80
      targetPort: 8080
```
## 5. ExternalName Service
- Maps the service to an external DNS name rather than routing traffic to a pod.
- Example: Mapping to an external database service (e.g., AWS RDS).
```yaml  
apiVersion: v1
kind: Service
metadata:
  name: externalname-service
spec:
  type: ExternalName
  externalName: "example.com"
```
## 6. External IP Service
- Exposes the service on an external IP.
- Example: Assigning an external IP to access the service from outside the cluster.
```yaml  
apiVersion: v1
kind: Service
metadata:
  name: external-ip-service
spec:
  type: ClusterIP
  externalIPs:
    - 192.168.1.100
  selector:
    app: myapp
  ports:
    - port: 80
      targetPort: 8080

```
# 1.Ingress Controller and Ingress Resources
1. **Ingress Controller**:
Definition: An Ingress Controller is a Kubernetes component that manages HTTP and HTTPS traffic and routes it to services in a cluster. It acts as a bridge between the external world and the internal services.
- **Purpose**: It exposes HTTP/HTTPS routes from outside the Kubernetes cluster to services within the cluster.
2. **Ingress Resources**:
Definition: Ingress Resource is an API object that defines how traffic should be routed to services based on the URL path or hostname.
- **Purpose**: It contains routing rules for directing external traffic to specific services within the cluster.
### Configuration of Ingress Controller and Ingress Resource
1. Ingress Controller Setup:
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
```
2. Ingress Resource Configuration (YAML):
```yaml  
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  namespace: default
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
  - host: myapp.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-service
            port:
              number: 80

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: dashboard-ingress
  namespace: kubernetes-dashboard
spec:
  ingressClassName: "nginx"
  rules:
  - host: dashboard.com
    http:
      paths:
      - path: /shopping
        pathType: Prefix  
        backend:
          service:
            name: kubernetes-dashboard
            port: 
              number: 80

```
- Annotations: You can configure different annotations for behavior like SSL termination, rewrite rules, etc.
- Rules: Define how traffic for specific hosts or paths should be routed to the appropriate services.
  # Namespace Commands and Troubleshooting

| **Issue**                                | **Command**                                        | **Description**                                                                 |
|------------------------------------------|----------------------------------------------------|---------------------------------------------------------------------------------|
| List all namespaces                      | `kubectl get namespaces`                           | Shows all the namespaces in the cluster.                                        |
| Check the status of a specific namespace | `kubectl get namespace <namespace-name>`           | Provides the status of a specific namespace.                                    |
| Create a new namespace                   | `kubectl create namespace <namespace-name>`        | Creates a new namespace in the Kubernetes cluster.                             |
| Delete a namespace                       | `kubectl delete namespace <namespace-name>`        | Deletes a specific namespace along with its resources.                         |
| Switch to a different namespace          | `kubectl config set-context --current --namespace=<namespace-name>` | Switches the current context to a specified namespace.                          |
| View resources in a specific namespace   | `kubectl get all -n <namespace-name>`              | Lists all resources (pods, services, etc.) within a specific namespace.         |
| Check pod details in a namespace         | `kubectl get pods -n <namespace-name>`             | Lists all pods in a particular namespace.                                       |
| Debug pod issues in a namespace          | `kubectl describe pod <pod-name> -n <namespace-name>` | Describes the pod details to check events, errors, or misconfigurations.        |
| View logs of a pod in a namespace        | `kubectl logs <pod-name> -n <namespace-name>`      | Fetches logs from a pod in a specified namespace for troubleshooting purposes.  |
| Get events for a namespace               | `kubectl get events -n <namespace-name>`           | Lists all events for resources within the namespace (useful for debugging).     |
| Check the resource quota of a namespace  | `kubectl get resourcequota -n <namespace-name>`    | Displays resource quota details for a namespace, ensuring limits aren’t exceeded.|
| Get detailed info about a namespace      | `kubectl describe namespace <namespace-name>`      | Provides detailed information (labels, status) about a specific namespace.      |
| View secrets in a namespace              | `kubectl get secrets -n <namespace-name>`          | Lists all secrets available within the namespace.                               |
| Edit a namespace                         | `kubectl edit namespace <namespace-name>`          | Opens the namespace's YAML file for editing metadata or other configurations.   |
| Isolate namespace issues                 | `kubectl get pods -n <namespace-name> -o wide`     | Lists pod information, including node and IP, which can help isolate issues.    |


# 2.NameSpace:
In Kubernetes, namespaces are used to organize and separate resources within a cluster. They allow multiple teams or projects to coexist on the same cluster while ensuring proper isolation. Here’s how namespaces are crucial, especially for troubleshooting:

**Common Namespace Troubleshooting Issues**
- Resource Not Found in Namespace: Resources might be in a different namespace than expected.
- Quota Limits Exceeded: If a namespace has resource quotas, you might hit limits on CPU, memory, or storage.
- Role-Based Access Control (RBAC) Issues: Incorrect permissions might prevent access to resources in a namespace.
- 
## Kubernetes Namespace Troubleshooting Commands
| **Issue**                                         | **Command**                                                                                           | **Description**                                                                                       |
|-----------------------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| **List all namespaces**                            | `kubectl get namespaces`                                                                              | Retrieves a list of all namespaces in the cluster.                                                   |
| **Describe a namespace**                           | `kubectl describe namespace <namespace-name>`                                                          | Provides detailed information about a specific namespace, including resource quotas and limits.       |
| **List all resources in a namespace**              | `kubectl get all -n <namespace-name>`                                                                 | Lists all resources (pods, services, etc.) within a specified namespace.                              |
| **Check resource quotas in a namespace**            | `kubectl get resourcequotas -n <namespace-name>`                                                      | Displays the resource quotas set for a particular namespace.                                          |
| **Check pod status in a namespace**                 | `kubectl get pods -n <namespace-name>`                                                                 | Shows the status of all pods within the specified namespace.                                          |
| **Find pod in any namespace**                       | `kubectl get pods -A`                                                                                  | Searches for a pod across all namespaces.                                                             |
| **Switch to a different namespace**                 | `kubectl config set-context --current --namespace=<namespace-name>`                                    | Changes the current context to a different namespace.                                                 |
| **Describe a pod**                                  | `kubectl describe pod <pod-name> -n <namespace-name>`                                                  | Provides detailed information about a specific pod, including events and error messages.              |
| **View pod logs**                                    | `kubectl logs <pod-name> -n <namespace-name>`                                                          | Retrieves the logs of a pod, useful for diagnosing issues within the pod's containers.                |
| **Check node status**                                | `kubectl get nodes -o wide`                                                                            | Lists all nodes with detailed information, helping to identify issues at the node level.              |
| **Describe a node**                                 | `kubectl describe node <node-name>`                                                                     | Provides comprehensive details about a specific node, including resource usage and conditions.         |
| **Ping a service from a pod**                       | `kubectl exec -it <pod-name> -n <namespace-name> -- ping <service-ip>`                                 | Tests network connectivity between a pod and a service, aiding in diagnosing network issues.          |
| **Check service endpoints**                         | `kubectl get endpoints <service-name> -n <namespace-name>`                                             | Displays the endpoints of a service, useful for verifying service discovery and routing.              |
| **View events related to a pod**                    | `kubectl get events --sort-by=.metadata.creationTimestamp -n <namespace-name>`                        | Lists events in chronological order, assisting in diagnosing issues related to pod scheduling and management. |

# Deployment and StatefulSet in Kubernetes:
1. Deployment
A Deployment is a Kubernetes resource that manages a replicated application. It provides declarative updates for Pods and ReplicaSets, ensuring the desired state is maintained, and facilitating easy rollouts and rollbacks.
```yaml  
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: my-image:latest
        ports:
        - containerPort: 80
```
![image](https://github.com/user-attachments/assets/58e0149f-079f-4cdc-ba1c-3cebfeb0742b)
![image](https://github.com/user-attachments/assets/62033ac0-3a1f-4ca4-9d23-5222abaecb36)
![image](https://github.com/user-attachments/assets/309d6e43-88e9-4ad4-9055-c3629bb5c0c6)



2. StatefulSet
A StatefulSet is a Kubernetes resource designed for managing stateful applications. It provides unique network identities, stable persistent storage, and ordered deployment and scaling of Pods, making it ideal for applications like databases.
```yaml  
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: my-statefulset
spec:
  serviceName: "my-service"
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: my-container
        image: my-image:latest
        ports:
        - containerPort: 80
  volumeClaimTemplates:
  - metadata:
      name: my-storage
    spec:
      accessModes: ["PersistenT"]
      resources:
        requests:
          storage: 1Gi
```
# Kubernetes Commands
## Deployment Commands

| **Issue**                                         | **Command**                                                                                           | **Description**                                       |
|---------------------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------|
| Create a Deployment                               | `kubectl create deployment my-deployment --image=my-image`                                           | Create a Deployment using an imperative command.      |
| Create from a YAML file                          | `kubectl create -f deployment.yaml`                                                                   | Create a Deployment from a YAML file.                 |
| List all Deployments                              | `kubectl get deployments`                                                                              | List all Deployments in the current namespace.        |
| Describe a specific Deployment                    | `kubectl describe deployment my-deployment`                                                           | Show detailed information about a specific Deployment. |
| Scale the Deployment                              | `kubectl scale deployment my-deployment --replicas=5`                                               | Scale the Deployment to 5 replicas.                   |
| Update the Deployment                             | `kubectl set image deployment/my-deployment my-container=my-new-image`                                | Update the image of a Deployment.                      |
| Rollback to previous version                      | `kubectl rollout undo deployment/my-deployment`                                                       | Rollback to the previous version of a Deployment.      |
| Check rollout status                              | `kubectl rollout status deployment/my-deployment`                                                    | Check the status of a rollout.                         |

## StatefulSet Commands

| **Issue**                                         | **Command**                                                                                           | **Description**                                       |
|---------------------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------|
| Create a StatefulSet                              | `kubectl create statefulset my-statefulset --image=my-image`                                        | Create a StatefulSet using an imperative command.      |
| Create from a YAML file                          | `kubectl create -f statefulset.yaml`                                                                 | Create a StatefulSet from a YAML file.                |
| List all StatefulSets                             | `kubectl get statefulsets`                                                                            | List all StatefulSets in the current namespace.       |
| Describe a specific StatefulSet                   | `kubectl describe statefulset my-statefulset`                                                        | Show detailed information about a specific StatefulSet. |
| Scale the StatefulSet                             | `kubectl scale statefulset my-statefulset --replicas=5`                                             | Scale the StatefulSet to 5 replicas.                  |
| Update the StatefulSet image                      | `kubectl set image statefulset/my-statefulset my-container=my-new-image`                             | Update the image of a StatefulSet.                     |
| Check rollout status for StatefulSet              | `kubectl rollout status statefulset/my-statefulset`                                                  | Check the status of a rollout for StatefulSet.        |

## DaemonSet

### About
A DaemonSet ensures that a copy of a specific Pod runs on all (or a subset of) nodes in a Kubernetes cluster. As nodes are added to the cluster, Pods are added to them automatically. Conversely, when nodes are removed, the Pods are also removed.

### Use Case
DaemonSets are typically used for running cluster-wide services that need to operate on all nodes, such as:
- **Log collection**: Collecting logs from each node and sending them to a central logging service.
- **Monitoring agents**: Running monitoring tools that require access to node-level metrics.
- **Network proxies**: Deploying network proxies on all nodes for traffic management.

### Configuration
To create a DaemonSet, you need to define it in a YAML configuration file. Below is an example of a simple DaemonSet configuration.

### YAML Configuration
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: example-daemonset
  labels:
    app: example
spec:
  selector:
    matchLabels:
      app: example
  template:
    metadata:
      labels:
        app: example
    spec:
      containers:
      - name: example-container
        image: nginx
        ports:
        - containerPort: 80
```

```
view the status of the DaemonSet, use the command: : kubectl get daemonsets
To delete a DaemonSet, use: kubectl delete daemonset example-daemonset
```
![image](https://github.com/user-attachments/assets/9c3aa7e3-7fcb-4e76-b44d-b16b7cbd8bad)

## 4.Persistent Volumes (PV) and Persistent Volume Claims (PVC)

- **Persistent Volumes (PV)** are storage resources in the cluster that are provisioned by an administrator or dynamically provisioned using Storage Classes.
- **Persistent Volume Claims (PVC)** are requests for storage by a user, allowing them to claim a PV based on the storage requirements.

### Configuration (YAML Example)

# Kubernetes Commands

## Persistent Volumes (PV), Persistent Volume Claims (PVC), and Storage Class
### Overview
- **Persistent Volumes (PV)** are storage resources in the cluster.
- **Persistent Volume Claims (PVC)** are requests for storage by users.
- **Storage Classes** define the different types of storage that can be dynamically provisioned.

### PVC Access Modes

| **Access Mode**       | **Description**                                                                                                                                                          | **When to Use**                                                  |
|-----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------|
## Access Modes in PVCs

| **Access Mode**       | **Description**                                          | **Use Case Example**                           | **Scenario**                                         |
|-----------------------|----------------------------------------------------------|------------------------------------------------|-----------------------------------------------------|
| **ReadWriteOnce (RWO)**  | Mount the volume as read-write by a single node.    | Single-instance databases (e.g., MySQL).      | When a volume needs to be mounted as read-write by one node only. |
| **ReadOnlyMany (ROX)**   | Mount the volume as read-only by many nodes.         | Sharing configuration files among pods.       | When multiple pods need to read the same data without writing to it. |
| **ReadWriteMany (RWX)**   | Mount the volume as read-write by many nodes.        | Content management systems (e.g., WordPress). | When multiple instances need to read and write to the same volume concurrently. |

### Configuration Files

| **Issue**                                         | **Command**                                                                                           | **Description**                                       |
|---------------------------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------|
| Create a Persistent Volume                        | `kubectl create -f persistent-volume.yaml`                                                           | Create a Persistent Volume from a YAML file.          |
| List all Persistent Volumes                       | `kubectl get pv`                                                                                     | List all Persistent Volumes in the cluster.           |
| Describe a specific Persistent Volume             | `kubectl describe pv my-pv`                                                                          | Show detailed information about a specific PV.        |
| Create a Persistent Volume Claim                  | `kubectl create -f persistent-volume-claim.yaml`                                                    | Create a Persistent Volume Claim from a YAML file.    |
| List all Persistent Volume Claims                 | `kubectl get pvc`                                                                                     | List all Persistent Volume Claims in the current namespace. |
| Describe a specific Persistent Volume Claim       | `kubectl describe pvc my-pvc`                                                                        | Show detailed information about a specific PVC.       |
| Create a Storage Class                            | `kubectl create -f storage-class.yaml`                                                              | Create a Storage Class from a YAML file.              |
| List all Storage Classes                          | `kubectl get sc`                                                                                     | List all Storage Classes in the cluster.              |
| Describe a specific Storage Class                 | `kubectl describe sc my-storage-class`                                                               | Show detailed information about a specific Storage Class. |

# Persistent Volumes (PV), Persistent Volume Claims (PVC), and Storage Class YAML

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /data

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: my-storage-class
provisioner: kubernetes.io/no-provisioner
parameters:
  type: gp2
reclaimPolicy: Delete
```
# ConfigMaps

## About
ConfigMaps in Kubernetes are used to store non-confidential data in key-value pairs. They allow you to decouple configuration artifacts from image content to keep containerized applications portable. 

## Use Cases
- **Environment Variables**: Store configuration data for applications that can be loaded as environment variables.
- **Command-Line Arguments**: Pass configuration data as command-line arguments to containers.
- **Configuration Files**: Store entire configuration files that can be mounted into a container.

## 5. Configuration
### Example ConfigMap YAML
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
data:
  APP_NAME: myapp
  APP_ENV: production
  APP_VERSION: v1.0
```
## Troubleshooting Commands for ConfigMaps

| **Issue**                                       | **Command**                                                      | **Description**                                              |
|-------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------|
| View ConfigMaps                                 | `kubectl get configmaps`                                       | Lists all ConfigMaps in the current namespace.             |
| Describe a ConfigMap                           | `kubectl describe configmap <configmap-name>`                | Shows detailed information about a specific ConfigMap, including its metadata and data. |
| View specific ConfigMap data                   | `kubectl get configmap <configmap-name> -o yaml`             | Outputs the ConfigMap in YAML format for detailed inspection. |
| Check for ConfigMap usage in Pods              | `kubectl get pods --all-namespaces -o=jsonpath='{.items[*].spec.volumes[?(@.configMap.name=="<configmap-name>")].name}'` | Checks if any Pods are using the specified ConfigMap. |
| Delete a ConfigMap                             | `kubectl delete configmap <configmap-name>`                  | Deletes the specified ConfigMap.                            |
| Edit a ConfigMap                               | `kubectl edit configmap <configmap-name>`                    | Opens the ConfigMap in an editor for modification.         |
| View logs of Pods using ConfigMaps             | `kubectl logs <pod-name>`                                     | Retrieves the logs of a specific Pod to check for errors related to ConfigMap usage. |
| Check Pod events related to ConfigMaps         | `kubectl describe pod <pod-name>`                              | Shows events related to the Pod, which can indicate issues with ConfigMap mounts. |

## 6.Secrets in Kubernetes

### About
Kubernetes Secrets are objects that are used to store sensitive information, such as passwords, OAuth tokens, SSH keys, and other confidential data. Secrets allow you to keep this sensitive information separate from your application code and manage it securely.

### Use Cases
- **Storing Passwords**: Keep database credentials or API keys safe and secure.
- **Sensitive Configuration**: Manage sensitive configuration data that should not be exposed in source code or logs.
- **SSH Keys**: Store private keys for secure access to servers or services.
- **TLS Certificates**: Manage certificates used for encrypted communication between services.

### Configuration
To create a Secret in Kubernetes, you can use YAML files. Below is an example of a Secret definition:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  username: bXl1c2VybmFtZQ==   # Base64 encoded value
  password: cGFzc3dvcmQ=        # Base64 encoded value
```
## Troubleshooting Commands for Secrets

| **Issue**                                       | **Command**                                                      | **Description**                                              |
|-------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------|
| View Secrets                                    | `kubectl get secrets`                                          | Lists all Secrets in the current namespace.                |
| Describe a Secret                               | `kubectl describe secret <secret-name>`                       | Shows detailed information about a specific Secret, including its metadata and data. |
| View specific Secret data                       | `kubectl get secret <secret-name> -o yaml`                   | Outputs the Secret in YAML format for detailed inspection.  |
| Check for Secret usage in Pods                  | `kubectl get pods --all-namespaces -o=jsonpath='{.items[*].spec.volumes[?(@.secret.secretName=="<secret-name>")].name}'` | Checks if any Pods are using the specified Secret.         |
| Delete a Secret                                 | `kubectl delete secret <secret-name>`                         | Deletes the specified Secret.                               |
| Edit a Secret                                   | `kubectl edit secret <secret-name>`                           | Opens the Secret in an editor for modification.            |
| View logs of Pods using Secrets                 | `kubectl logs <pod-name>`                                     | Retrieves the logs of a specific Pod to check for errors related to Secret usage. |
| Check Pod events related to Secrets             | `kubectl describe pod <pod-name>`                              | Shows events related to the Pod, which can indicate issues with Secret mounts. |

## Differences Between Secrets and ConfigMaps

| **Feature**                | **Secrets**                                            | **ConfigMaps**                                      |
|----------------------------|-------------------------------------------------------|----------------------------------------------------|
| **Purpose**                | Stores sensitive information securely                  | Stores non-sensitive configuration data             |
| **Data Encoding**          | Data is base64 encoded                                 | Data is stored as plain text                        |
| **Access Control**         | Provides fine-grained access control using RBAC       | Limited access control; generally for configuration |
| **Use in Pods**            | Can be mounted as files or environment variables      | Can be mounted as files or environment variables    |
| **Type of Data**           | Used for confidential data (e.g., passwords, tokens)  | Used for application configuration (e.g., settings)|
| **Data Size Limit**        | 1MB limit per Secret                                  | 1MB limit per ConfigMap                             |
| **Isolation**              | Access is restricted to authorized users only         | Less restrictive; can be accessed by all Pods in a namespace |
| **Change Notification**    | Pods using Secrets may need to be restarted to pick up changes | Changes in ConfigMaps can be automatically updated in mounted volumes |

## Kubernetes Concepts

### Job
- **About**: A Job in Kubernetes is a controller that ensures one or more Pods successfully terminate. It is used for batch processing and is designed to run a finite number of tasks.
- **Use Case**: Jobs are ideal for running scripts or tasks that need to complete successfully, such as data processing, backups, or any operation that doesn't require continuous running.
- **Configuration**: Jobs are defined in YAML files and specify the desired state, such as the number of completions.

### Pod
- **About**: A Pod is the smallest deployable unit in Kubernetes, representing a single instance of a running process in a cluster. It can contain one or more containers.
- **Use Case**: Pods are used to host application containers and manage the network and storage resources required for those containers.
- **Configuration**: Pods are defined in YAML files and specify the container images, ports, and other settings.

### Node
- **About**: A Node is a physical or virtual machine that runs Kubernetes workloads. Each Node contains the necessary services to run Pods and is managed by the Kubernetes control plane.
- **Use Case**: Nodes are used to provide the compute resources required to run applications in a Kubernetes cluster.
- **Configuration**: Nodes are registered with the cluster and can be managed using the Kubernetes CLI.

### Cluster
- **About**: A Kubernetes Cluster is a set of Nodes that run containerized applications. It consists of a control plane and the Nodes where workloads are deployed.
- **Use Case**: Clusters provide a platform for managing containerized applications, enabling scaling, load balancing, and high availability.
- **Configuration**: Clusters are created using tools like `kubectl` or managed services like Azure Kubernetes Service (AKS).

### Worker Node Cluster
- **About**: A Worker Node Cluster is a specific type of cluster where Nodes are dedicated to running application workloads. These Nodes do not host control plane components.
- **Use Case**: Worker Node Clusters are used for scaling applications and managing workloads independently from the control plane.
- **Configuration**: Worker Nodes are added to a cluster to increase the capacity for running applications and can be managed separately from the control plane.

## Taints and Tolerations

### Taints
- **About**: Taints are a way to mark a Node so that no Pods will be scheduled on it unless those Pods have a matching toleration. This helps in controlling which Pods can be deployed on which Nodes.
- **Use Case**: Taints are used to prevent certain Pods from being scheduled on specific Nodes, such as reserving Nodes for specific workloads or isolating problematic Nodes.
- **Configuration**: Taints are applied to Nodes and have three components: the key, value, and effect. The effect can be `NoSchedule`, `PreferNoSchedule`, or `NoExecute`.

### Tolerations
- **About**: Tolerations are applied to Pods and allow them to be scheduled on Nodes with matching taints. They provide a way for Pods to tolerate certain conditions on Nodes.
- **Use Case**: Tolerations are used to ensure that specific Pods can be scheduled on Nodes that have been tainted, enabling flexibility in workload management.
- **Configuration**: Tolerations are defined in the Pod specification and must match the taints on the Nodes for the Pods to be scheduled.

### Example Configuration

#### Taint
```yaml
kubectl taint nodes <node-name> key=value:NoSchedule
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  tolerations:
  - key: "key"
    operator: "Equal"
    value: "value"
    effect: "NoSchedule"

```
### Types of Taints

| **Type**               | **Description**                                                                                   |
|------------------------|---------------------------------------------------------------------------------------------------|
| **NoSchedule**         | Pods will not be scheduled on the node unless they have a matching toleration.                   |
| **PreferNoSchedule**   | Kubernetes will try to avoid scheduling Pods on the node, but it is not a hard requirement.      |
| **NoExecute**          | Pods that are already running on the node will be evicted if they do not have a matching toleration, and new Pods will not be scheduled on the node. |

### Affinity and Anti-Affinity Concepts

| **Concept**           | **Description**                                                                                              | **Use Case**                                                                               |
|-----------------------|--------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------|
| **Node Affinity**     | Rules that allow you to constrain which nodes your Pod is eligible to be scheduled on based on labels.     | Scheduling Pods on nodes with specific hardware or software requirements.                  |
| **Pod Affinity**      | Rules that allow you to specify that a Pod should be scheduled in proximity to another Pod.                 | Ensuring that Pods that need to communicate frequently are located close to each other.   |
| **Pod Anti-Affinity** | Rules that prevent a Pod from being scheduled in proximity to other specified Pods.                          | Spreading Pods across nodes to avoid single points of failure or resource contention.      |

-------------------

## 1. How do you check the status of a pod?
```
kubectl get pods -o wide
kubectl describe pod <pod-name>
```
## 2. How do you debug a CrashLoopBackOff pod?
```
kubectl logs <pod-name>
kubectl logs <pod-name> --previous
```
- **Explanation**: Check the logs of the failing pod. If a container crashes, --previous shows logs from the previous instance.
  
## 4. What command is used to troubleshoot node issues?
```
kubectl describe node <node-name>
kubectl get nodes -o wide
```
- **Explanation**: Check the node’s status and issues related to CPU, memory, or networking.
## 5. How do you troubleshoot network connectivity issues in Kubernetes?
```
kubectl exec -it <pod-name> -- ping <service-ip>
kubectl get svc
kubectl get endpoints <service-name>
```
- **Explanation**: You can ping between pods or services to verify network connectivity. Use `kubectl get svc` and `endpoints` to ensure services are properly routed.
## 7. How do you troubleshoot if a pod is stuck in Pending state?
```
kubectl get pod <pod-name> -o wide
kubectl describe pod <pod-name>
kubectl describe nodes

```
- **Explanation**: A pod may be stuck in `Pending` if there are insufficient resources or issues with node scheduling. `kubectl describe` helps identify resource limits or affinity issues.
  
## 8. How do you troubleshoot DNS issues in a Kubernetes cluster?
```
kubectl exec -it <pod-name> -- nslookup <service-name>
kubectl exec -it <pod-name> -- dig <service-name>

```
- **Explanation**: Use `nslookup` or `dig` inside the pod to verify DNS resolution.
Explanation: Use nslookup or dig inside the pod to verify DNS resolution.
## 9. How do you view logs for a Kubernetes control plane component (e.g., kubelet)?
```
journalctl -u kubelet

```
- **Explanation**: On the node, use journalctl to check logs for kubelet, etcd, or api-server to troubleshoot control plane issues.
  
## 10. How do you troubleshoot if a service is not reachable via external IP?
```
kubectl get svc <service-name>
kubectl describe svc <service-name>
kubectl get ingress
```
- **Explanation**: Ensure the service is exposed correctly and check the ingress configuration for proper routing.
