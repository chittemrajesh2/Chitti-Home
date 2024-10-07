
## Here’s a brief explanation and use case for each concept you provided:

# 1. Port Forwarding:
- Explanation: It allows access to a specific port of a pod directly from your local machine without exposing it outside the cluster.
- Use Case: Debugging applications running inside a pod without exposing the service externally.
```
kubectl port-forward pod/<pod-name> <local-port>:<container-port>
```
- Example: Forwarding port 8080 of a pod to local machine port 9090.
```kubectl port-forward pod/my-app-pod 9090:8080```
# 2. kubectl expose port:
- Explanation: Exposes a Kubernetes pod or deployment as a service.
- Use Case: To allow external access to your application or service inside the cluster.
```kubectl expose pod/<pod-name> --port=<port> --target-port=<container-port>```
- Example: Exposing port 8080 of a pod.
```kubectl expose pod/my-app-pod --port=80 --target-port=8080```
# 3. Container Port:
- Explanation: The port on which the containerized application listens.
- Use Case: Specifies which port inside the container receives the traffic.
- Example: In a pod YAML, define the containerPort:
```yaml
ports:
  - containerPort: 8080
```
# 4. Node Selector:
- Explanation: A label-based mechanism to assign pods to specific nodes.
- Use Case: Ensure pods are scheduled only on specific nodes.
- Command: Define in pod spec under nodeSelector.

```yaml

nodeSelector:
  disktype: ssd
```
# 5. Manual Scheduling Pods:
- Explanation: Directly assign pods to specific nodes using the nodeName field.
- Use Case: Useful when testing or controlling where a pod should run.

```yaml
spec:
  nodeName: worker-node-1
```
# 6. Taint and Toleration:
- Explanation: Taints prevent pods from being scheduled on nodes unless they tolerate the taint.
- Use Case: To isolate certain workloads or nodes (e.g., for specific applications or hardware).

```kubectl taint nodes <node-name> key=value:NoSchedule```
Example:
```yaml
tolerations:
  - key: "dedicated"
    operator: "Equal"
    value: "gpu"
    effect: "NoSchedule"
```
# 7. ReplicaSet vs Replication Controller:

- ReplicationController ensures a set number of pods are running.
- ReplicaSet is a newer version with additional features like label selectors.
- Use Case: Maintaining desired pod count, ReplicaSet is mostly used in modern deployments.

```kubectl get replicaset
kubectl get replicationcontroller
```
# 8. Knowing API Version:
```
kubectl explain <resource>
kubectl explain pod
```
# 9. DaemonSet:
- Explanation: Ensures that all (or some) nodes run a copy of a pod.
- Use Case: Monitoring tools like Prometheus or log collectors.

```
kubectl get daemonset
```
# 10. CronJob:
- Explanation: A scheduled job in Kubernetes.
- Use Case: Running recurring tasks (e.g., backup jobs).
```
kubectl get cronjob
```
# 11. Node Pool:
- Explanation: A collection of nodes in AKS or other Kubernetes platforms, often used for different workloads.
- Use Case: Run different workloads on specific node pools (e.g., GPU-based tasks).
Command:
```
az aks nodepool list --resource-group <rg-name> --cluster-name <aks-name>
```
# 12. Init Container:
- Explanation: Special containers that run before the main containers in a pod.
- Use Case: Pre-configuration or setup tasks like downloading dependencies before the main app starts.
```yaml
initContainers:
  - name: init-myservice
    image: busybox
    command: ['sh', '-c', 'echo initializing...']
```
# 13. Deployment Strategies:
- Explanation: Different ways to deploy changes (e.g., rolling updates, blue-green).
- Use Case: Control how updates are rolled out in Kubernetes to avoid downtime.
- Example: Rolling update strategy.
```yaml

strategy:
  type: RollingUpdate
```
# 14. Static Pod:
- Explanation: Pods managed directly by the kubelet on a node, not by the control plane.
- Use Case: Kubernetes core components (like etcd, kube-apiserver) are usually static pods.
```
kubectl get pods -n kube-system
```
# 15. AKS Default Resource Group:
- Explanation: AKS creates a default resource group to store underlying infrastructure.
- Use Case: Automatically manages resources like VMs and networking.
```
az aks show --resource-group <rg-name> --name <aks-name>
```
# 16. RBAC:
- Explanation: Role-Based Access Control, a mechanism to define access rules.
- Use Case: Limit user actions on Kubernetes resources.
Example:
```yaml

kind: Role
apiVersion: rbac.authorization.k8s.io/v1
```
# 17. Ingress:
- Explanation: Manages external access to services in a Kubernetes cluster, typically HTTP/HTTPS.
- Use Case: Expose services with specific routing rules.
```
kubectl apply -f ingress.yaml
```
# 18. Requests and Limits:
- Explanation: Define CPU and memory resource requests and limits for a pod.
- Use Case: Optimize resource allocation in a cluster.
```yaml
resources:
  requests:
    memory: "64Mi"
    cpu: "250m"
  limits:
    memory: "128Mi"
    cpu: "500m"
```
# 19. CoreDNS:
Explanation: DNS server that runs in the cluster to resolve service names.
Use Case: Internal DNS resolution for Kubernetes services.
```kubectl get pods -n kube-system -l k8s-app=kube-dns```
# 20. Pod Affinity and Anti-Affinity:
- Explanation: Controls which nodes or pods a pod can (or cannot) be scheduled on.
- Use Case: Ensure certain pods run together or are spread across nodes.
```yaml
affinity:
  podAntiAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchExpressions:
            - key: app
              operator: In
              values:
              - frontend
```
