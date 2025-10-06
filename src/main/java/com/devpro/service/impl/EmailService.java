package com.devpro.service.impl;

import com.devpro.models.Order;
import com.devpro.models.OrderProduct;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import java.text.DecimalFormat;
import java.util.List;

@Service
public class EmailService {

    private final JavaMailSender mailSender;

    @Autowired
    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendLoginSuccessEmail(String recipientEmail, String userName) {
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom("iphoneserversendemail@gmail.com", "IPhone Shop");
            helper.setTo(recipientEmail);
            helper.setSubject("Đăng nhập thành công");
            String content = "<div style=\"font-family: Arial, sans-serif; padding: 20px; background: #f5f7fa; border-radius: 10px; max-width: 600px; margin: auto; box-shadow: 0 4px 10px rgba(0,0,0,0.1);\">\n" +
                    "    <h2 style=\"color: #4CAF50;\">Xin chào, <span style=\"color: #333;\">" + userName + "</span> 🎉</h2>\n" +
                    "    <p style=\"font-size: 16px; color: #555;\">\n" +
                    "        Bạn đã <strong>đăng nhập thành công</strong> vào hệ thống của chúng tôi.\n" +
                    "    </p>\n" +
                    "    <p style=\"font-size: 16px; color: #555;\">\n" +
                    "        Chúc bạn có một trải nghiệm tuyệt vời! 🚀\n" +
                    "    </p>\n" +
                    "    <hr style=\"margin: 20px 0;\">\n" +
                    "    <p style=\"font-size: 14px; color: #777;\">\n" +
                    "        👉 Nếu không phải bạn thực hiện hành động này, vui lòng liên hệ ngay với đội ngũ hỗ trợ để được giúp đỡ.\n" +
                    "    </p>\n" +
                    "</div>";

            helper.setText(content, true);

            mailSender.send(message);
            System.out.println("Email đăng nhập thành công đã được gửi đến " + recipientEmail);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public String formatCurrency(double amount) {
        DecimalFormat formatter = new DecimalFormat("###,###,### VNĐ");
        return formatter.format(amount);
    }
    public void sendOrderSuccessEmail(String recipientEmail, String userName, Order order, List<OrderProduct> orderProducts) {
        StringBuilder productsContent = new StringBuilder();
        for (OrderProduct item : orderProducts) {
            productsContent.append("<tr>")
                    .append("<td style='padding: 10px; border-bottom: 1px solid #dee2e6;'>")
                    .append(item.getProduct().getName())
                    .append("</td>")
                    .append("<td style='padding: 10px; text-align: center; border-bottom: 1px solid #dee2e6;'>")
                    .append(item.getQuantity())
                    .append("</td>")
                    .append("<td style='padding: 10px; text-align: right; border-bottom: 1px solid #dee2e6;'>")
                    .append(formatCurrency(item.getPrice()))
                    .append("</td>")
                    .append("</tr>");
        }
        try {
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            helper.setFrom("iphoneserversendemail@gmail.com", "IPhone Shop");
            helper.setTo(recipientEmail);
            helper.setSubject("Đặt hàng thành công");
            String content = "<div style=\"font-family: Arial, sans-serif; padding: 20px; background: #f5f7fa; border-radius: 10px; max-width: 600px; margin: auto; box-shadow: 0 4px 10px rgba(0,0,0,0.1);\">\n" +
                    "    <h2 style=\"color: #4CAF50;\">Xin chào, <span style=\"color: #333;\">" + userName + "</span>! </h2>\n" +
                    "    <p style=\"font-size: 16px; color: #555;\">\n" +
                    "        Cảm ơn bạn đã đặt hàng tại cửa hàng chúng tôi. Đơn hàng của bạn đã được xác nhận! ✅\n" +
                    "    </p>\n" +
                    "    <div style=\"background: white; padding: 15px; border-radius: 8px; margin: 20px 0;\">\n" +
                    "        <h3 style=\"color: #333; margin-top: 0;\">Chi tiết đơn hàng:</h3>\n" +
                    "        <table style=\"width: 100%; border-collapse: collapse;\">\n" +
                    "            <tr style=\"background: #f8f9fa;\">\n" +
                    "                <th style=\"padding: 10px; text-align: left; border-bottom: 2px solid #dee2e6;\">Sản phẩm</th>\n" +
                    "                <th style=\"padding: 10px; text-align: center; border-bottom: 2px solid #dee2e6;\">Số lượng</th>\n" +
                    "                <th style=\"padding: 10px; text-align: right; border-bottom: 2px solid #dee2e6;\">Giá</th>\n" +
                    "            </tr>\n" +
                    productsContent +
                    "        </table>\n" +
                    "        <hr style=\"margin: 15px 0;\">\n" +
                    "        <p style=\"text-align: right; font-size: 18px; color: #d32f2f; font-weight: bold;\">\n" +
                    "            Tổng cộng: " + formatCurrency(order.getTotalPrice()) + "\n" +
                    "        </p>\n" +
                    "    </div>\n" +
                    "    <p style=\"font-size: 14px; color: #777;\">\n" +
                    "        📦 Đơn hàng sẽ được giao trong vòng 2-3 ngày làm việc. <br>\n" +
                    "        📞 Liên hệ ngay nếu có thắc mắc: <span style=\"color: #4CAF50;\">0385096604</span>\n" +
                    "    </p>\n" +
                    "    <hr style=\"margin: 20px 0;\">\n" +
                    "    <p style=\"font-size: 12px; color: #999; text-align: center;\">\n" +
                    "        Cảm ơn bạn đã tin tưởng chúng tôi!\n" +
                    "    </p>\n" +
                    "</div>";

            helper.setText(content, true);

            mailSender.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
