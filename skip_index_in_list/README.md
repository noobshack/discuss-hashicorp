["Terraform 0.12 - Skip specific indexes in a list passed into a resource"](https://discuss.hashicorp.com/t/3471)

# Overview
A variable containing a list of subnet ID's is defined. `list(string)` - `us-east-1[a-d]`. 

We want to create Auto-scaling groups in these environments without failing. 

## Problem
Certain subnets do not support specific machine types - in this case `c5.2xlarge`.

## Proposed solution
This is more of a trial-by-fire approach if you don't have a whitelist defined beforehand.

Right now the count is being used to create the resource per AZ, if using `0.12.6` I highly recommend using the `for_each` expression for creating multiple resources.

The best long term solution that I can think of that scales to a degree:
- Create a map of ASG machine types and regions where supported (ugh)
- When that machine type is used, we will perform a lookup to see which regions are supported in the list defined above
- If the region is supported, create the ASG. Otherwise, remove it from the list beforehand.

for each AZ in SUBNET_LIST
    if AZ is in WHITELIST
        create
    else
        count = 0

```
``` 

## Learnings
