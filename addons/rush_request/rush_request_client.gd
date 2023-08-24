class_name RushRequestClient

var http_request: HTTPRequest
var util: RushRequestUtil
var base_url: String = "http://localhost"
var headers: Dictionary = {}
var active: bool = true


func _init(http_request: HTTPRequest):
	self.http_request = http_request
	self.util = RushRequestUtil.new()


func set_base_url(base_url: String):
	self.base_url = base_url


func set_headers(headers: Dictionary):
	self.headers = headers


func destroy():
	active = false
	http_request.queue_free()


func GET(url: String, config: Dictionary = {}) -> RushRequestResponse:
	if not active:
		printerr("Rush client not active")
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var full_url: String = util.get_full_url(url, base_url, config)
	var full_headers: PackedStringArray = util.get_full_headers(
		config["headers"] if "headers" in config else {}, 
		headers
	)
	
	var error = http_request.request(full_url, full_headers, HTTPClient.METHOD_GET)
	if error != OK:
		printerr("Error making the request: ", error_string(error))
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var http_response = await http_request.request_completed
	return util.get_rush_response_from_http_response(http_response)


func HEAD(url: String, config: Dictionary = {}) -> RushRequestResponse:
	if not active:
		printerr("Rush client not active")
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var full_url: String = util.get_full_url(url, base_url, config)
	var full_headers: PackedStringArray = util.get_full_headers(
		config["headers"] if "headers" in config else {}, 
		headers
	)
	
	var error = http_request.request(full_url, full_headers, HTTPClient.METHOD_HEAD)
	if error != OK:
		printerr("Error making the request: ", error_string(error))
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var http_response = await http_request.request_completed
	return util.get_rush_response_from_http_response(http_response)


func POST(url: String, config: Dictionary = {}) -> RushRequestResponse:
	if not active:
		printerr("Rush client not active")
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var full_url: String = util.get_full_url(url, base_url, config)
	var full_headers: PackedStringArray = util.get_full_headers(
		config["headers"] if "headers" in config else {}, 
		headers
	)
	
	var request_body = JSON.stringify(config["body"] if "body" in config else null)
	
	var error = http_request.request(full_url, full_headers, HTTPClient.METHOD_POST, request_body)
	if error != OK:
		printerr("Error making the request: ", error_string(error))
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var http_response = await http_request.request_completed
	return util.get_rush_response_from_http_response(http_response)


func PUT(url: String, config: Dictionary = {}) -> RushRequestResponse:
	if not active:
		printerr("Rush client not active")
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var full_url: String = util.get_full_url(url, base_url, config)
	var full_headers: PackedStringArray = util.get_full_headers(
		config["headers"] if "headers" in config else {}, 
		headers
	)
	
	var request_body = JSON.stringify(config["body"] if "body" in config else null)
	
	var error = http_request.request(full_url, full_headers, HTTPClient.METHOD_PUT, request_body)
	if error != OK:
		printerr("Error making the request: ", error_string(error))
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var http_response = await http_request.request_completed
	return util.get_rush_response_from_http_response(http_response)


func PATCH(url: String, config: Dictionary = {}) -> RushRequestResponse:
	if not active:
		printerr("Rush client not active")
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var full_url: String = util.get_full_url(url, base_url, config)
	var full_headers: PackedStringArray = util.get_full_headers(
		config["headers"] if "headers" in config else {}, 
		headers
	)
	
	var request_body = JSON.stringify(config["body"] if "body" in config else null)
	
	var error = http_request.request(full_url, full_headers, HTTPClient.METHOD_PATCH, request_body)
	if error != OK:
		printerr("Error making the request: ", error_string(error))
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var http_response = await http_request.request_completed
	return util.get_rush_response_from_http_response(http_response)


func DELETE(url: String, config: Dictionary = {}) -> RushRequestResponse:
	if not active:
		printerr("Rush client not active")
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var full_url: String = util.get_full_url(url, base_url, config)
	var full_headers: PackedStringArray = util.get_full_headers(
		config["headers"] if "headers" in config else {}, 
		headers
	)
	
	var error = http_request.request(full_url, full_headers, HTTPClient.METHOD_DELETE)
	if error != OK:
		printerr("Error making the request: ", error_string(error))
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var http_response = await http_request.request_completed
	return util.get_rush_response_from_http_response(http_response)


func OPTIONS(url: String, config: Dictionary = {}) -> RushRequestResponse:
	if not active:
		printerr("Rush client not active")
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var full_url: String = util.get_full_url(url, base_url, config)
	var full_headers: PackedStringArray = util.get_full_headers(
		config["headers"] if "headers" in config else {}, 
		headers
	)
	
	var error = http_request.request(full_url, full_headers, HTTPClient.METHOD_OPTIONS)
	if error != OK:
		printerr("Error making the request: ", error_string(error))
		return util.get_error_rush_response(HTTPRequest.RESULT_REQUEST_FAILED)
	
	var http_response = await http_request.request_completed
	return util.get_rush_response_from_http_response(http_response)
