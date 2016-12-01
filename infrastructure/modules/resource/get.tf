resource "aws_api_gateway_method" "get" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.get.http_method}"
  type = "AWS"
  integration_http_method = "POST"
  credentials = "${var.gateway_lambda_role}"
  uri = "arn:aws:apigateway:${var.aws_region}:lambda:path/2015-03-31/functions/${var.lambda_function}/invocations"
  request_templates = {
    "application/json" = <<EOT
{
  "headers": {
    #foreach($header in $input.params().header.keySet())
    "$header": "$util.escapeJavaScript($input.params().header.get($header))" #if($foreach.hasNext),#end

    #end
  },
  "method": "$context.httpMethod",
  "params": {
    #foreach($param in $input.params().path.keySet())
    "$param": "$util.escapeJavaScript($input.params().path.get($param))" #if($foreach.hasNext),#end

    #end
  },
  "query": {
    #foreach($queryParam in $input.params().querystring.keySet())
    "$queryParam": "$util.escapeJavaScript($input.params().querystring.get($queryParam))" #if($foreach.hasNext),#end

    #end
  }
}
EOT
  }
}

resource "aws_api_gateway_integration_response" "get_200" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.get.http_method}"
  status_code = "200"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
}

resource "aws_api_gateway_method_response" "get_200" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${aws_api_gateway_resource.resource.id}"
  http_method = "${aws_api_gateway_method.get.http_method}"
  status_code = "200"
  response_models = {
    "application/json" = "Empty"
  },
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = true
  }
}
