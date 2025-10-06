package com.devpro.controller;

import com.devpro.models.Address;
import com.devpro.models.CartProduct;
import com.devpro.models.Order;
import com.devpro.models.OrderProduct;
import com.devpro.repository.OrderRepository;
import com.devpro.service.impl.JasperReportService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class ReportController {
    @Autowired
    private JasperReportService reportService;

    @Autowired
    private OrderRepository orderRepository;

    @GetMapping("/report/order/{id}")
    public void exportOrder(@PathVariable("id") int id, HttpServletResponse response) throws Exception {
        Order order = orderRepository.findById(id).get();
        if (order != null) {
            Address  address = order.getAddress();
            List<OrderProduct> orserProducts = order.getOrderProducts();
            byte[] pdfBytes = reportService.generateOrderReport(order, orserProducts, address);
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=order_" + id + ".pdf");
            response.getOutputStream().write(pdfBytes);
        }
    }
}
