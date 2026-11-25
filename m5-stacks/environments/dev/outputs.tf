# The specified output will be given to the lowest-level module, so that those child 
# modules knows what values are needed by the environment. 

output "subnet_id" {
  value = module.app_stack.subnet_id
}
