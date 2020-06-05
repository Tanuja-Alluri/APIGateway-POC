FROM openresty/openresty:alpine
RUN apk add --no-cache curl perl
RUN opm install zmartzone/lua-resty-openidc
# ADD env_config.json /etc/nginx/env/env_config.json
ADD custom_conf.d /usr/local/openresty/nginx/conf/nginx.conf