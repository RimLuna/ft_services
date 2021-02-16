# ft_services: failing to blindly copy googled setup guides

## fucking minikube
```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.27.0/minikube-darwin-amd64 &&\\n  chmod +x minikube
minikube start
brew install kubectl
kubectl
kubectl version
kubectl cluster-info
minikube dashboard
```
# NEW PLAN: not jumping to conclusions
# Cluster architecture
First there are the kubernetes *objects*, these describe what containerized services/apps are running, the ressources used or available for them,, and the policies and definitions of rules around lesauelles they behave (start, restart, upgrade..).

## Describing a kubernetes object
Generally, an object will contain two nested object fields, *spec* and *status*. The *spec* field will be defined when creating the object, describing the *desired state*. While the *status* field will be updated and supplied by the kubernetes system, it describes the *current state* of the object.

**most often, this API request is provided in the format of a .yaml file**
```
apiVersion: apps/v1
kind: Deployment
metadata:
    name: nginx-deployment
spec:
  selector:
    matchLabels:
      app: nginx
  replicas: 2
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80
```
YAML file are even worse than python files, cancerous, but *I will not complain any further*. **SO MANY ERRORS**, and this is my FIRST fucking yaml file.

`error: error validating "nginx-deployment.yaml": error validating data: [ValidationError(Deployment.spec.selector): unknown field "replicas" in io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector, ValidationError(Deployment.spec.selector): unknown field "template" in io.k8s.apimachinery.pkg.apis.meta.v1.LabelSelector, ValidationError(Deployment.spec): missing required field "template" in io.k8s.api.apps.v1.DeploymentSpec]; if you choose to ignore these errors, turn validation off with --validate=false`

This stupid error and all the errors that followed are caused by bad indentations so far, or bad placing of *-* or whatever nonsense.
```
kubectl apply -f nginx-deployment.yaml --record
deployment.apps/nginx-deployment created
```
The deployment was created and I hve no idea what the fuck to do next???.

## Pods: because the documentation said I should look at them
A Pod is similar to a group of Docker containers with shared namespaces and shared filesystem volumes, this is all I got.

* pods that run a single container (will use this, because I don't even know how to run one, let alone multiple ones working together)
* pods running multiple containers

## Storage and networking in Pods & privileged mode
A pod can specify a set of shared volumes that all containers in the pod have access to and share data  with. Volumes also allow persistent data in pods to survive in case one of the containers within the pod needs a restart.

Each pod is assigned a unique IP address for each address family, containers within the pod all share that address *namespace*, including the IP address and the open ports. The containers that belong to that pod can communicate with one another using `localhost`. So when the containers in that pod want to communicate with the *outside*, I must coordinate their use of ports and network namespace. Containers within the Pod see the system hostname as being the same as the configured name for the Pod.

*Well fuck*.

`privileged` flag (which can be enabled by a container in a pod) from the security context of the container spec, processes inside a privileged container get almost the same privileges as processes outside a container.

## Namespaces: since they are mentioned alot
Namespaces are a way to divide cluster resources between multiple users. They are virtual clusters supported by the same physical cluster. They're intended for use in environments with many users. *Not my case, I'm never using this shit*. 
### Something about namespaces and DNS that sounds useless.
When creating a *service*, it creates a DNS entry, in the form `<service-name>.<namespace-name>.svc.cluster.local`, *the fuck is this*. which means that if a container just uses `<service-name>`, it will resolve to the service which is local to a namespace.

*I'm gonna pretend this is useless because I can't understand it*.

Objects that are in namespaces:

* pods, services, replication controllers, deployments, and others

While, low-level resources, such as nodes and persistentVolumes, are not.

`kubectl api-resources --namespaced=(false/true)`

# Nodes: what a fucking vague name
Kubernetes runs your workload by placing containers into Pods to run on Nodes. A cluster has multiple nodes. *That's all I need*.

## Creating and managing a stupid node
Of course I will manually creates nodes, and I don't even fucking know how. The documentation is so *vague*.

It says the name of the node must be a valid DNS subdomain name. 
```
{
  "kind": "Node",
  "apiVersion": "v1",
  "metadata": {
    "name": "10.240.79.157",
    "labels": {
      "name": "my-first-k8s-node"
    }
  }
}
```
I don't fucking understand *ANYTHING*.

## Node status: Addresses, Conditions, Capacity and Allocatable and Info
To view the *stupid* status: `kubectl describe node <insert-node-name-here>`.

Addresses:
* HostName: The hostname as reported by the node's kernel. Can be overridden via the kubelet --hostname-override parameter.
* ExternalIP: Typically the IP address of the node that is externally routable (available from outside the cluster).
* InternalIP: Typically the IP address of the node that is routable only within the cluster.

The `conditions` field describes the `status` of all `Running` nodes.
*  Ready: `True` if the node is healthy and ready to accept pods, *I don't care for the other conditions now*.

Capacity and Allocatables escribe the resources available on the node: CPU, memory and the maximum number of pods that can be scheduled onto the node.

*I hate this, I don't CARE*.
## Graceful Node Shutdown: sounds interesting and useful, but i dk yet
*it's a feature.*

# So far..
A kubernetes consists of a set of worker containers, called `nodes`, that run containerized applications. 

The worker nodes host `pods` that are the components of the application workload. The `control plane` manages the worker nodes and pods in the cluster. *And other useless shit I don't even remember*.

I still have nothing to work with.. I hate my life.