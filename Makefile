#
# step 1: create vpc and role
#   https://docs.openshift.com/rosa/rosa_install_access_delete_clusters/rosa-shared-vpc-config.html#rosa-sharing-vpc-creation-and-sharing_rosa-shared-vpc-config
#
vpc-setup:
	cd vpc-owner-setup/test && \
	terraform init && \
	terraform apply \
		-var-file=main.tfvars

vpc-setup-destroy:
	cd vpc-owner-setup/test && \
	terraform init && \
	terraform apply \
		-var-file=main.tfvars \
		-destroy

#
# step 2: perform prereq cluste creation steps
#   https://docs.openshift.com/rosa/rosa_install_access_delete_clusters/rosa-shared-vpc-config.html#rosa-sharing-vpc-dns-and-roles_rosa-shared-vpc-config
#
setup:
	cd cluster-setup/test && \
	terraform init && \
	terraform apply \
		-var-file=main.tfvars

setup-destroy:
	cd cluster-setup/test && \
	terraform init && \
	terraform apply \
		-var-file=main.tfvars \
		-destroy

#
# step 3: update vpc role and create route53 domain
#   https://docs.openshift.com/rosa/rosa_install_access_delete_clusters/rosa-shared-vpc-config.html#rosa-sharing-vpc-hosted-zones_rosa-shared-vpc-config
#
VPC_ID ?= vpc-0d085fdb749ac91a5
VPC_REGION ?= us-east-1
VPC_PROFILE ?= mobb-workshop
DOMAIN ?=
CLUSTER_NAME ?= dscott-test
CLUSTER_CREATOR_ACCOUNT_ID ?= 660250927410
HOSTED_ZONE_ID ?=
vpc-update:
	export CLUSTER_CREATOR_ACCOUNT_ID=$(CLUSTER_CREATOR_ACCOUNT_ID) && \
	export CLUSTER_NAME=$(CLUSTER_NAME) && \
	export DOMAIN=$(DOMAIN) && \
	export VPC_ID=$(VPC_ID) && \
	export VPC_REGION=$(VPC_REGION) && \
	vpc-owner-update/update.sh

vpc-update-destroy:
	aws route53 delete-hosted-zone \
		--id $(HOSTED_ZONE_ID) \
		--profile $(VPC_PROFILE)

#
# step 4: create cluster
#   https://docs.openshift.com/rosa/rosa_install_access_delete_clusters/rosa-shared-vpc-config.html#rosa-sharing-vpc-cluster-creation_rosa-shared-vpc-config
#
cluster:
	cd cluster-create/test && \
	terraform init && \
	terraform apply \
		-var-file=main.tfvars

cluster-destroy:
	cd cluster-create/test && \
	terraform init && \
	terraform apply \
		-var-file=main.tfvars \
		-destroy
