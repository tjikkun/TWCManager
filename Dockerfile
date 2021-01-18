# Base on the CentOS
FROM arm64v8/centos:8
MAINTAINER sander@hoentjen.eu

WORKDIR /app
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN dnf clean all && dnf -y install epel-release && dnf -y install git make lighttpd-fastcgi python38-devel python38-setuptools gcc && dnf -y update
RUN systemctl enable lighttpd.service
COPY twcmanager.service /etc/systemd/system/twcmanager.service
RUN systemctl enable twcmanager.service
#RUN git clone https://github.com/ngardiner/TWCManager && cd TWCManager && git checkout v1.2.1 
#RUN cd TWCManager && cp html/* /var/www/lighttpd/
#RUN cd TWCManager && ./setup.py install
#RUN mkdir -p /etc/twcmanager


#RUN dnf -y install nginx && dnf clean all
#RUN echo "daemon off;" >> /etc/nginx/nginx.conf
#RUN echo "nginx on Fedora" > /usr/share/nginx/html/index.html

EXPOSE 8000

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
#ENTRYPOINT [ "/usr/bin/python3", "-m", "TWCManager" ]
