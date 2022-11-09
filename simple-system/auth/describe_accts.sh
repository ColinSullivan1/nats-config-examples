#!/bin/sh

./local_nsc list accounts
read -p "Press enter to continue"
./local_nsc describe account myaccount
read -p "Press enter to continue"
./local_nsc describe account myaccount2
