/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package docker;

import java.io.IOException;
import java.io.InputStream;

/**
 *
 * @author elian
 */
public class terminar {
    public static void Terminar(String[] args) {
       try {
           // Run the process
           Process p = Runtime.getRuntime().exec("/bin/sh " + "/root/EliaNS/" + "./terminar.sh");
           // Get the input stream
           InputStream is = p.getInputStream();
 
           // Read script execution results
           int i = 0;
           StringBuffer sb = new StringBuffer();
           while ( (i = is.read()) != -1)
               sb.append((char)i);
 
           System.out.println(sb.toString());
 
       } catch (IOException e) {
           e.printStackTrace();
       }
    }
}
