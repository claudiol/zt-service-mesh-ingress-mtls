BOOTSTRAP=1
PATTERN=example
COMPONENT=datacenter
SECRET_NAME="argocd-env"

.PHONY: default
default: show

%:
	make -f common/Makefile $*

install: 
	oc project default
	make -f common/Makefile deploy
	helm list
