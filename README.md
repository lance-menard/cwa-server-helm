# Corona-Warn-App Server Helm Chart

This repo contains a Helm chart that can be used to deploy the [Corona-Warn-App (CWA) server](https://github.com/corona-warn-app/cwa-server) onto any supported Kubernetes cluster.

## Cluster requirements

Test setup was performed on a CloudLab Kubernetes cluster created using the "k8s" profile. An EKS, AKS, or other cloud Kubernetes hosting provider would work just as well (or better), but would need to follow the vendor's process for authenticating to the cluster.

### CloudLab Limitations

Due to the CloudLab cluster's SSL configuration, use of the `--insecure-skip-tls-verify` flag is required to access the cluster control plane API.  This is reflected in the kube config file below.

### Cluster Access

Follow [the documentation](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#normal-user) to generate a CSR and certificate for a new user.  Copy the client-certificate-data and client-key-data into the provided `config.cwa-server` and copy that file to `~/.kube/config`.

## Using the Chart

### Installation

Once access to the Kubernetes cluster is configured, simply run `./scripts/install-cwa-server.sh`.

### Updating

To update to a new version of the CWA server application, update the APP_VERSION value in `.env`, make any changes required to the templates, and run `./scripts/upgrade-cwa-server.sh`.

### Uninstalling

To uninstall the CWA server application, run `./scripts/uninstall-cwa-server.sh`.

## Caveats, Challenges, and Remaining Work

### Caveats

In short: this Helm chart is _not_ "production-ready".

- Experimental clusters created via CloudLab do not come with SSL certificates for the control plane; thus the `--insecure-skip-tls-verify` flag is required.
- Chart includes a simple one-node PostgreSQL server via the [Bitnami Helm chart](https://github.com/bitnami/charts/tree/master/bitnami/postgresql/). For a production deployment a multi-node HA cluster is recommended, possibly utilizing a cloud provider's hosted database system (e.g. AWS RDS).
- Included PostgreSQL server has persistence disabled.  For a production deployment with an in-cluster Postgres server, use of an external storage provisioner (e.g. AWS EBS, Azure Disk) is required, with HA and automated backup strongly recommended.
- Chart includes custom "local testing" configuration to disable SSL between services to simplify key management.  For production deployments, SSL is recommended.
- All services are deployed into a single namespace. For production deployments, separate namespaces for data storage and application tiers are recommended.
- This deployment is using mock verification and EFGS services provided for testing local deployments of the CWA server.
- This deployment is using a personal Docker Hub account; for a production deployment, a controlled Docker image repository integrated with an automated build system is recommended.

### Challenges

- I'm used to building application using AWS EKS clusters, which support AWS-native features like EBS persistent volumes and ALB ingress load balancers, as well as the eksctl CLI tool.  Not having these features available meant using many more low-level tools than usual.
- Most of the time spent on this chart was actually spent on the PostgreSQL server - particularly on the chart's system for injecting init scripts in order to automate user creation.  For a true "production-ready" infrastructure, there'd be an additional layer of orchestration involved (like AWS CloudFormation) to help automate new infrastructure.

### Remaining work:

- Ingress: The architecture documentation is unclear exactly which services and ports would need to be exposed outside the cluster.  Once established, ingress would be configured using Ingress resources utilizing the nginx ingress controller (or any other support ingress controller - e.g. AWS ALB).
- Multi-node cluster: This Helm chart has not yet been deployed on a multi-node cluster.  However, the goal of using a Helm chart in the first place is that the deployment should be identical for clusters of any size, so no changes should be required.