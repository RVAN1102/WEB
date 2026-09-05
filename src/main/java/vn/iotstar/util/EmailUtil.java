package vn.iotstar.util;

import java.util.Properties;
import java.util.Random;
import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtil {

    // Cấu hình email hệ thống gửi thư (có thể thay đổi khi triển khai thực tế)
    private static final String FROM_EMAIL = "system.shoppingmvc@gmail.com";
    private static final String EMAIL_PASSWORD = "app_password_here";

    /**
     * Sinh mã OTP ngẫu nhiên gồm 6 chữ số (100000 - 999999)
     */
    public static String generateOTP() {
        Random random = new Random();
        int otp = 100000 + random.nextInt(900000);
        return String.valueOf(otp);
    }

    /**
     * Gửi email HTML và ghi mã OTP ra console để phục vụ kiểm thử tiện lợi
     */
    public static boolean sendEmail(String toEmail, String subject, String bodyHtml, String otpCode) {
        // Luôn luôn ghi mã OTP ra console để dễ dàng kiểm thử và demo
        System.out.println("\n================================================================================");
        System.out.println(">>> [HỆ THỐNG GỬI MÃ XÁC THỰC OTP QUA EMAIL]");
        System.out.println(">>> Gửi tới Email: " + toEmail);
        System.out.println(">>> Tiêu đề: " + subject);
        if (otpCode != null && !otpCode.isEmpty()) {
            System.out.println(">>> MÃ OTP XÁC THỰC CỦA BẠN LÀ: [ " + otpCode + " ]");
        }
        System.out.println("================================================================================\n");

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
        props.put("mail.smtp.connectiontimeout", "5000");
        props.put("mail.smtp.timeout", "5000");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, EMAIL_PASSWORD);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL, "Shopping MVC Support"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject(subject, "UTF-8");
            message.setContent(bodyHtml, "text/html; charset=UTF-8");

            Transport.send(message);
            System.out.println(">>> Đã gửi email thực tế thành công tới: " + toEmail);
            return true;
        } catch (Exception e) {
            // Không làm sập ứng dụng nếu SMTP chưa được cấu hình App Password hoặc mất mạng
            System.out.println(">>> Lưu ý: Không gửi được email qua SMTP thật (" + e.getMessage() + ")");
            System.out.println(">>> Hệ thống sử dụng mã OTP đã in ở Console phía trên để tiếp tục phiên làm việc.");
            return true; 
        }
    }

    /**
     * Mẫu HTML email gửi mã OTP kích hoạt tài khoản
     */
    public static String getActivationEmailTemplate(String fullname, String otpCode) {
        return "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px;'>"
                + "<h2 style='color: #007bff; text-align: center;'>Kích Hoạt Tài Khoản Shopping MVC</h2>"
                + "<p>Xin chào <b>" + fullname + "</b>,</p>"
                + "<p>Cảm ơn bạn đã đăng ký tài khoản tại hệ thống của chúng tôi. Dưới đây là mã xác thực OTP của bạn:</p>"
                + "<div style='text-align: center; margin: 25px 0;'>"
                + "<span style='font-size: 28px; font-weight: bold; letter-spacing: 6px; color: #28a745; background: #e8f5e9; padding: 12px 24px; border-radius: 6px; display: inline-block;'>"
                + otpCode + "</span>"
                + "</div>"
                + "<p style='color: #666;'>Mã xác thực này có hiệu lực trong vòng 15 phút. Vui lòng không chia sẻ mã cho bất kỳ ai.</p>"
                + "<hr style='border: none; border-top: 1px solid #eee; margin: 20px 0;'>"
                + "<p style='font-size: 12px; color: #999; text-align: center;'>Email tự động từ hệ thống Shopping MVC. Vui lòng không trả lời thư này.</p>"
                + "</div>";
    }

    /**
     * Mẫu HTML email gửi mã OTP quên mật khẩu
     */
    public static String getResetPasswordEmailTemplate(String fullname, String otpCode) {
        return "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #e0e0e0; border-radius: 8px;'>"
                + "<h2 style='color: #dc3545; text-align: center;'>Yêu Cầu Đặt Lại Mật Khẩu</h2>"
                + "<p>Xin chào <b>" + fullname + "</b>,</p>"
                + "<p>Hệ thống nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn. Dưới đây là mã OTP xác thực:</p>"
                + "<div style='text-align: center; margin: 25px 0;'>"
                + "<span style='font-size: 28px; font-weight: bold; letter-spacing: 6px; color: #dc3545; background: #fde8e8; padding: 12px 24px; border-radius: 6px; display: inline-block;'>"
                + otpCode + "</span>"
                + "</div>"
                + "<p style='color: #666;'>Nếu bạn không yêu cầu hành động này, vui lòng bỏ qua email và bảo vệ tài khoản của bạn.</p>"
                + "<hr style='border: none; border-top: 1px solid #eee; margin: 20px 0;'>"
                + "<p style='font-size: 12px; color: #999; text-align: center;'>Email tự động từ hệ thống Shopping MVC. Vui lòng không trả lời thư này.</p>"
                + "</div>";
    }
}
