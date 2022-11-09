#!/bin/bash

mv auth.conf auth.conf.old
rm -rf nsc nscc nscd

# setup the operator
./local_nsc add operator myoperator 
./local_nsc env -o myoperator

# create a system user for monitoring
./local_nsc add account SYS
./local_nsc add user SYS
echo "created SYS user"

# create an account and user
./local_nsc add account myaccount
./local_nsc edit account myaccount --js-disk-storage 10000
./local_nsc add export --name foo --account myaccount --service --subject foo
./local_nsc add user    myuser

MY_ACCT=$(./local_nsc describe account myaccount --field sub | tr -d \")

./local_nsc add account myaccount2
./local_nsc edit account myaccount2 --js-disk-storage 10000 
./local_nsc add user myuser
./local_nsc add import --service --name foo --src-account myaccount --remote-subject foo

# Generate our auth file
./local_nsc generate config --mem-resolver --config-file auth.conf

SYS_ACCT=$(./local_nsc describe account SYS --field sub | tr -d \")
echo "system_account: $SYS_ACCT" >> auth.conf
