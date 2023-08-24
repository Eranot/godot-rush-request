class_name RushRequestResponse

var body: String
var headers: Dictionary
var status_code: int
var http_result: HTTPRequest.Result

func is_successful() -> bool:
	return status_code >= 200 and status_code < 300


func get_parsed_body(content_type: String = ""):
	if content_type == "":
		content_type = headers.get("Content-Type", "").to_lower()

	# Check for JSON content type
	if "application/json" in content_type:
		return JSON.parse_string(body)
		
	return null


func get_http_result_description() -> String:
	match http_result:
		HTTPRequest.Result.RESULT_SUCCESS:
			return "Request successful."
		HTTPRequest.Result.RESULT_CHUNKED_BODY_SIZE_MISMATCH:
			return "Chunked body size mismatch."
		HTTPRequest.Result.RESULT_CANT_CONNECT:
			return "Request failed while connecting."
		HTTPRequest.Result.RESULT_CANT_RESOLVE:
			return "Request failed while resolving."
		HTTPRequest.Result.RESULT_CONNECTION_ERROR:
			return "Request failed due to connection (read/write) error."
		HTTPRequest.Result.RESULT_TLS_HANDSHAKE_ERROR:
			return "Request failed on TLS handshake."
		HTTPRequest.Result.RESULT_NO_RESPONSE:
			return "Request does not have a response (yet)."
		HTTPRequest.Result.RESULT_BODY_SIZE_LIMIT_EXCEEDED:
			return "Request exceeded its maximum size limit, see body_size_limit."
		HTTPRequest.Result.RESULT_BODY_DECOMPRESS_FAILED:
			return "Body decompress failed."
		HTTPRequest.Result.RESULT_REQUEST_FAILED:
			return "Request failed."
		HTTPRequest.Result.RESULT_DOWNLOAD_FILE_CANT_OPEN:
			return "HTTPRequest couldn't open the download file."
		HTTPRequest.Result.RESULT_DOWNLOAD_FILE_WRITE_ERROR:
			return "HTTPRequest couldn't write to the download file."
		HTTPRequest.Result.RESULT_REDIRECT_LIMIT_REACHED:
			return "Request reached its maximum redirect limit."
		HTTPRequest.Result.RESULT_TIMEOUT:
			return "Request failed due to a timeout."
		_:
			return "Unknown error."


func _to_string():
	return JSON.stringify({
		"status_code": status_code,
		"headers": headers,
		"body": body,
		"http_result": get_http_result_description()
	})
