# NETOSLAB - Laboratorio de Sistemas Operativos y Redes

### Motivación:
Crear una herramienta fundamental para el desarrollo de las prácticas en las siguientes materias de la **FCFMYN - UNSL**:
- Servicios en Sistemas Operativos de Redes 
- Introducción a la Seguridad de Redes 
- Sistemas Operativos de Redes
- Sistemas Operativos genericos (planificación, gestión de memoria)
- ethical hacking 
- toda aquella materia que requiera su utilizacion.

### Objectivos:
El diseño e implementación de un ambiente de simulación de redes de computadoras. Los alcances del mismo son los siguientes:

 1. Permitir desplegar toda una red de máquinas virtualizada en solo una computadora, sin tener que instalar software alguno en la misma.
 2. La red debe poseer al menos 6 nodos con distintos tipos de sistema operativo, de ser posible.
 3. Permitir interconectar de distinta manera los nodos creados con el objetivo de ensayar distintas topologías de red en capa de enlace.
 4. Dar soporte de distintos protocolos de capa de red  como IPv4, IPv6, IPSec, etc.
 5. Configurar en cada uno de los nodos distintos protocolos pertenecientes a de capa de aplicación, tales como HTTP, SMTP, DNS, DHCP, FTP, SIFS, SSH, Proxy, distintos tipos de VPN , LDAP, etc.
 6. Ejecutar clientes que hagan uso de los servicios puestos en marcha en otros nodos, para verificar el correcto funcionamiento de tales servicios.
 7. Ejecutar aplicaciones de simulación para comprender el funcionamiento de gestión de memoria, y la planificación de procesos.
 8. Almacenar toda la configuración realizada, para posteriores simulaciones.
 9. Cear una imagen booteable en DVD o USB  con todo el software necesario, para que sea facilmente transportable.
 10. Realizar ajustes para permitir la simulación en hardware limitado en capacidad de procesamiento y memoria principal.

# IMAGEN NETOSLAB - Descarga y verificación de la imagen
  - La imagen de NETOSLAB puede ser descargada desde < http://lpr.dirinfo.unsl.edu.ar/versions/netOSLab-1.2.2.iso >
  - Para verificar la imagen descargada, se puede usar el comando *md5sum* en linux o *fciv* en windows
    - En linux, se puede ejecutar el siguiente comando:
      - md5sum netOSLab-1.X.X.iso
    - El resultado para la última version debe ser:
      - **0b04f65bac2faae35ebab57c60d57470**

# NETOSLAB HOWTO - Formas de trabajo con NETOSLAB

Se puede trabajar de varias maneras dependiendo de la necesidad:
### A) Trabajo en un solo lugar, pudiendo acceder/modificar el dico de cada PC
1. Requisitos:
  - Virtualización de sistema operativo NETOSLAB (Virtualbox, Vmware,etc)
  - Espacio en disco rígido (al menos 4Gb) para crear una Partición virtual
  - Imagen de NETOSLAB descargada en el disco y verificada usando el md5sum (ver arriba)

2. Creación maquina virtual:
  - a) Usar el virtualizador para crear una máquina virtual llamada NETOSLAB con las siguientes características:
    - Tipo Linux
    - ubuntu 64 bits
    - al menos 2G de ram
    - En almacenamiento conectar la imagen ISO al la lectora de DVD
    - Configurar el booteo de la maquina virtual desde DVD
    - crear un disco virtual tipo vdi , dinámico de al menos 4Gb
  -  b) En caso de usar Virtualbox (7.0 o mayor) se puede crear la máquina virtual ejecutando el siguiente script:
    -  ./create_netOSLab.sh desde < https://github.com/lpr-unsl/netOSLab/blob/main/provision/create_netOSLab.sh >
  - Bootear la maquina virtual 

  3. Continuar en la seccion **"C"**

### B) Trabajo en distintos lugares, sin acceder/modificar el disco de cada PC
1. Requisitos:
  - LiveCD (DVD) o USB (4G) con sistema operativo NETOSLAB descargo y verificado usando el md5sum (ver arriba)
  - USB (4G) para almacenar imagenes y llevarlas a los distintos lugares 

2. Configuracion inicial:

  - Usar k3b u otra herramienta para grabar la imagen ISO descargada en un DVD o USB

  - Bootear la máquina desde DVD o USB, según corresponda 
  - Conectar un/otro USB de al menos 4G a la máquina, para descargar las imagenes docker en ellas

3. Continuar en la sección **"C"**

### C) Inicialización de imagenes de Docker
  Esta tarea se ejecutara **SOLO una vez** en cada una de las maquinas que quiera utilizar para realizar los practicos.
  - loguearse con usuario *root* password *netOSLab*
  - En el menu, seleccionar aplications -> terminal emulator
  - Averiguar el nombre de la partición que se usará para almacenar las imagenes de docker
    - Para ello escribir el siguiente comando en la terminal y tomar nota del nombre del disco de 4G que creamos o el usb que conectamos
      - fdisk -l
  - Cambiarse al directorio *Documents/ssor* e inicializar las imagenes docker.
    - Para ello ejecutar los siguentes comandos en la terminal:
      - cd Documents/ssor
      - ./inicializar.sh
  - Este procedimiento importara las imagenes al disco que se creo mas arriba. Pide como parametro el nombre del disco (Ej. /dev/sda), luego lo formateará y descargará las imagenes de docker
    - una vez que termine, se puede verificar las imagenes importadas ejecutando el comando:
      - docker images -a
    - NOTA: dependiendo de la maquina real que tienen y la velocidad de acceso a internet, el proceso puede demorar desde un par de minutos a 10 minutos ...
  - Ahora estan en condiciones de hacer los practicos.

### D) Realizacion de Practicos:
  - Dependiendo del pracico que quieran realizar, 
    - Ejecutan los siguientes comando en la terminal:
      - cd ssor
      - cd NOMBRE_DEL_PRACTICO
      - ./iniciar.sh
