# Helm Commands Used by DevOps Engineer on a Daily Basis

## Add Repository to Helm
```bash
helm repo add <Repository_Name> <Helm_Repository_Url>
```

## Display Repositories Added to Helm
```bash
helm repo ls
```

## Display Charts Available in Repository
```bash
helm search repo <Repository_Name>
```

## Create a New Helm Chart
```bash
helm create <Helm_Chart_Name>
```
- Default Helm Chart Directory will be created.
- As part of the Helm Chart, Kubernetes manifest files like Deployment and Service YAML files, etc., will be created.

### Helm Chart Directory Structure
```
<Helm_Chart_Name>/
├── charts/                 # Dependency charts
├── templates/              # Kubernetes YAML templates
│   ├── deployment.yaml     # Deployment manifest
│   ├── service.yaml        # Service manifest
│   ├── _helpers.tpl        # Helper templates
│   ├── ingress.yaml        # Ingress manifest (optional)
│   └── NOTES.txt           # Post-deployment notes
├── values.yaml             # Default configuration values
├── Chart.yaml              # Metadata about the Helm Chart
└── README.md               # Documentation for the Helm Chart
```

## Display Kubernetes Manifest Files in Helm Chart
```bash
helm template <Helm_Chart_Name>
```
- Displays Kubernetes manifest files like Deployment and Service YAML files available in the created Helm Chart.

**Note:**
- Modify Kubernetes manifest files as per requirements before deploying a Helm Chart into a Kubernetes cluster.
- Use the `helm template` command every time you modify the Helm Chart to validate your changes.

## Display Helm Chart Values
```bash
helm show values <Helm_Chart_Name>
```
- Displays the values of the Helm Chart which are used in templates.

## Check Helm Chart Indentation
```bash
helm lint <Helm_Chart_Name>
```
- Verifies that the indentation is correct after modifying Kubernetes deployment manifests.

## Dry Run Helm Chart
```bash
helm install <ReleaseName> <Helm_Chart_Name> --dry-run
```
- Validate Helm Charts before deployment.
- Dry Run allows testing a Helm Chart without modifying the cluster's state.

## Deploy Helm Chart
```bash
helm install <ReleaseName> <Helm_Chart_Name>
helm install <ReleaseName> <Helm_Chart_Name> -n <Namespace>
```

## List Deployed Applications Using Helm Chart
```bash
helm ls
helm ls -n <Namespace>
```
- Lists applications deployed using Helm Charts in a Kubernetes cluster.

## Update Docker Image Version and POD Replica Count at Runtime
```bash
helm upgrade <ReleaseName> <Helm_Chart_Name> --set image.tag=2 --set replicaCount=2
```
**Note:**
- Once a Helm Chart is deployed, it is suggested to use the `helm upgrade` command instead of `helm install`.

## Roll Back to Previous Revision
```bash
helm rollback <ReleaseName>
helm rollback <ReleaseName> -n <Namespace>
```

## Uninstall Helm Chart
```bash
helm uninstall <Release_Name>
helm uninstall <Release_Name> -n <Namespace>
```
- Resources created by the Helm Chart will be deleted from the Kubernetes cluster.
