worker_processes  1;
error_log logs/error.log;

events {
  worker_connections 1024;
}

http {
  lua_package_path "/usr/local/openresty/lualib/ngx/?.lua;;";
  
  resolver 8.8.8.8;

  # cache for discovery metadata documents
  lua_shared_dict discovery 1m;
  # cache for JWKs
  lua_shared_dict jwks 1m;
  server {
    set_by_lua $server_name_from_env 'return os.getenv("NGINX_SERVERNAME")';
      listen 8080;
      location / {
          proxy_pass http://docker.for.mac.host.internal:9000;
      }
      
      location /api {
          access_by_lua '
              local opts = {
                ssl_verify = "no",
                discovery = {
                  jwks_uri = "https://<domain_name>/.well-known/jwks.json"
                }
              }
              local res, err = require("resty.openidc").bearer_jwt_verify(opts)

              if err or not res then
                ngx.status = 403
                ngx.say(err and err or "no access_token provided")
                ngx.exit(ngx.HTTP_FORBIDDEN)
              end

              if res.azp ~= "<client_ID>" then
                ngx.exit(ngx.HTTP_FORBIDDEN)
              end
          ';

          proxy_pass http://docker.for.mac.host.internal:9000;
      }
  }
}