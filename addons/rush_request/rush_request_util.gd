class_name RushRequestUtil


func get_rush_response_from_http_response(http_response: Array) -> RushRequestResponse:
	var rush_response: RushRequestResponse = RushRequestResponse.new()
	rush_response.http_result = http_response[0]
	rush_response.status_code = http_response[1]
	rush_response.headers = headers_to_dict(http_response[2])
	rush_response.body = http_response[3].get_string_from_utf8()
	return rush_response


func get_error_rush_response(http_result: HTTPRequest.Result):
	var rush_response: RushRequestResponse = RushRequestResponse.new()
	rush_response.http_result = http_result
	rush_response.status_code = 0
	rush_response.headers = {}
	rush_response.body = ""
	return rush_response


func get_full_url(url: String, base_url: String, config: Dictionary = {}):
	var new_url := ""
	
	if is_full_url(url):
		new_url = url
	else:
		new_url = remove_trailing_slash(base_url) + "/" + remove_leading_slash(url)
	
	if "params" in config and config["params"] is Dictionary:
		new_url = merge_url_parameters(new_url, config["params"])
	
	return new_url


func get_full_headers(headers: Dictionary, base_headers: Dictionary) -> PackedStringArray:
	var final_headers = merge_dicts(headers, base_headers)
	return dict_to_headers(final_headers)


func dict_to_headers(headers_dict: Dictionary) -> PackedStringArray:
	var headers_array = PackedStringArray()
	for key in headers_dict.keys():
		headers_array.push_back("%s: %s" % [key, headers_dict[key]])
	return headers_array


func headers_to_dict(headers_array: PackedStringArray) -> Dictionary:
	var headers_dict = {}
	for header in headers_array:
		var parts = header.split(":")
		if parts.size() >= 2:
			var key = parts[0].strip_edges()
			var value = parts[1].strip_edges()
			headers_dict[key] = value
	return headers_dict


func is_full_url(url: String) -> bool:
	var regex = RegEx.new()
	regex.compile("^(http|https):\\/\\/[\\w-]+(\\.[\\w-]+)+([\\w.,@?^=%&:/~+#-]*[\\w@?^=%&/~+#-])?$")
	return regex.search(url) != null


func remove_trailing_slash(path: String) -> String:
	if path.ends_with("/"):
		return path.left(path.length() - 1)
	return path


func remove_leading_slash(path: String) -> String:
	if path.begins_with("/"):
		return path.right(path.length() - 1)
	return path


func merge_dicts(dict1: Dictionary, dict2: Dictionary) -> Dictionary:
	var merged_dict = dict1.duplicate() # Start with a copy of the first dictionary
	for key in dict2.keys():
		merged_dict[key] = dict2[key]   # Overwrite or add keys from the second dictionary
	return merged_dict


func merge_url_parameters(url: String, params: Dictionary) -> String:
	# Split the URL into base and query parts
	var parts = url.split("?", true)
	var base_url = parts[0]
	var current_params = {}

	# If there are already parameters in the URL, extract them
	if parts.size() > 1:
		var query_parts = parts[1].split("&")
		for query in query_parts:
			var key_value = query.split("=", true)
			if key_value.size() == 2:
				current_params[key_value[0]] = key_value[1]

	# Merge the provided params into the current params
	for key in params:
		current_params[key] = params[key]

	# Construct the new URL
	var param_strings = []
	for key in current_params:
		param_strings.append("%s=%s" % [key, current_params[key].uri_encode()])
	
	var new_query = "&".join(param_strings)
	var final_url = "%s?%s" % [base_url, new_query]
	return final_url
