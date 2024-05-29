# GCP managed Prometheus self-deployed

## Links

- [Get started with self-deployed collection](https://cloud.google.com/stackdriver/docs/managed-prometheus/setup-unmanaged)
- [Data collection](https://cloud.google.com/stackdriver/docs/managed-prometheus#gmp-data-collection)
- [Reduce metrics costs by filtering collected and forwarded metrics](https://grafana.com/docs/grafana-cloud/cost-management-and-billing/reduce-costs/metrics-costs/client-side-filtering/)
- [How relabeling in Prometheus works](https://grafana.com/blog/2022/03/21/how-relabeling-in-prometheus-works/)
- [How to drop and delete metrics in Prometheus](https://faun.pub/how-to-drop-and-delete-metrics-in-prometheus-7f5e6911fb33)

## Commands

### First of all, we need to install the custom resources for Prometheus Operator.

```bash
kubectl apply --server-side -f 0-prometheus-operator-crd
```

### Next, we need to deploy the Prometheus Operator.

```bash
kubectl apply -f 1-prometheus-operator
```

### Verify that the operator is running and there are no errors in the logs.

```bash
kubectl get pods -n gmp-monitoring
```

### Next, we need to create a GCP service account with the following role. This will allow Prometheus to push metrics to the GCP console, and they will be accessible through Metrics Explorer.

- terraform/10-gmp-prometheus-sa.tf

```
roles/monitoring.metricWriter
```

### Update the Prometheus Kubernetes service account with the following annotation:

- 2-prometheus/0-service-account.yaml

```
iam.gke.io/gcp-service-account: gmp-prometheus-test@k8s-dev-643716.iam.gserviceaccount.com
```

### Deploy Prometheus using the Prometheus Operator.

```bash
kubectl apply -f 2-prometheus
```

### Deploy a sample application and create a target.

```bash
kubectl apply -f 3-myapp
```

### Additionally, you can port forward to Prometheus and check the target.

```bash
kubectl port-forward svc/prometheus-operated 9090 -n gmp-monitoring
open http://localhost:9090/
```