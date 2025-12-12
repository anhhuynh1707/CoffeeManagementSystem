package util;

import jakarta.mail.*;
import jakarta.mail.internet.*;
import java.util.Properties;

public class EmailUtil {

    private static final String GMAIL_USERNAME = "huynhtuananh2005@gmail.com";   // YOUR GMAIL
    private static final String GMAIL_APP_PASSWORD = "punqecpwrimqktlf";  // APP PASSWORD ONLY

    public static boolean sendEmail(String to, String subject, String htmlContent) {

        Properties props = new Properties();

        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");  // TLS
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        try {
            // Authentication
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(GMAIL_USERNAME, GMAIL_APP_PASSWORD);
                }
            });

            // Build message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(GMAIL_USERNAME, "Matcha Coffee"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            message.setSubject(subject);
            message.setContent(htmlContent, "text/html; charset=UTF-8");

            // Send
            Transport.send(message);
            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}