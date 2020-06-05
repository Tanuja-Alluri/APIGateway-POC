This is a POC for API Gateway.
It uses Openresty-Alpine (https://github.com/openresty/docker-openresty/blob/master/alpine/Dockerfile)
along with Auth0 for authentication.

This outputs two docker images.
1. For the API Gateway on top of Nginx web browser.
2. A simple nodejs Application server.

Usage:
1. Update the nginx config file at openresty/custom_conf.d with domain name and client ID provided by Auth0.
2. Build docker image for openresty using
```docker image build -t <image_name> <docker_file_path>```
3. Run the docker container using
```docker container run --name <docker_container_name> --publish=8080:8080 <image_name>```
4. Build docker image for nodejs using
```docker image build -t <image_name> <docker_file_path>```
5. Run the docker container using
```docker container run --name <docker_container_name> --publish=9000:9000 <image_name>```

Test:
Open any browser and try to access nodejs through openresty at 
http://localhost:8080/ => This should take you to http://localhost:9000/
http://localhost:8080/api/leads => This should return unauthorised response.
http://localhost:8080/api/leads/secure?token=<token from Auth0> => Get a 200OK response along with leads data.

Or cURL
curl --request GET \ --url http://localhost:8080/test \ --header 'authorization: Bearer <token from Auth0> =>
Get a 200OK response along with leads data.