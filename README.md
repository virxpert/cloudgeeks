## Welcome to the Kubernetes cheat sheet for shorthand configurations
![CI](https://github.com/virxpert/k8s.github.io/workflows/CI/badge.svg)

### create .vimrc file to set the VIM interpreter to best config

create a `.vimrc` file at the root location

`vim ~/.vimrc`

post this update it with following commands

```
set number
set smarttab
set autoindent
set shiftwidth=2
set expandtab
```
Set the alias for the `kubectl`

`alias k=kubectl`

## Linux Commands Cheatsheets

### Reverse Search

Press `ctrl+r` type the `Keyword` in the command history

![Reverse Search](reverse-search.gif)

### grep

Use the `grep` command after the _`pipe`_ command with below useful switch

`-i`, `--ignore-case` --> ignore case distinctions in patterns and data

`--no-ignore-case`      do not ignore case distinctions (default)
![grep -i](grep-i.gif)

#### Context control:

  `-B`, `--before-context=NUM`  print NUM lines of leading context

  `-A`, `--after-context=NUM`   print NUM lines of trailing context

  `-C`, `--context=NUM`         print NUM lines of output context
![grep -A](grep-A4.gif)


## Kubernetes Cheatsheet

### K8s Useful switch(s)
To get all pods in all Namespaces

`k get all -A`
|`-A` | used for shorthand for --all-namespaces |
### Pods
`k run pod --image=nginx --dry-run=client -oyaml >pod.yaml`
#### remote into Pod
`k exec --stdin --tty ds-one-kjds -- /bin/bash`


### ReplicaSets

### Services

### Labels

### Job & CronJobs

### annotations

### Deployments

### DaemonSets


Example Yaml
```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: ds-one
spec:
  selector:
    matchLabels:
      system: DaemonSetOne
  template:
    metadata:
      labels:
        system: DaemonSetOne
    spec:
      containers:
      - name: nginx
        image: nginx:1.15.1
        ports:
        - containerPort: 80
```
### Rolling Updates and Rollbacks

flag _`OnDelete`_ upgrades the container when the predecessor is deleted.

Flag _`RollingUpdate`_ begins the update immediately.


### Volume and Data

- Encoded data can be passed using a Secret and non-encoded data can be passed with a _ConfigMap_. These can be used to pass important data like _SSH keys_, _passwords_, or even a configuration file like `/etc/hosts`.
The cluster groups volumes with the same mode together, then sorts volumes by size, from smallest to largest. The claim is checked against each in that access mode group, until a volume of sufficient size matches.The three access modes are:

    - ReadWriteOnce, which allows read-write by a single node.
    - ReadOnlyMany, which allows read-only by multiple nodes.
    - ReadWriteMany, which allows read-write by many nodes. 
    
Sample Yaml

```
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: volumetest
  name: volumetest
spec:
  containers:
  - image: nginx
    name: volumetest
    command:
      - sleep
      - "3600"
    volumeMounts:
      - mountPath: /scratch
        name: scratch-volume
  volumes:
  - name: scratch-volume
    emptyDir: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```
  
#### Volume Types

|Cloud |  Volume Type |
|------|-------|
|GCE  |  GCEpersistentDisk |
|AWS  |  awsElasticBlockStore |

#### Persistent Volumes and Claims

Persistent storage phases

_**Provision** `==>` **Bind** `==>` **Use** `==>` **Release** `==>` **Reclaim**_

Commands:

`Kubectl get pv` 

`Kubectl get pvc`

#### Persistent Volume
Create a persistent Volume using below yaml
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: 10gpv01
  labels:
    type: local
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/somepath/data01"
```

