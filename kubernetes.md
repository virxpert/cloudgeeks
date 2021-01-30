## Welcome to the Kubernetes cheat sheet for shorthand configurations

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

## Kubernetes Cheatsheet

### Pods
`k run pod --image=nginx --dry-run=client -oyaml >pod.yaml`

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
  replicas: 2
  selector:
    matchLabels:
      system: DaemonSetOne
  template:
    metadata:
      labels:
        system: ReplicaOne
    spec:
      containers:
      - name: nginx
        image: nginx:1.15.1
        ports:
        - containerPort: 80
```


