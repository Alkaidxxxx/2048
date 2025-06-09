FROM rocky:CMT
LABEL author=alkaid
ADD nginx-1.22.1.tar.gz /root
ADD docker-entrypoint.sh /docker-entrypoint.sh
RUN yum -y install pcre-devel zlib-devel openssl-devel gcc make
RUN cd /root/nginx-1.22.1 && useradd -r nginx && ./configure --prefix=/usr/local/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/lock/nginx.lock --user=nginx --group=nginx --with-http_ssl_module --with-http_v2_module --with-http_dav_module --with-http_stub_status_module --with-threads --with-file-aio && make -j 4 && make install && ln -sv /usr/local/nginx/sbin/nginx /usr/local/sbin/nginx
RUN yum clean all
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx","-g","daemon off;"]
