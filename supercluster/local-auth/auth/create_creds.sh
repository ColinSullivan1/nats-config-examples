#!/bin/sh

export NKEYS_PATH=`pwd`/nkeys
export NSC_HOME=`pwd`/nsc

# setup the operator
nsc add operator synadia

# create System User
nsc add account SYS
nsc add user SYS

# create a generic user
nsc add account myaccount
nsc add user    myuser

