# How do I convert the service mesh ingress demo to Validated Pattersn?

1 - First used the **example** example template from 
https:/github.com/hybrid-cloud-patterns/ to create my repository.

In our case I named the target repository **zt-service-mesh-ingress-mtls**
2 - Once the repository is created in my github account I then clone 
it down to my environment.
```shell
$ git clone https://github.com/myaccount/zt-service-mesh-ingress-mtls.git
```
3 - I then run the make_common_subtree.sh script to ensure I have the latest 
common 

```
$ ./scripts/make_common_subtree.sh 
Changing directory to project root
Removing existing common and replacing it with subtree from https://github.com/hybrid-cloud-patterns/common.git common-subtree
Committing removal of common
[main 2e17da9] Removed previous version of common to convert to subtree from https://github.com/hybrid-cloud-patterns/common.git main
 47 files changed, 4499 deletions(-)
 delete mode 100644 common/.gitignore
 delete mode 100644 common/Makefile
 delete mode 100644 common/Makefile.toplevel
 delete mode 100644 common/acm/Chart.yaml
 delete mode 100644 common/acm/templates/managed-clusters/staging.yaml
 delete mode 100644 common/acm/templates/multiclusterhub.yaml
 delete mode 100644 common/acm/templates/policies/application-policies.yaml
 delete mode 100644 common/acm/templates/policies/ocp-gitops-policy.yaml
 delete mode 100644 common/acm/values.yaml
 delete mode 120000 common/common
 delete mode 100644 common/examples/kustomize-renderer/Chart.yaml
 delete mode 100644 common/examples/kustomize-renderer/environment.yaml
 delete mode 100644 common/examples/kustomize-renderer/kustomization.yaml
 delete mode 100755 common/examples/kustomize-renderer/kustomize
 delete mode 100644 common/examples/kustomize-renderer/templates/environment.yaml
 delete mode 100644 common/examples/kustomize-renderer/values.yaml
 delete mode 100644 common/examples/values-example.yaml
 delete mode 100644 common/examples/values-secret.yaml
 delete mode 100644 common/install/.helmignore
 delete mode 100644 common/install/Chart.yaml
 delete mode 100644 common/install/crds/applications.argoproj.io.yaml
 delete mode 100644 common/install/templates/argocd/application.yaml
 delete mode 100644 common/install/templates/argocd/namespace.yaml
 delete mode 100644 common/install/templates/argocd/subscription.yaml
 delete mode 100644 common/install/values.yaml
 delete mode 100644 common/reference-output.yaml
 delete mode 100755 common/scripts/secret.sh
 delete mode 100755 common/scripts/test.sh
 delete mode 100644 common/site/.helmignore
 delete mode 100644 common/site/Chart.yaml
 delete mode 100644 common/site/templates/applications.yaml
 delete mode 100644 common/site/templates/argocd-super-role.yaml
 delete mode 100644 common/site/templates/argocd.yaml
 delete mode 100644 common/site/templates/gitops-namespace.yaml
 delete mode 100644 common/site/templates/namespaces.yaml
 delete mode 100644 common/site/templates/operatorgroup.yaml
 delete mode 100644 common/site/templates/projects.yaml
 delete mode 100644 common/site/templates/subsciptions.yaml
 delete mode 100644 common/site/templates/subscriptions.yaml
 delete mode 100644 common/site/values.yaml
 delete mode 100644 common/tests/acm-naked.expected.yaml
 delete mode 100644 common/tests/acm-normal.expected.yaml
 delete mode 100644 common/tests/install-naked.expected.yaml
 delete mode 100644 common/tests/install-normal.expected.yaml
 delete mode 100644 common/tests/site-naked.expected.yaml
 delete mode 100644 common/tests/site-normal.expected.yaml
 delete mode 100644 common/values-global.yaml
Adding (possibly replacing) subtree remote common-subtree
error: No such remote: 'common-subtree'
Updating common-subtree
remote: Enumerating objects: 1582, done.
remote: Counting objects: 100% (1582/1582), done.
remote: Compressing objects: 100% (901/901), done.
remote: Total 1582 (delta 872), reused 1280 (delta 637), pack-reused 0
Receiving objects: 100% (1582/1582), 343.41 KiB | 2.32 MiB/s, done.
Resolving deltas: 100% (872/872), done.
From https://github.com/hybrid-cloud-patterns/common
 * [new branch]      beekhof                      -> common-subtree/beekhof
 * [new branch]      jrickard-argoapp-bool-string -> common-subtree/jrickard-argoapp-bool-string
 * [new branch]      main                         -> common-subtree/main
 * [new branch]      pre-secret-removal           -> common-subtree/pre-secret-removal
 * [new branch]      stable-2.0                   -> common-subtree/stable-2.0
git fetch common-subtree main
From https://github.com/hybrid-cloud-patterns/common
 * branch            main       -> FETCH_HEAD
Added dir 'common'
Complete.  You may not push these results if you are satisfied
claudiol@fedora:zt-service-mesh-ingress-mtls (main u+318 origin/main)
```
4 - I then ensure that the changes are pushed up to our origin/main branch.
```
$ git push origin main
Enumerating objects: 1557, done.
Counting objects: 100% (1556/1556), done.
Delta compression using up to 8 threads
Compressing objects: 100% (665/665), done.
Writing objects: 100% (1524/1524), 320.35 KiB | 10.01 MiB/s, done.
Total 1524 (delta 844), reused 1493 (delta 821), pack-reused 0
remote: Resolving deltas: 100% (844/844), completed with 20 local objects.
To github.com:claudiol/zt-service-mesh-ingress-mtls.git
   ce037cf..9d1042f  main -> main
claudiol@fedora:zt-service-mesh-ingress-mtls (main u= origin/main)
$ git remote -v
common-subtree	https://github.com/hybrid-cloud-patterns/common.git (fetch)
common-subtree	https://github.com/hybrid-cloud-patterns/common.git (push)
origin	git@github.com:claudiol/zt-service-mesh-ingress-mtls.git (fetch)
origin	git@github.com:claudiol/zt-service-mesh-ingress-mtls.git (push)
```

## Setting up your git branch

Since we are starting from scratch it is suggested that you create a branch, derived from the **main** branch, to do your work.

### Create your branch
To create a branch from your **main** branch do the following:
```shell
claudiol@fedora:zt-service-mesh-ingress-mtls (main * u= origin/main)
$ git checkout -b zt-validate-pattern
Switched to a new branch 'zt-validate-pattern'
claudiol@fedora:zt-service-mesh-ingress-mtls (zt-validate-pattern *)
```

### Push your newly created branch
We can now push the new branch onto our repository:

```
$ git push origin zt-validate-pattern 
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
remote: 
remote: Create a pull request for 'zt-validate-pattern' on GitHub by visiting:
remote:      https://github.com/claudiol/zt-service-mesh-ingress-mtls/pull/new/zt-validate-pattern
remote: 
To github.com:claudiol/zt-service-mesh-ingress-mtls.git
 * [new branch]      zt-validate-pattern -> zt-validate-pattern
```

### Set up the upstream branch to track
In addition, we can set up the **upstream** branch we want to track from.  In our case we will just track the changes from our **origin/zt-validated-pattern** branch.

```
claudiol@fedora:zt-service-mesh-ingress-mtls (zt-validate-pattern *)
$ git branch -u origin/zt-validate-pattern 
branch 'zt-validate-pattern' set up to track 'origin/zt-validate-pattern'.
claudiol@fedora:zt-service-mesh-ingress-mtls (zt-validate-pattern * u= origin/zt-validate-pattern)
$ 
```

## What the original project README tells us

From the README of this project we can determine some of the prerequisites that the pattern is going to need.  In our case the README details that we need the following operators:

* ElasticSearch
* Jaeger
* Kiali
* OpenShift Service Mesh

In order for us to see where these operators are coming from we can query the package manifests in an existing cluster using the **oc** cli. We have a tool that generates the expected section for each subscription in the following shell script. You will need to have the **jq** tool installed for this script to work.

```sh
#!/bin/sh

for i in jaeger elasticsearch kiali servicemesh
do
	PACKNAME=$(oc get packagemanifests | grep -i $i | awk '{ print $1}')
	for j in $PACKNAME
	do 
          echo "Package Info for [$j]"
	  OUT=$(oc get packagemanifest/$j -o json | jq '.metadata.name, .metadata.namespace, .metadata.labels.catalog, .status.defaultChannel, .status.channels[].currentCSV')
	  let COUNT=1
	  for k in $OUT
	  do
	    case $COUNT in 
	  	1) echo "- name: $k" | tr -d '"'
	    	   ;;
	  	2) echo "  namespace: $k" | tr -d '"'
	    	   ;;
	   	3) echo "  source: $k" | tr -d '"'
		   ;;
   		4) echo "  channel: $k" | tr -d '"'
		   ;;
   		5) echo "  csv: $k" | tr -d '"'
		   ;;
	    esac
	    let COUNT++
	  done
	done
done
```

The output of this script will look something like this:

```
Package Info for [jaeger]
  - name: jaeger
    namespace: openshift-authentication
    source: community-operators
    channel: stable
    csv: jaeger-operator.v1.32.0
Package Info for [jaeger-product]
  - name: jaeger-product
    namespace: openshift-authentication
    source: redhat-operators
    channel: stable
    csv: jaeger-operator.v1.24.1
Package Info for [elasticsearch-eck-operator-certified]
  - name: elasticsearch-eck-operator-certified
    namespace: openshift-authentication
    source: certified-operators
    channel: stable
    csv: elasticsearch-eck-operator-certified.v2.1.0
Package Info for [elasticsearch-operator]
  - name: elasticsearch-operator
    namespace: openshift-authentication
    source: redhat-operators
    channel: stable
    csv: elasticsearch-operator.5.3.5-20
Package Info for [kiali-ossm]
  - name: kiali-ossm
    namespace: openshift-authentication
    source: redhat-operators
    channel: stable
    csv: kiali-operator.v1.36.7
Package Info for [kiali]
  - name: kiali
    namespace: openshift-authentication
    source: community-operators
    channel: stable
    csv: kiali-operator.v1.48.0
Package Info for [servicemeshoperator]
  - name: servicemeshoperator
    namespace: openshift-authentication
    source: redhat-operators
    channel: stable
    csv: servicemeshoperator.v2.1.1
```

> NOTE: It appears that there are several operators that can be found in both the **redhat-operators** and **community-operatos**.  We suggest that you use the operators available from our **redhat-operators** source.

### Adding required operators to values-datacenter.yaml

Now that we have the operators that we need, and there descriptions, we can add the entries to the values-datacenter.yaml file under the **subscriptions:** section.

```yaml
  #
  # Operators that support the 
  # openshift-service-mesh-ingress-mtls
  # demonstration
  #
  - name: jaeger-product
    namespace: openshift-authentication
    source: redhat-operators
    channel: stable
    csv: jaeger-operator.v1.24.1

  - name: elasticsearch-operator
    namespace: openshift-authentication
    source: redhat-operators
    channel: stable
    csv: elasticsearch-operator.5.3.5-20

  - name: kiali-ossm
    namespace: openshift-authentication
    source: redhat-operators
    channel: stable
    csv: kiali-operator.v1.36.7

  - name: servicemeshoperator
    namespace: openshift-authentication
    source: redhat-operators
    channel: stable
    csv: servicemeshoperator.v2.1.1
```

Now the validated patterns framework will deploy these operators onto the OpenShift cluster.

### Setup Control Plane, Data Plane and Deploy Demo Application

The README file also describes that there are some namespaces needed specifically for the control plane, data plane and demo application.  We can now add those namespaces into the **values-datacenter.yaml** under the **namespaces:** section.

```yaml
#
# Namespaces needed by the 
# openshift-service-mesh-ingress-mtls
# demonstration.
#
  namespaces:
  - open-cluster-management
  - openshift-authentication
  - control-plane
  - data-plane
```

## How do I configure my installed services and applications?

At this point I think we have added most of the **infrastructure** components that will support the **openshift-service-mesh-ingress-mtls** demonstration.  

It is safe to say that the Validated Patterns team prefers the use of **helm** charts to deploy kubernetes manifests to an OpenShift cluster.  For this demonstration we will do just that and create the appropriate **helm** charts for each of the components in the **openshift-service-mesh-ingress-mtls** repository.

## A closer look at the **openshift-service-mesh-ingress-mtls** repository
Now we can look at the **openshift-service-mesh-ingress-mtls** repository and see what yaml manifests will be applied.

In the README file for the **openshift-service-mesh-ingress-mtls** demonstration there were a lot of **oc apply** commands being applied to the OpenShift cluster.  The validated patterns framework deployed the **openshift=gitops** operator to promote the use of **gitops** for deployment of these components.

The **openshift-service-mesh-ingress-mtls** demonstration had four directories that contained manifests that have to be applied to the OpenShift Kubernetes cluster environment.

### apps deployment

The apps directory contained a deployment.yaml file.

```
apps
└── deployment.yaml

0 directories, 1 file
```
This file contains two deployment manifest inside the file. Each deployment manifest defined the following deplyments: 

* backend-v1
* frontend-v1

In addition the deployment.yaml file also included two service definitions:

* backend
* frontend

First we will copy the contents of this **apps** directory into our new **zt-service-mesh-ingress-mtls** repository.

```
$ cp -r apps/ ../zt-service-mesh-ingress-mtls/charts/datacenter/
```

We created a **zt-service-mesh-ingress-mtls/charts/datacenter/** directory to store the **helm** charts.

> NOTE: We organized the charts to be under the **datacenter** directory because we feel that all of these manifests will on;y be applied to a datacenter cluster. 

### How do I create a **helm** chart for my project (apps)?
The easiest way to create a **helm** chart is by running the following command:

```
$ helm create apps
```

This will create the following directory structure:

```
apps
├── charts
├── Chart.yaml
├── templates
│   ├── deployment.yaml
│   ├── _helpers.tpl
│   ├── hpa.yaml
│   ├── ingress.yaml
│   ├── NOTES.txt
│   ├── serviceaccount.yaml
│   ├── service.yaml
│   └── tests
│       └── test-connection.yaml
└── values.yaml
```
You really only need the following files that are created:

* **Chart.yaml** - Contains the chart information
* **templates/** - You will need this directory but you can basically remove all the files in it.
* **values.yaml** - You need the values.yaml file but you do not need the values that are inserted at creation.

You can run the following command to remove all the files, and directories that are not needed.

```
$ rm -rf apps/charts && rm -rf apps/templates/* && cat /dev/null > apps/values.yaml 
$ tree apps/
apps/
├── Chart.yaml
├── deployment.yaml
├── templates
└── values.yaml
```

Now we can move the **deployment.yaml** file into the **templates/** directory.  This is where **helm** processes the manifests files that will be applied to the OpenShift Kubernetes environment. 

```
$ mv apps/deployment.yaml apps/templates
```

Once we complete these steps we are ready to add an **openshift-gitops** ArgoCD application to allow ArgoCD to deploy the manifests.

### Adding an ArgoCD application to manage your git repo manifests

We can add ArgoCD applications to the **values-datacenter.yaml** file which will be created inside the ArgoCD instance by the validated patterns framework.  These will be defined under the **applications:** section.

```yaml
  applications:
  - name: apps
    project: datacenter
    path: charts/datacenter/apps
```

We will use the same steps described above for the following directories in the **openshift-service-mesh-ingress-mtls** repositories.

* **config** subdirectory

```
$ tree config/
config/
├── backend-destination-rule-mtls.yaml
├── backend-destination-rule.yaml
├── backend-peer-authentication.yaml
├── backend-virtual-service.yaml
├── frontend-destination-rule-mtls.yaml
├── frontend-destination-rule.yaml
├── frontend-peer-authentication.yaml
├── frontend-virtual-service.yaml
├── gateway-mtls.yaml
├── gateway-tls.yaml
├── gateway.yaml
└── route-mtls.yaml

0 directories, 12 files
```

* **setup-ossm** subdirectory
We copied these manifests into the **charts/datacenter/servicemesh**.

```
$ tree setup-ossm/
setup-ossm/
├── smcp.yaml
└── smmr.yaml
```

* **istio** subdirectory

```
$ tree istio/
istio/
├── backend-destination-rule.yaml
├── backend-peer-authentication.yaml
├── backend-virtual-service.yaml
├── frontend-destination-rule.yaml
├── frontend-peer-authentication.yaml
├── frontend-virtual-service.yaml
├── gateway.yaml
└── route.yaml

0 directories, 8 files
```

### ArgoCD Applications Defined
There are the ArgoCD applications defined in the **values-datacenter.yaml** file.

```
  - name: apps
    project: datacenter
    path: charts/datacenter/apps

  - name: istio
    project: datacenter
    path: charts/datacenter/istio

  - name: servicemesh
    project: datacenter
    path: charts/datacenter/servicemesh
```

## How do I install the pattern?

Make sure that you are on the **default** OpenShift project.  Then you can use **make** to install the pattern.


```
$ make install
```

There is also an option to upgrade the pattern by executing a **make upgrade**.
