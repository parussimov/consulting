## Links

- [Managed Collection](https://cloud.google.com/stackdriver/docs/managed-prometheus/setup-managed)
- [How to Create GKE Cluster Using TERRAFORM?](https://github.com/antonputra/tutorials/tree/main/lessons/108)
- [Custom-Metrics](https://github.com/antonputra/tutorials/tree/d51910561a1ec1d5a377a41167edb89fc28faa83/lessons/181/1-hpa/custom-metrics)
- [Managed collection recommended approach](https://cloud.google.com/stackdriver/docs/managed-prometheus#gmp-data-collection)
- [IAM permissions - Monitoring Metric Writer](https://cloud.google.com/monitoring/access-control#mon_roles_desc)
- [Managed Service for Prometheus CRs](https://github.com/GoogleCloudPlatform/prometheus-engine/blob/v0.10.0/doc/api.md)
- [Dashboards](https://github.com/antonputra/tutorials/tree/main/lessons/135)
- [Query using Grafana]()
- [Main Tutorial](https://github.com/antonputra/tutorials/tree/d51910561a1ec1d5a377a41167edb89fc28faa83/lessons/132)
- [Standalone Prometheus frontend UI](https://cloud.google.com/stackdriver/docs/managed-prometheus/query-api-ui)
- [Drop metrics](https://www.robustperception.io/dropping-metrics-at-scrape-time-with-prometheus/)

- [Enabling the target status feature](https://cloud.google.com/stackdriver/docs/managed-prometheus/setup-managed#target-status)

## Commands

```bash
gcloud auth application-default login
gcloud services list --enabled --project k8s-dev-716099
gcloud container clusters get-credentials main --zone us-central1-a --project k8s-dev-716099
kubectl get pods -n gmp-system
kubectl get crds
kubectl get crds | grep monitoring.googleapis.com
kubectl logs -f collector-k2xxn -n gmp-system
kubectl port-forward cadvisor-v8t2d 8080 -n monitoring
curl localhost:8080/metrics
curl localhost:8080/metrics | grep container_cpu_usage_seconds_total
check container_cpu_usage_seconds_total metric in monitoring tab
```

Check collector logs for permission errors

```bash
kubectl logs -f collector-k2xxn -n gmp-system
```

Check status of the target

```bash
kubectl -n monitoring describe podmonitoring cadvisor
```


```bash
kubectl port-forward myapp-8bcff6cc5-64cqr 8081 -n myapp
curl localhost:8081/metrics
kubectl describe PodMonitoring -n myapp
up
myapp_request_duration_seconds{quantile="0.9"}
kubectl port-forward svc/frontend 9090 -n gmp-monitoring
kubectl port-forward svc/grafana 3000 -n gmp-monitoring
Data source: http://frontend:9090
```