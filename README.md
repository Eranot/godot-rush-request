# Godot Rush Request 

Rush Request is the easiest way of making HTTP requests with JSON in Godot 4. Inspired by the JS library Axios, it creates requests in a Promise-like way.

## Installing

You can install it via the Asset Library or downloading a copy from GitHub. 

## Usage

Rush Request adds automatically an `Autoload` called `RushRequest`. With it you can create a client and use the basic methods to make HTTPS requests.

A simple usage would be like this:

```gdscript
extends Node


func _ready():
	var client: RushRequestClient = RushRequest.create_client({
        "timeout": 10,
        "base_url": "https://run.mocky.io/v3/",
        "headers": {
            "Content-Type": "application/json"
        }
    })
	
    # Makes a GET request
	var response: RushRequestResponse = await client.GET("/587c3de4-d119-4166-bd3a-a5272370a5fd")
	
    if response.is_successful():
        # Returns a Dictionary converted from JSON, if the response Content-Type is set to "application/json"
        print("Request was successful!")
        print(response.get_parsed_body())
    else:
        print("Request failed!")
        print(response.get_http_result_description())

```

## API

### `RushRequest`

The base class that will be added as an `Autoload`, so it can be used anywhere in the code.

#### Methods

- `create_client(config: Dictionary = {}) -> RushRequestClient`  
Returns a `RushRequestClient`, that will be used to make the requests. The parameter `config` is optional, but can be used to configure the client. The configurations are:
    - `timeout`: A float representing how much seconds the requests are going to wait for a response before returning a timeout error.
    - `base_url`: A URL that will be prepended to `url` unless `url` is absolute.
    - `headers`: Custom `Dictionary` of headers that will be passed on every request made with the client.


### `RushRequestClient`

The configured object that will be used to perform the HTTP requests.

#### Methods

- `GET(url: String, config: Dictionary = {}) -> RushRequestResponse`  
Makes a HTTP GET request to `url`. The `config` parameter is optional, but can be used to modify the request. The configurations are:
    - `headers`: Custom Dictionary of headers. Will be merge with the `RushRequestClient` headers.
    - `params`: Custom Dictionary of URL parameters.
  
- `HEAD(url: String, config: Dictionary = {}) -> RushRequestResponse`  
Makes a HTTP HEAD request to `url`. The `config` parameter is optional, but can be used to modify the request. The configurations are:
    - `headers`: Custom Dictionary of headers. Will be merge with the `RushRequestClient` headers.
    - `params`: Custom Dictionary of URL parameters.

- `POST(url: String, config: Dictionary = {}) -> RushRequestResponse`  
Makes a HTTP POST request to `url`. The `config` parameter is optional, but can be used to modify the request. The configurations are:
    - `headers`: Custom Dictionary of headers. Will be merge with the `RushRequestClient` headers.
    - `params`: Custom Dictionary of URL parameters.
    - `body`: Custom Dictionary that will be transformed to `JSON` and sent as the request body.

- `PUT(url: String, config: Dictionary = {}) -> RushRequestResponse`  
Makes a HTTP PUT request to `url`. The `config` parameter is optional, but can be used to modify the request. The configurations are:
    - `headers`: Custom Dictionary of headers. Will be merge with the `RushRequestClient` headers.
    - `params`: Custom Dictionary of URL parameters.
    - `body`: Custom Dictionary that will be transformed to `JSON` and sent as the request body.

- `PATCH(url: String, config: Dictionary = {}) -> RushRequestResponse`  
Makes a HTTP PATCH request to `url`. The `config` parameter is optional, but can be used to modify the request. The configurations are:
    - `headers`: Custom Dictionary of headers. Will be merge with the `RushRequestClient` headers.
    - `params`: Custom Dictionary of URL parameters.
    - `body`: Custom Dictionary that will be transformed to `JSON` and sent as the request body.

- `DELETE(url: String, config: Dictionary = {}) -> RushRequestResponse`  
Makes a HTTP DELETE request to `url`. The `config` parameter is optional, but can be used to modify the request. The configurations are:
    - `headers`: Custom Dictionary of headers. Will be merge with the `RushRequestClient` headers.
    - `params`: Custom Dictionary of URL parameters.

- `OPTIONS(url: String, config: Dictionary = {}) -> RushRequestResponse`  
Makes a HTTP OPTIONS request to `url`. The `config` parameter is optional, but can be used to modify the request. The configurations are:
    - `headers`: Custom Dictionary of headers. Will be merge with the `RushRequestClient` headers.
    - `params`: Custom Dictionary of URL parameters.

- `destroy()`  
Destroys the client, freeing up the internal `HTTPRequest` object that is used to make the requests.

### `RushRequestResponse`

Every HTTP request will return a `RushRequestResponse`.

### Attributes

- `body`: A `String` that represents the whole body that was returned from the request.
- `headers`: A `Dictionary` with all the response headers.
- `status_code`: The HTTP status code.
- `http_result`: A `HTTPRequest.Result` returned from the original `HTTPRequest` object.


#### Methods

- `is_successful() -> bool`: Returns `true` if the request was successful.
- `get_parsed_body(content_type: String = "")`: Parses the response body to a `Dictionary` or an `Array`. The `content_type` parameter is optional, and represents the type of the response, for example, "application/json" or "application/xml". If the parameter is not present, the response headers are checked. Only JSON parsing is supported for now.
- `get_http_result_description() -> String`: Returns a textual description of the `http_result` attribute.
