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

## Linux Commands Cheatsheets

### Reverse Search

Press `ctrl+r` type the `Keyword` in the command history

![Reverse Search](reverse-search.gif)

### grep

Use the `grep` command after the ` | ` command with below useful switch

`-i`, `--ignore-case` --> ignore case distinctions in patterns and data

`--no-ignore-case`      do not ignore case distinctions (default)
![grep -i](grep-i.gif)

#### Context control:

  `-B`, `--before-context=NUM`  print NUM lines of leading context

  `-A`, `--after-context=NUM`   print NUM lines of trailing context

  `-C`, `--context=NUM`         print NUM lines of output context
![grep -A](grep-A4.gif)


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

