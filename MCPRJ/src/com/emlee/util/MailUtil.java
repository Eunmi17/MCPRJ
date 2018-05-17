package com.emlee.util;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtil {
	public static void sendMail(String recipient, String subject, String body)
			throws AddressException, MessagingException {
		String host = "gmail-smtp.l.google.com";

		final String username = "kangseokopo@gmail.com";
		final String password = "fggbrgppljjozirw";

		Properties props = System.getProperties();

		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.starttls.enable", "true");
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.auth", "true");

		Session session = Session.getDefaultInstance(props, new Authenticator() {
			String un = username;
			String pw = password;

			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true);
		Message mimeMessage = new MimeMessage(session);
		mimeMessage.setFrom(new InternetAddress("kangseokopo@gmail.com"));
		mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
		mimeMessage.setSubject(subject);
		mimeMessage.setText(body);
		Transport.send(mimeMessage);
	}
}
