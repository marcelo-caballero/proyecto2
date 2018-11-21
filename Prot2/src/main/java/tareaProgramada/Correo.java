/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tareaProgramada;

import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author User
 */
public class Correo {
    private  String username;
    private  String password;

    private Properties props;
    
    private Session session;
        
    public Correo() {
        this.username = "proy2semestre@gmail.com";
        this.password = ".9Fe*,NxP$";
        this.props = new Properties();
        
        this.props.put("mail.smtp.auth", "true");
        this.props.put("mail.smtp.starttls.enable", "true");
        this.props.put("mail.smtp.host", "smtp.gmail.com");
        this.props.put("mail.smtp.port", "587");
        this.props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        
        this.session = Session.getInstance(props,
        new javax.mail.Authenticator() {
              protected PasswordAuthentication getPasswordAuthentication() {
                      return new PasswordAuthentication(username, password);
              }
        });
    }
    
    public void enviarCorreo(String destinatario, String asunto, String mensaje){
        
        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("from-email@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(destinatario,false));
            message.setSubject(asunto);
            message.setText(mensaje);

            Transport.send(message);

        } catch (Exception e) {
                System.out.println(e);
        }
    }
    
}
