package com.shop.shop.util;

import java.nio.charset.StandardCharsets;
import java.util.Properties;
import java.util.Random;

import org.springframework.stereotype.Component;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

@Component
public class SendMail {

    public String getRandom() {
        Random rnd = new Random();
        int number = rnd.nextInt(999999);
        return String.format("%06d", number);
    }

    // send email to the user email
    public boolean sendEmail(String toEmail, String code) {
        boolean test = false;

        String fromEmail = "HuuTria22005@gmail.com";
        String password = "jfzigefdxztddtpw";

        // Khởi tạo Properties và cấu hình
        Properties pr = new Properties();
        pr.setProperty("mail.smtp.host", "smtp.gmail.com");
        pr.setProperty("mail.smtp.port", "587");
        pr.setProperty("mail.smtp.auth", "true");
        pr.setProperty("mail.smtp.starttls.enable", "true");
        pr.put("mail.smtp.ssl.protocols", "TLSv1.2");
        pr.put("mail.smtp.socketFactory.port", "587");
        // pr.put("mail.smtp.socketFactory.class", "jakarta.net.ssl.SSLSocketFactory");

        try {
            Session session = Session.getInstance(pr, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(fromEmail, password);
                }
            });

            // set email message details
            Message mess = new MimeMessage(session);

            // set from email address
            mess.setFrom(new InternetAddress(fromEmail));

            // set to email address or destination email address
            mess.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            // mess.setSubject("Yêu cầu đặt lại mật khẩu - Mã xác thực của bạn", "UTF-8");

            // Read HTML template
            String htmlContent = readEmailTemplate();
            // Replace placeholder with the actual code
            htmlContent = htmlContent.replace("${code}", code);

            // set message text and content type
            mess.setContent(htmlContent, "text/html; charset=UTF-8");

            // send the message
            Transport.send(mess);

            test = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return test;
    }

    private String readEmailTemplate() throws java.io.IOException {
        // Lấy đường dẫn tuyệt đối tới file JSP
        String filePath = "src/main/webapp/WEB-INF/views/auth/email-template.jsp";
        byte[] byteArray = java.nio.file.Files.readAllBytes(java.nio.file.Paths.get(filePath));
        return new String(byteArray, StandardCharsets.UTF_8);
    }

}
