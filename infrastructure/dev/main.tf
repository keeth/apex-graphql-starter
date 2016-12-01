# injected by apex
variable "aws_region" {}
variable "apex_environment" {}
variable "apex_function_role" {}
variable "apex_function_graphql" {}

# must be provided
variable "gateway_lambda_role" {}

resource "aws_api_gateway_rest_api" "graphql" {
  name = "graphql"
  description = "A GraphQL endpoint"
}

resource "aws_api_gateway_deployment" "graphql" {
  rest_api_id = "${aws_api_gateway_rest_api.graphql.id}"
  stage_name = "${var.apex_environment}"
  # FIXME waiting for TF 0.8
  # depends_on = ["module.graphql"]
}

module "graphql" {
  source = "../modules/resource"
  rest_api_id = "${aws_api_gateway_rest_api.graphql.id}"
  root_resource_id = "${aws_api_gateway_rest_api.graphql.root_resource_id}"
  path = "graphql"
  gateway_lambda_role = "${var.gateway_lambda_role}"
  aws_region = "${var.aws_region}"
  lambda_function = "${var.apex_function_graphql}"
}

output "rest_api_id" {
  value = "${aws_api_gateway_rest_api.graphql.id}"
}
