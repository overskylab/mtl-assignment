# MTL Assignment

1. [Dockerfile](Dockerfile)

2. Located at [Dockerhub](https://hub.docker.com/repository/docker/overskylab/mtl-assignment/general)

3. Helm Chart located at [charts directory](charts/)

4. IaC code located at [infrastructure directory](infrastructure/)

5. IAM policy located at [policy.tf](./infrastructure/policy.tf)

6. To deploy the argo application

    ```shell
    kubectl apply -f argo-app.yaml -n default
    ```

7. CICD workflow diagram located at [cicd-workflow.drawio](assignments/cicd-workflow.drawio)

8. Infrastructure architecture diagram located at [infrastructure-design.drawio](assignments/infrastructure-design.drawio)

#### How to test Terraform code

- Pre-requisites

  ```shell
  brew install localstack
  pip install terraform-local
  ```

- Test the terraform code

  ```shell
  cd infrastructure
  terraform init
  terraform plan
  terraform apply

  # Validate the config
  tflocal validate
  ```

- Known issues
  - Localstack does not support all AWS services, so some resources may not be created.
  - CloudWatch logs are not supported in localstack, so the logs will not be created.

#### How to test the Helm chart

```shell
cd charts
helm upgrade -i app-api ./ -f values.yaml

# To destory
helm delete app-api
```

#### How to test the Kustomization

```shell
kustomize build kustomize/base | kubectl apply -f -

# To destroy
kustomize build kustomize/base | kubectl delete -f -
```
