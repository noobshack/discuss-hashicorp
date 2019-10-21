["Multiple counts in a resource"](https://discuss.hashicorp.com/t/multiple-counts-in-a-resource/3422)

To me the best way forward would be using the `for_each` expression. Due to `count` being used to enable/disable the DNS record.

I'm a little confused why the subdomain in `var.subdomain_name` has the TLD .com in it as well as it being defined properly at the domain level which I presume should be `var.records`.

The end result should be the following, given the domain `noobshack.com` and subdomains `terraform`, `example` and `third`:
- terraform.example.com
- example.example.com
- third.example.com

# Solution
If using Terraform `0.12.6`+, I would recommend using a [`for_each`](https://www.terraform.io/docs/configuration/resources.html#for_each-multiple-resource-instances-defined-by-a-map-or-set-of-strings) expression to iterate over a list. However, since `count` and `for_each` are mutually exclusive - we will not be able to have both expressions in place at once.

I don't have any domains registered on AWS, so I had to test this approach with Cloudflare.

```
variable "records" {
  default = ["terraform", "example", "third"]
  type = list
}

resource "cloudflare_record" "dns" {
  for_each = toset(var.records)

  zone_id = var.cloudflare_zone_id
  name    = "subdomain"
  value   = "${each.value}"
  type    = "CNAME"
  ttl     = 3600
}
```

On second glance, the [AWS Route 53 Terraform Resource](https://www.terraform.io/docs/providers/aws/r/route53_record.html#records) the `records` argument takes a list. So you could convert your comma seperated string variable `records` to a list and continue to use the resource as you are.

# Learnings
```
The "count" and "for_each" meta-arguments are mutually-exclusive, only one
should be used to be explicit about the number of resources to be created.
```
