# This constitutes the output interface for this root module. It defines the values that will
# be returned to this (calling) module's state-file after the network resources have been created.
# Thus, the subnet IDs for the dev and test subnets will be available in root module's state-file 
# after the network resources have been created.
output "dev_subnet_id" {
  value = module.net_dev.subnet_id # Each attribute is defined in the child module. 
}                                  # We reference the child's attribute here so that  
# it will/can be returned to the root module's state-file and/or printed in the CLI.

output "test_subnet_id" {
  value = module.net_test.subnet_id
}
