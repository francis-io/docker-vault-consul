storage "consul" {
  address = "consul:8500"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

#log_level = debug  #Case is different in consul

ui = true