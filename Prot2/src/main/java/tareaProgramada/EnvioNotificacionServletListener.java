/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tareaProgramada;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author User
 */
public class EnvioNotificacionServletListener implements ServletContextListener {

    private ScheduledExecutorService scheduler; 
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("inicio!");
        scheduler = Executors.newSingleThreadScheduledExecutor();
        scheduler.scheduleAtFixedRate(new EnviarNotificacion(), 0, 1, TimeUnit.MINUTES);
        
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        scheduler.shutdownNow();
        System.out.println("fin!");
    }
}
