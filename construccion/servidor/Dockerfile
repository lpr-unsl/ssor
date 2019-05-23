#    ADD parecida a COPY .. se prefiere COPY por ser mas transparente
#    COPY archivos locales al container efimero que estoy creando
#    ENV setea variables de entorno
#    EXPOSE puerto en el que publicara
#    FROM de que imagen arrancamos ..puede ir con AS .. para construcciones intermedias
#    LABEL lo que quiera sirve para documentar key=value
#    STOPSIGNAL instruction sets the system call signal that will be sent to the container to exit ;-)
#    USER usuario con el que correra el CMD
#    VOLUME creates a mount point with the specified name and marks it as holding
#    WORKDIR del contenedor efimero
#    RUN corre en el container efimero el comando para despues generar la imagen
#    HEALTHCHECK
#    ENTRYPOINT allows you to configure a container that will run as an executable
#    SHELL cambia el que se usa por defecto ["/bin/sh", "-c"]
#    CMD
FROM router:3.0
LABEL mantainer=”ctaffer@unsl.edu.ar”
ENV TERM xterm 
ENV PS1='\h:\w\$ '
WORKDIR /root
RUN apt update
RUN apt -y install isc-dhcp-relay
RUN apt -y install rsyslog ethtool vim openssh-server isc-dhcp-server bind9 bind9-host apache2 sendmail mutt dovecot-pop3d openvpn squid
RUN echo 'set bg=dark' > .vimrc
COPY *.mp3 /root 
RUN sed  -i 's/listen-on-v6 { any; }/listen-on { 127.0.0.1; };\n\tlisten-on-v6 { ::1; };/g' /etc/bind/named.conf.options
RUN echo 'FEATURE(accept_unqualified_senders)dnl\nFEATURE(accept_unresolvable_domains)dnl' >> /etc/mail/sendmail.mc
RUN echo localhost > /etc/mail/local-host-names
RUN sed -i -e 's/#disable_plaintext_auth = yes/disable_plaintext_auth = no/g' /usr/share/dovecot/conf.d/10-auth.conf
RUN sed -i -e 's/files dns/files/g' /etc/nsswitch.conf
COPY *.gz /usr/share/doc/openvpn/examples
WORKDIR /usr/share/doc/openvpn/examples
RUN tar xvzf sample.tar.gz
RUN rm sample.tar.gz
WORKDIR /usr/share/doc/openvpn/examples/sample-keys
RUN gunzip server.crt.gz
RUN gunzip client.crt.gz
WORKDIR /usr/share/doc/openvpn/examples/sample-config-files
RUN gunzip server.conf.gz
WORKDIR /root
USER 0:0 
CMD /bin/bash
