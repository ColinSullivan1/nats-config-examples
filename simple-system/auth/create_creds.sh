#!/bin/sh

# generate the files here
export NKEYS_PATH=`pwd`/nkeys
export NSC_HOME=`pwd`/nsc

mv auth.conf auth.conf.old

mkdir -p $NKEYS_PATH
mkdir -p $NSC_HOME

# setup the operator
nsc add operator myoperator

# create a system user for monitoring
nsc add account SYS
nsc add user SYS
echo "created SYS user"

# create an account and user
nsc add account myaccount
nsc edit account myaccount --js-disk-storage 10000
nsc add export --name foo --account myaccount --service --subject foo
nsc add user    myuser

MY_ACCT=$(nsc describe account myaccount --field sub | tr -d \")

nsc add account myaccount2
nsc edit account myaccount2 --js-disk-storage 10000
nsc add user myuser
nsc add import --service --name foo --src-account myaccount --remote-subject foo

# Generate our auth file
nsc generate config --mem-resolver --config-file auth.conf

SYS_ACCT=$(nsc describe account SYS --field sub | tr -d \")
echo "system_account: $SYS_ACCT" >> auth.conf
