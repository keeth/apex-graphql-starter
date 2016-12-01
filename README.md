# apex-graphql-starter

[Apex](https://apex.run) starter package that provides a "Hello, World!" [GraphQL](http://graphql.org/) endpoint using [Node.js](https://nodejs.org/), [AWS Lambda](https://aws.amazon.com/lambda/) and [Amazon API Gateway](https://aws.amazon.com/api-gateway/).

Notable features:

* CORS
* ES6 (via Webpack/Babel)
* AVA.js

# Requirements

* Node.js
* Apex (>= 0.11)
* Terraform (>= 0.7)

# Install

1. Install [Apex](https://apex.run) and [Terraform](https://www.terraform.io/)
1. Setup your [AWS Credentials](http://apex.run/#aws-credentials), and ensure "role" in ./project.json is set to your Lambda role ARN.
1. Set the `gateway_lambda_role` variable in `infrastructure/dev/terraform.tfvars` to the ARN of a role that allows API Gateway to invoke Lambda.

For more information on creating roles see the [Permissions and Roles](#permissions-and-roles) section below.

Install NPM dependencies:

```
$ npm install
```

Deploy the graphql lambda function

```
$ apex deploy --env dev
```

Deploy API Gateway endpoint

```
$ apex infra --env dev get
$ apex infra --env dev plan
$ apex infra --env dev apply
```

Note: until Terraform 0.8 is released, you'll need to call `apply` twice - the first will likely fail with errors, and the second should pass.

The apply command will emit the REST API ID which you can use to test your new endpoint, for example:


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

# Permissions and Roles

The lambda function role should contain at minimum the AWSLambdaBasicExecutionRole managed policy.

The `gateway_lambda_role` policy should simply allow API Gateway to invoke your Lambda function:

```
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Action": [
        "lambda:InvokeFunction"
      ]
    }
  ]
}
```

# Run tests

`npm test`


# Resources

[API Gateway / AWS Lambda guide](http://docs.aws.amazon.com/apigateway/latest/developerguide/getting-started.html)

[Introduction to Lambda Permissions](http://docs.aws.amazon.com/lambda/latest/dg/intro-permission-model.html)

# Bugs / Known Issues

* Initial call to `infra apply` fails - should be fixed by hashicorp/terraform#1178 in TF 0.8
* Subsequent calls to `infra apply` don't always appear to 'take' - if after applying changes to the endpoint using 
Terraform you are not seeing the API Gateway changes take effect, you may need to manually re-deploy the resource to the 
`dev` stage via the AWS Console.

# TODO

* Add 500 error handling to API gateway
* Add Amazon RDS as a GraphQL backend?
