# apex-graphql-starter

Starter package that provides a "Hello World" GraphQL endpoint using AWS Lambda and API Gateway.

Notable features:

* Endpoint is CORS-enabled
* ES6 (via Webpack/Babel)
* AVA.js

# Install

1. Install Apex and Terraform
1. Read the [API Gateway / AWS Lambda guide](http://docs.aws.amazon.com/apigateway/latest/developerguide/getting-started.html)
1. Setup your [AWS Credentials](http://apex.run/#aws-credentials), and ensure "role" in ./project.json is set to your Lambda function ARN.
1. Set the `gateway_lambda_role` variable in `infrastructure/dev/terraform.tfvars` to the ARN of a role that allows API gateway to invoke Lambda.

Install NPM dependencies:

```
$ npm install
```

Deploy the graphql function

```
$ apex deploy --env dev
```

Deploy infrastructure

```
$ apex infra --env dev get
$ apex infra --env dev plan
$ apex infra --env dev apply
```

Note: until Terraform 0.8 is released, you'll need to call `apply` twice - the first will fail with errors.

The apply command will emit the REST API ID which you can use to test your new endpoint:

```
$ API_ID=pi04ylmzt5 AWS_REGION=us-west-2 scripts/hello-graphql.sh

Testing POST request...
{"data":{"hello":"world"}}

Testing GET request...
{"data":{"hello":"world"}}

Done
```

You can also invoke graphql directly in AWS Lambda:

```
$ apex invoke --env dev graphql <<< '{"method": "POST", "body": {"query": "{ hello }"}}'
{"data":{"hello":"world"}}
```
