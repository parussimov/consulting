# ArgoCD + ECR authentication

- [ArgoCD](argocd-image-updater.argoproj.io/myalias.update-strategy)
- [Argo Image Updater with AWS ECR](https://medium.com/@tomas94depi/argo-image-updater-with-aws-ecr-ddb661abb332)

kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

docker tag aputra/myapp-003-amd64:v1 424432388155.dkr.ecr.us-east-2.amazonaws.com/myapp-003-amd64:v1

docker push 424432388155.dkr.ecr.us-east-2.amazonaws.com/myapp-003-amd64:v1


