# AWS

## Adding AWS Load Balancer Controller

In order to be able to expose application to the rest of the world we need a 
load balancer. In order to do that we need to install the AWS load balancer
controller.

Follow the instructions at the official [https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.5/](AWS Load Balancer Controller).

First you have to install the `cert-manager`:

```
kubectl apply --validate=false -f clusters/aws_alb/v1_5_4_cert-manager.yaml
```

Then the `aws_load_balancer_controller`

**BEFORE APPLYING THE NEXT MANIFEST**: you have to make sure the `--cluster-name`
parameter has the name of the cluster we've just created.


```yaml
apiVersion: apps/v1
kind: Deployment
. . .
name: aws-load-balancer-controller
namespace: kube-system
spec:
    . . .
    template:
        spec:
            containers:
                - args:
                    - --cluster-name=<INSERT_CLUSTER_NAME>

```

And apply the edited manifest:

```
kubectl apply -f clusters/aws_alb/v2_5_1_full.yaml
```

And finally, the `ingress class` manifest:

```
kubectl apply -f clusters/aws_alb/v2_5_1_ingclass.yaml
```