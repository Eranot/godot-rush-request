extends Node


func create_client(config: Dictionary = {}) -> RushRequestClient:
	var http_request = HTTPRequest.new()
	
	if "timeout" in config and config["timeout"] is float:
		http_request.timeout = config["timeout"]
	
	add_child(http_request)
	
	var client: RushRequestClient = RushRequestClient.new(http_request)
	client.set_base_url(config["base_url"] if "base_url" in config else "http://localhost")
	client.set_headers(config["headers"] if "headers" in config else {})
	
	return client
