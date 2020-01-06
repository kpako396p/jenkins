FROM alpine:latest
RUN apk add --update alpine-sdk perl
RUN wget https://ftp.pcre.org/pub/pcre/pcre-8.43.tar.gz \
    && tar -zxf pcre-8.43.tar.gz \
    && cd pcre-8.43 \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && wget http://zlib.net/zlib-1.2.11.tar.gz \
    && tar -zxf zlib-1.2.11.tar.gz \
    && cd zlib-1.2.11 \
    && ./configure \
    && make \
    && make install \
    && cd .. \
    && wget https://nginx.org/download/nginx-1.17.6.tar.gz \
    && tar zxf nginx-1.17.6.tar.gz \
    && cd nginx-1.17.6 \
    && ./configure --sbin-path=/usr/local/nginx/nginx --conf-path=/usr/local/nginx/nginx.conf --pid-path=/usr/local/nginx/nginx.pid --with-stream --with-pcre=../pcre-8.43 --with-zlib=../zlib-1.2.11 --without-http_empty_gif_module \
    && make \
    && make install \
    && mv /usr/local/nginx/nginx /usr/sbin/ \
    && rm -rf /pcre-8.43.tar.gz /pcre-8.43 /zlib-1.2.11.tar.gz /zlib-1.2.11 /nginx-1.17.6.tar.gz /nginx-1.17.6
COPY index.html /usr/local/nginx/html
CMD ["nginx", "-g", "daemon off;"]