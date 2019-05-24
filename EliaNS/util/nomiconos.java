/** @author: tlfs & afzs */
package util;

/** En esta clase se definen las constantes con las rutas de las imagenes */
public class nomiconos
{
	/** Separador de rutas dependiende del sistema operativo */
	public static final String CADENASEPARADOR = System.getProperty("file.separator");
	
	/** Carpeta donde se encuentran almacenadas las imagenes */
	public static String CARPETA = System.getProperty("user.dir") + CADENASEPARADOR + "imagenes" + CADENASEPARADOR;

	/** Imagen para flecha hacia abajo */
	public static final String flechaAbajo = CARPETA + "flechaAbajo.gif";

	/** Imagen para flecha hacia arriba */
	public static final String flechaArriba = CARPETA + "flechaArriba.gif";

	/** Imagen para ventana acerca de */
	public static final String nomAcerca = CARPETA + "I1.gif";

	/** Constante para el icono del anillo */
	public static final String nomAnillo = CARPETA + "anillo.gif";

	/** Constante para el icono del raton del anillo */
	public static final String nomAnilloCursor = CARPETA + "anillocursor.gif";

	/** Constante para el boton Abrir */
	public static final String nombotonAbrir = CARPETA + "botonAbrir.gif";

	/** Constante para el boton Buscar */
	public static final String nombotonBuscar = CARPETA + "botonBuscar.gif";

	/** Constante para el boton Comprueba Simulacion */
	public static final String nombotonCompruebaSimula = CARPETA + "botonCompruebaS.gif";

	/** Constante para el boton Copiar */
	public static final String nombotonCopiar = CARPETA + "botonCopiar.gif";

	/** Constante para el boton Cortar */
	public static final String nombotonCortar = CARPETA + "botonCortar.gif";

	/** Constante para el boton Detiene Simulacion */
	public static final String nombotonDetieneSimu = CARPETA + "botonDetieneSimu.gif";

	/** Constante para el boton Eventos Simulacion */
	public static final String nombotonEventosSimu = CARPETA + "botonEventosS.gif";

	/** Constante para el boton Guardar */
	public static final String nombotonGuardar = CARPETA + "botonGuardar.gif";

	/** Constante para el boton Imprimir */
	public static final String nombotonImprimir = CARPETA + "botonImprimir.gif";
	
	/** Constante para el boton Nuevo */
	public static final String nombotonNuevo = CARPETA + "botonNuevo.gif";

	/** Constante para el boton Pegar */
	public static final String nombotonPegar = CARPETA + "botonPegar.gif";

	/** Constante para el boton Separador */
	public static final String nombotonSeparador = CARPETA + "botonSeparador.gif";

	/** Constante para el boton Configurar envio */
	public static final String nombotonSimuEnvio = CARPETA + "botonSimuEnvio.gif";

	/** Constante para el boton Simular paso a paso */
	public static final String nombotonSimulaPaso = CARPETA + "botonSimulaP.gif";

	/** Constante para el boton Simular todo */
	public static final String nombotonSimulaTodo = CARPETA + "botonSimulaT.gif";

	/** Constante para el icono cursor por defecto */
	public static final String nomCursor = CARPETA + "cursor.gif";

	/** Constante para el icono de la ethernet */
	public static final String nomEthernet = CARPETA + "ethernet.gif";

	/** Constante para el icono del raton de la ethernet */
	public static final String nomEthernetCursor = CARPETA + "ethernetCursor.gif";

	/** Constante para el icono de la etiqueta */
	public static final String nomEtiqueta = CARPETA + "etiqueta.gif";

	/** Constante para el icono del hub */
	public static final String nomHub = CARPETA + "hub.gif";
	
	/** Constante para el icono linea de conexion */
	public static final String nomLinea = CARPETA + "linea.gif";

	/** Constante para el icono del raton de la linea de conexion */
	public static final String nomLineaCursor = CARPETA + "lineaCursor.gif";

	/** Constante para el icono del modem */
	public static final String nomModem = CARPETA + "modem.gif";

	/** Constante para el icono del raton del modem */
	public static final String nomModemCursor = CARPETA + "modemCursor.gif";

	/** Constante para el icono del PC */
	public static final String nomPC = CARPETA + "pc.gif";

	/** Constante para el icono del puente */
	public static final String nomPuente = CARPETA + "puente.gif";

	/** Constante para el icono del Router */
	public static final String nomRouter = CARPETA + "router.gif";

	/** Constante para el icono del switch */
	public static final String nomSwitch = CARPETA + "switch.gif";

	/** Constante para el un icono vacio*/
	public static final String nomVacio = CARPETA + "vacio";

	/** Constante para el icono de la Wan */
	public static final String nomWan = CARPETA + "wan.gif";
        
        public static final String nomIniciarDocker = CARPETA + "iniciarDocker.gif";

        public static final String nomPausarDocker = CARPETA + "pausarDocker.gif";
        
        public static final String nomReanudarDocker = CARPETA + "reanudarDocker.gif";
        
        public static final String nomTerminarDocker = CARPETA + "terminarDocker.gif";
	/** Constante para el cursor por defecto */
	public static final int tam = 40;
	
	/** Devuelve el nombre del equipo que corresponde a un icono dado
	 * @param nomicono Nombre del icono
	 * @return String conteniendo el nombre que corresponde al equipo
	 */
	public String getNombre(String nomicono)
	{
		// Quitamos la ruta y la extension
		String dev = nomicono.substring(nomicono.lastIndexOf(CADENASEPARADOR)+1, nomicono.lastIndexOf("."));
		
		// y ponemos el primer caracter en mayusculas
		return (dev.substring(0, 1)).toUpperCase() + dev.substring(1, dev.length());
	}

	/** Esta clase devuelve el icono del raton que corresponde a un icono del panel
	 * @param nombre Nombre del icono
	 * @return String con el nombre del cursor correspondiente
	 */
	public String getNomIconoCursor(String nombre)
	{
		String dev = nombre;

		if (nombre.compareTo(nomLinea)==0)
			dev = nomLineaCursor;
		else if (nombre.compareTo(nomEthernet)==0)
			dev = nomEthernetCursor;
		else if (nombre.compareTo(nomAnillo)==0)
			dev = nomAnilloCursor;

		return dev;
	}
}