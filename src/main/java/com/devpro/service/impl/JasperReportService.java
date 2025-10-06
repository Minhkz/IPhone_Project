package com.devpro.service.impl;

import com.devpro.models.Address;
import com.devpro.models.Order;
import com.devpro.models.OrderProduct;
import com.devpro.repository.OrderRepository;
import net.sf.jasperreports.engine.*;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class JasperReportService {

    public byte[] generateOrderReport(Order order, List<OrderProduct> items, Address address) throws Exception {
        // Nạp file mẫu
        InputStream reportStream = new ClassPathResource("reports/order.jrxml").getInputStream();
        JasperReport jasperReport = JasperCompileManager.compileReport(reportStream);

        // Gán tham số đơn hàng
        Map<String, Object> params = new HashMap<>();
        params.put("orderId", "DH" + order.getId());
        params.put("customerName", address.getReciverName());
        params.put("phone", address.getReciverPhone());
        params.put("address", address.getDetailDesc());
        params.put("total", order.getTotalPrice());
        params.put("status", order.getStatus());

        // Dữ liệu chi tiết sản phẩm
        JRDataSource dataSource = new JRBeanCollectionDataSource(items);

        // Fill report (đổ dữ liệu vào mẫu)
        JasperPrint print = JasperFillManager.fillReport(jasperReport, params, dataSource);

        // Xuất ra PDF
        return JasperExportManager.exportReportToPdf(print);
    }
}
