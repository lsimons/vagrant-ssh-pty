#!/bin/bash

set -e

echo "Creating VM"
vagrant up

echo "---------------------------------------------------------------"
echo "Showing all the extra cruft that you normally get with pty=true"
echo "---------------------------------------------------------------"
vagrant provision

echo "---------------------------------------------------------------"
echo "Showing how the patch suppresses all the extra output"
echo "---------------------------------------------------------------"
VAGRANT_ENABLE_PATCH=1 vagrant provision

