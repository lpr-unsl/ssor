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
FROM ubuntu:18.04
LABEL mantainer=”ctaffer@unsl.edu.ar”
ENV TERM xterm 
ENV PS1='\h:\w\$ '
WORKDIR /root
RUN apt update
RUN apt -y install iproute2 net-tools telnet netcat iptables tcpdump iputils-ping openssh-client nano less
RUN echo root:lpr | chpasswd
USER 0:0 
CMD /bin/bash
