# LPR HOWTO - Cómo comenzar a trabajar con LPR  

Se puede trabajar de varias maneras dependiendo de la necesidad:
### A) Trabajo en distintos lugares, sin acceder/modificar el disco de cada PC
1. Requisitos:
  - LiveCD (DVD) o USB (4G) con sistema operativo LPR
  - USB (4G) para almacenar imagenes y llevarlas a los distintos lugares   

2. Configuracion inicial:  
  - La imagen de LPR puede ser descargada desde < http://www.dirinfo.unsl.edu.ar/lpr/ >  

  - Usar k3b u otra herramienta para grabar la imagen ISO descargada en un DVD o USB

  - Bootear la máquina desde DVD o USB, según corresponda 
  
3. Continuar en la sección **"D"**  

### B) Trabajo en distintos lugares, pudiendo acceder/modificar el disco de cada PC
1. Requisitos:
  - Virtualización de sistema operativo LPR (Virtualbox, Vmware,etc)
  - USB (4G) para almacenar imagenes y llevarlas a los distintos lugares  
  
2. Configuracion inicial:  
  - La imagen de LPR puede ser descargada desde < http://www.dirinfo.unsl.edu.ar/lpr/ >  
  - Usar el virtualizador para crear una maquina virtual llamada LPR con las siguientes características:
    - Tipo Linux
    - ubuntu 64 bits
    - al menos 2G de ram
    - En almacenamiento conectar la imagen ISO descargada al la lectora de DVD
    - Configurar el booteo de la máquina virtual desde DVD
    - Conectar el USB a la maquina virtual 
  - Bootear la máquina virtual
3. Continuar en a la seccion **"D"**

### C) Trabajo en un solo lugar, pudiendo acceder/modificar el dico de cada PC
1. Requisitos:
  - Virtualización de sistema operativo LPR (Virtualbox, Vmware,etc)
  - Espacio en disco rígido (al menos 4Gb) para crear una Partición virtual

2. Configuracion inicial:  
  - La imagen de LPR puede ser descargada desde < http://www.dirinfo.unsl.edu.ar/lpr/ >
  - Usar el virtualizador para crear una máquina virtual llamada LPR con las siguientes características:
    - Tipo Linux
    - ubuntu 64 bits
    - al menos 2G de ram
    - En almacenamiento conectar la imagen ISO al la lectora de DVD
    - Configurar el booteo de la maquina virtual desde DVD
    - crear un disco virtual tipo vdi , dinámico de al menos 4Gb  
  - Bootear la maquina virtual 
  
  3. Continuar en la seccion **"D"**


### D) Inicialización de imagenes de Docker
  Esta tarea se ejecutara **SOLO una vez** en cada una de las maquinas que quiera utilizar para realizar los practicos.
  - loguearse con usuario *root* password *lprlpr*
  - En el menu, seleccionar aplications -> terminal emulator
  - Averiguar el nombre de la partición que se usará para almacenar las imagenes de docker
    - Para ello escribir el siguiente comando en la terminal y tomar nota del nombre del disco de 4G que creamos o el usb que conectamos
      - fdisk -l
  - Cambiarse al directorio *Documents* e inicializar las imagenes docker.
    - Para ello ejecutar los siguentes comandos en la terminal:
      - cd Documents
      - ./inicializar.sh
  - Este procedimiento importara las imagenes al disco que se creo mas arriba. Pide como parametro el nombre del disco, luego lo formateará y creará las imagenes de docker
    - una vez que termine, se puede verificar las imagenes importadas ejecutando el comando:
      - docker images -a
    - NOTA: dependiendo de la maquina real que tienen y la velocidad de acceso de USB, el proceso puede demorar desde un par de minutos a 10 minutos ...
  - Ahora estan en condiciones de hacer los practicos.
  
  ### E) Realizacion de Practicos:
  - Dependiendo del pracico que quieran realizar, 
    - Ejecutan los siguientes comando en la terminal:
      - cd ssor
      - cd NOMBRE_DEL_PRACTICO
      - ./iniciar.sh
    
  - Una vez que hicieron modificaciones en la configuración de los servicios, pueden guardar el estado.
    - ejecutando el comando:
      - /pausar.sh
    - el script ./pausar.sh hace commit de los contenedores usados a nuevas imagenes llamadas "practico"-nombre_del_contenedor
  - Si quieren seguir trabajando en otra PC, deben llevarse en USB las imagenes con los cambios
    - para ello ejecutan en la terminal:
      - ./exportar
      ese script mustra es espacio ocupado y pide un disco donde pondremos los archivos tar exportados (usb)

  - Una vez que se encuentran en la otra PC:
    - Deberán SOLO la primera vez que la usen inicializarla, de acuerdo al punto D. 
    - Luego ir al directorio deferido al practico, y ejecutando en la terminal:
      - cd Documents/ssor/NOMBRE_DEL_PRACTICO
      - ./importar.sh
  
  - Luego, ya sea si estan en otra PC o continuan en la misma que ejecutaron ./pausar.sh , deben reanudar la ejecucion del practivo.
    - Para ello ejecutan en la terminal lo siguiente:
      - ./continuar.sh  
  NOTA: Para el practico de dhcp y dns NO se guarda la configuracion de red ... hay que volver a configurar las placas de red y rutas, si fueran necesarias, en los contenedores





