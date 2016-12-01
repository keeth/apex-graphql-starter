resource "aws_api_gateway_method" "options" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "OPTIONS"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "options" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.options.http_method}"
  type = "MOCK"
  request_templates = {
    "application/json" = <<EOT
{"statusCode": 200}
EOT
  }
}

resource "aws_api_gateway_integration_response" "options_200" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.options.http_method}"
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'"
    "method.response.header.Access-Control-Allow-Methods" = "'POST,OPTIONS'"
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  response_templates = {
    "application/json" = <<EOT
{}
EOT
  }
}

resource "aws_api_gateway_method_response" "options_200" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.options.http_method}"
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  }
  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true
    "method.response.header.Access-Control-Allow-Methods" = true
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
