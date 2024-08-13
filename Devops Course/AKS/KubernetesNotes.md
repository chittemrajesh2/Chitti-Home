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
## 2. Nodes: 
These are the worker machines that actually run your containers. Each node has:
- **Kubelet**: An agent that runs on each node and communicates with the control plane. It's 
responsible for managing pods and containers on the node.
- **Container Runtime**: The software that actually runs your containers. Popular options 
include Docker, containerd, and CRI-O.
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
