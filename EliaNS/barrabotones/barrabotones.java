/** @author: tlfs & afzs */
package barrabotones;

import java.awt.event.MouseListener;

import javax.swing.JToolBar;

import util.colores;
import util.nomiconos;

/** Clase barrabotones para crear el menu barrabotones */
public class barrabotones extends JToolBar
{
	/** boton nuevo archivo */
	private bboton btnN;
	/** boton abrir archivo */
	private bboton btnA;
	/** boton guardar archivo */
	private bboton btnG;

	/** boton imprimir */
	private bboton btnI;
	/** boton buscar */
	private bboton btnB;
	
	/** boton cortar equipos */
	private bboton btnX;
	/** boton copiar equipos */
	private bboton btnC;
	/** boton pegar equipos */
	private bboton btnP;
	
	/** boton comprobar simulacion */
	private bboton btnCompS;
	/** boton configurar envios */
	private bboton btnSE;
	
	/** boton simular envios */
	private bboton btnSi;
	/** boton simular paso a paso */
	private bboton btnSip;

	/** boton detener simulacion */
	private bboton btnDS;
	/** boton mostrar sucesos de la simulacion */
	private bboton btnEvS;

	/** opcion para ir indicando que evento se va procesando */
	private bboton btnInfoEv;
	
	/** boton para separar un menu de otro */
	private bboton btnS;
	/** boton para separar un menu de otro */
	private bboton btnS2;
	/** boton para separar un menu de otro */
	private bboton btnS3;
        private bboton btnS4;
        private bboton btnS5;
        private bboton btnS6;
        /** boton para iniciar docker */
	private bboton btnDocker;
        private bboton btnDocker1;
        private bboton btnDocker2;
        private bboton btnDocker3;

	
	/** Constructor de barrabotones */
	public barrabotones(MouseListener oyente, String estado)
	{
		// a cada boton le pasamos unos valores determinados:
		// el nombre del boton, la ruta de la imagen, el oyente del boton, los estados en los que va a estar habilitado,
		// el estado actual y el texto que aparece cuando se acerca el raton al boton.
		setBackground(colores.fondoBarras);
		
		btnN= new bboton();
		btnN.setPBoton("btnN", nomiconos.nombotonNuevo, oyente, ",99,", estado,"Nuevo");
		add(btnN);

		btnA= new bboton();
		btnA.setPBoton("btnA", nomiconos.nombotonAbrir, oyente, ",99,", estado,"Abrir");
		add(btnA);

		btnG= new bboton();
		btnG.setPBoton("btnG", nomiconos.nombotonGuardar, oyente, ",18,", estado,"Guardar");
		add(btnG);

		btnS2= new bboton();
		btnS2.setPBoton("btnS2", nomiconos.nombotonSeparador, oyente, "", estado,"");
		add(btnS2);
		
		btnI= new bboton();
		btnI.setPBoton("btnI", nomiconos.nombotonImprimir, oyente, ",1,4,5,6,7,8,9,10,", estado,"Imprimir");
		add(btnI);
		
		btnB= new bboton();
		btnB.setPBoton("btnB", null, oyente, ",9,10,", estado,"Buscar");
		add(btnB);
		
		btnS= new bboton();
		btnS.setPBoton("btnS", nomiconos.nombotonSeparador, oyente, "", estado,"");
		add(btnS);

		btnX= new bboton();
		btnX.setPBoton("btnX", nomiconos.nombotonCortar, oyente, ",1,7,8,", estado,"Cortar");
		add(btnX);
		
		btnC= new bboton();
		btnC.setPBoton("btnC", nomiconos.nombotonCopiar, oyente, ",1,7,8,", estado,"Copiar");
		add(btnC);
		
		btnP= new bboton();
		btnP.setPBoton("btnP", nomiconos.nombotonPegar, oyente, ",3,4,5,", estado,"Pegar");
		add(btnP);

		btnS3= new bboton();
		btnS3.setPBoton("btnS3", nomiconos.nombotonSeparador, oyente, "", estado,"");
		add(btnS3);

		btnCompS= new bboton();
		btnCompS.setPBoton("btnCompS", nomiconos.nombotonCompruebaSimula, oyente, ",13,", estado,"Comprobar Simulacion");
		add(btnCompS);

		btnSE= new bboton();
        	btnSE.setPBoton("btnSE", null, oyente, ",14,", estado,"Configurar Envios");
		add(btnSE);

		btnSi= new bboton();
		btnSi.setPBoton("btnSi", null, oyente, ",15,", estado,"Simular Envios");
		add(btnSi);

		btnSip= new bboton();
		btnSip.setPBoton("btnSip", null, oyente, ",15,", estado,"Simular paso a paso");
		add(btnSip);

		btnDS= new bboton();
		btnDS.setPBoton("btnDS", null, oyente, ",16,", estado,"Detener Simulacion");
		add(btnDS);

		btnEvS= new bboton();
		btnEvS.setPBoton("btnEvS", null, oyente, ",17,", estado,"Mostrar Sucesos de la Simulacion");
		add(btnEvS);               
		
                btnDocker= new bboton();
		btnDocker.setPBoton("btnDocker", nomiconos.nomIniciarDocker, oyente, ",13,", estado,"Iniciar Docker");
		add(btnDocker);
                
                btnS4= new bboton();
		btnS4.setPBoton("btnS4", nomiconos.nombotonSeparador, oyente, "", estado,"");
		add(btnS4);
                
                btnDocker1= new bboton();
		btnDocker1.setPBoton("btnDocker1", nomiconos.nomPausarDocker, oyente, ",13,", estado,"Pausar Docker");
		add(btnDocker1);
                
                btnS5= new bboton();
		btnS5.setPBoton("btnS5", nomiconos.nombotonSeparador, oyente, "", estado,"");
		add(btnS5);
                
                btnDocker2= new bboton();
		btnDocker2.setPBoton("btnDocker2", nomiconos.nomReanudarDocker, oyente, ",13,", estado,"Reanudar Docker");
		add(btnDocker2);
                
                btnS6= new bboton();
		btnS6.setPBoton("btnS6", nomiconos.nombotonSeparador, oyente, "", estado,"");
		add(btnS6);
                
                btnDocker3= new bboton();
		btnDocker3.setPBoton("btnDocker3", nomiconos.nomTerminarDocker, oyente, ",13,", estado,"Terminar Docker");
		add(btnDocker3);
                
		btnInfoEv= new bboton();
		btnInfoEv.setPBoton("btnInfo", null, null, ",16,", estado, "");
		add(btnInfoEv);
                
	}
	

	/** Funcion que habilita o deshabilita los estados
	 * y para cada boton se introducen los estados en los que este va a estar habilitado
	 * @param estado estado actual
	 * @param texto la informacion que aparece de los eventos procesados de la simulacion
	 */
	public void habilita(String estado, String texto)
	{
		btnN.establece(",99,",estado);
		btnA.establece(",99,",estado);
		btnG.establece(",18,",estado);
		
		btnX.establece(",1,7,8,",estado);
		btnC.establece(",1,7,8,",estado);
		btnP.establece(",3,4,5,",estado);
		
		btnI.establece(",1,4,5,6,7,8,9,10,",estado);
		btnB.establece(",9,10,",estado);
		
		btnCompS.establece(",13,",estado);
		btnSE.establece(",14,",estado);
		btnSi.establece(",15,",estado);
		btnSip.establece(",15,",estado);
		btnDS.establece(",16,",estado);
		btnEvS.establece(",17,",estado);
                btnDocker.establece(",13,",estado);
                btnDocker1.establece(",13,",estado);
                btnDocker2.establece(",13,",estado);
                btnDocker3.establece(",13,",estado);
		
		btnInfoEv.establece(",16,", estado);
		btnInfoEv.estableceTexto(texto);
	}	
}
