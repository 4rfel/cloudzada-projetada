#!/bin/bash

terraform init
terrafor destroy --auto-approve
terrafor apply --auto-approve