["How input variables force instance replacement?"](https://discuss.hashicorp.com/t/how-input-variables-force-instance-replacement/2820)
49

Can't say using a `local-exec` to self-taint a terraform resource is the greatest idea...

# Solution
I don't know if it's possible to self-taint a resource via HCL. I tried using the `local-exec` provisioner to run `terraform taint null_resource.destroy_me -lock=false` and quickly realized state is going to be a problem.


Is there a way you can reference the output of the ansible-playbook in terraform? If so, then as you've mentioned use a resource that forces recreation with a ternary operator.

```
 
