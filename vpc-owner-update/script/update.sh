#!/usr/bin/env sh

set -e

# ensure environment is setup
: ${DOMAIN?missing DOMAIN environment variable}
: ${CLUSTER_NAME?missing CLUSTER_NAME environment variable}
: ${CLUSTER_CREATOR_ACCOUNT_ID?missing CLUSTER_CREATOR_ACCOUNT_ID environment variable}
: ${VPC_ID?missing VPC_ID environment variable}
: ${VPC_REGION?missing VPC_REGION environment variable}
: ${VPC_PROFILE?missing VPC_PROFILE environment variable}

# script directory
SCRIPT_DIR=$(dirname "$0")

# define iam role name
SHARED_VPC_IAM_ROLE="${CLUSTER_NAME}-shared-vpc"

# ensure the role exists
CURRENT_TRUST_POLICY=$(aws iam get-role --role-name "$SHARED_VPC_IAM_ROLE" --query "Role.AssumeRolePolicyDocument" --profile "${VPC_PROFILE}")
if [ -z "$CURRENT_TRUST_POLICY" ]; then
  echo "IAM role $SHARED_VPC_IAM_ROLE does not exist."
  exit 1
fi

# create the new policy
TRUST_POLICY=$(cat $SCRIPT_DIR/shared-vpc-trust-policy.json)
UPDATED_TRUST_POLICY=${TRUST_POLICY//\$CLUSTER_CREATOR_ACCOUNT_ID/$CLUSTER_CREATOR_ACCOUNT_ID}
UPDATED_TRUST_POLICY=${UPDATED_TRUST_POLICY//\$CLUSTER_NAME/$CLUSTER_NAME}

# update the iam role with the new trust policy
aws iam update-assume-role-policy \
    --role-name "$SHARED_VPC_IAM_ROLE" \
    --policy-document "$UPDATED_TRUST_POLICY" \
    --profile ${VPC_PROFILE}

# list the route53 hosted zones by domain name
HOSTED_ZONE_QUERY=`aws route53 list-hosted-zones \
    --query "HostedZones[?Name == '$CLUSTER_NAME.$DOMAIN.'].Id" \
    --profile ${VPC_PROFILE} | jq -r '.[0]'`

if [ "$HOSTED_ZONE_QUERY" != "null" ]; then
    HOSTED_ZONE_ID=$(echo $HOSTED_ZONE_QUERY | awk -F'/' '{print $NF}')
    echo $HOSTED_ZONE_ID
    exit 0
fi

# create the hosted zone
HOSTED_ZONE_ID=`aws route53 create-hosted-zone \
  --name "$CLUSTER_NAME.$DOMAIN" \
  --vpc "VPCRegion=${VPC_REGION},VPCId=${VPC_ID}" \
  --caller-reference $(date +%s) \
  --profile ${VPC_PROFILE} \
  --output json | jq -r '.HostedZone.Id' | awk -F'/' '{print $NF}'`

echo $HOSTED_ZONE_ID