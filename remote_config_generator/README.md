# remote_config_generator
["Alternative way for variables in S3 backend"](https://discuss.hashicorp.com/t/alternative-way-for-variables-in-s3-backend/3587)

It appears the user wants to interpolate values inside the terraform block.

Looks like they already have a clear path forward, but need a little guidance:
- Understanding that interpolation cannot be used within terraform block.
- Terragrunt was mentioned to solve this problem.

## Technical Overview 
- Terraform Version: ?
- Remote backend: AWS S3
- Provider: AWS

## Understanding of the Problem
*What logic needs to happen to declare the resource in such a way?*

Since interpolation is not supported within the Terraform block, we'll need another way to generate this file.
["Terraform Block Syntax"](https://www.terraform.io/docs/configuration/terraform.html#terraform-block-syntax)

## Solution Planning 
*How can we get to get to the declared state?*

As the user had suggested a few things:
- terragrunt (clear winner IMO, generating .tf files and HCL is what this software was designed to do)
- python (vague, likely custom written - or not maintained as well as tg)
- workspaces (works with an existing statefile, does not help generate one)

Depends on the use case really. Is this a one time thing, if so a quick Python script to generate the terraform blocks is achievable.

If Terraform is a core part of your teams workflow and you are gearing to use Terraform for the majority of your infrasturcture, I would consider weighing the opinon to
add the additional complexity to your terraform setup using Terragrunt.

## Proven Results 
Process works and can be replicated.
- terraform plan
- terraform apply 

## Response to User
Hey @venu1428,

As you've stated it is not possible to use interpolated values in the Terraform block itself.

If you are looking for a solution to generate a `main.tf` pre-runtime of `terraform` then two of the options you mentioned should be able to do that.

- terragrunt
- custom file generator script (this could be Python, just a is aware of HCL syntax and templatizes that in a way)

It depends on your use case. If you only planning on creating these files with generated Terraform blocks in bulk once or twice, I would personally write a bash or Python script to achieve this.

Otherwise, I would configure it to be compatible with Terragrunt as it seems to do precisely what you are looking for. A tutorial covering [dynamically creating an S3 remote backend using variables]( https://blog.gruntwork.io/terragrunt-how-to-keep-your-terraform-code-dry-and-maintainable-f61ae06959d8#68b9 ) can be found on Gruntwork's Medium blog.

Additionally, the official `terragrunt` README has a relevant snippet on to generate an remote backend block on S3.
https://github.com/gruntwork-io/terragrunt#keep-your-remote-state-configuration-dry
