package com.example.qlst.servlet;

import com.example.qlst.dao.ProductDAO;
import com.example.qlst.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.isBlank()) {
            try {
                int id = Integer.parseInt(idParam);
                Product product = productDAO.getProductsDetail(id);
                if (product == null) {
                    request.setAttribute("error", "Không tìm thấy sản phẩm ID=" + id);
                } else {
                    request.setAttribute("product", product);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID không hợp lệ: " + idParam);
            }
            request.getRequestDispatcher("WarehouseStaff/ProductDetail.jsp").forward(request, response);
            return; // tránh forward lần 2
        }

        String q = request.getParameter("q");
        List<Product> products = (q == null)
                ? java.util.Collections.emptyList()
                : productDAO.getProducts(q);

        request.setAttribute("q", q);
        request.setAttribute("products", products);
        request.getRequestDispatcher("WarehouseStaff/SearchProduct.jsp").forward(request, response);

    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (!"update".equalsIgnoreCase(action)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Unsupported action");
            return;
        }

        // Đọc form
        int id = 0, stock = 0;
        double unitPrice = 0d;
        try { id = Integer.parseInt(request.getParameter("id")); } catch (Exception ignored) {}
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        try { stock = Integer.parseInt(request.getParameter("stockQuantity")); } catch (Exception ignored) {}
        try { unitPrice = Double.parseDouble(request.getParameter("unitPrice")); } catch (Exception ignored) {}

        // Validate cơ bản
        if (id <= 0 || name == null || name.isBlank() || stock < 0 || unitPrice < 0) {
            request.setAttribute("error", "Dữ liệu không hợp lệ");
            request.setAttribute("product", productDAO.getProductsDetail(id));
            request.setAttribute("openEdit", true); // bật form khi render lại
            request.getRequestDispatcher("WarehouseStaff/ProductDetail.jsp").forward(request, response);
            return;
        }

        // Map sang model (model dùng price ↔ DB là unitPrice trong DAO)
        Product p = new Product();
        p.setId(id);
        p.setName(name.trim());
        p.setType(type != null ? type.trim() : null);
        p.setStockQuantity(stock);
        p.setPrice(unitPrice);

        boolean ok = productDAO.saveProduct(p); // UPDATE ... unitPrice=? WHERE id=?

        if (ok) {
            // PRG pattern
            response.sendRedirect(request.getContextPath() + "/product?id=" + id);
        } else {
            request.setAttribute("error", "Cập nhật thất bại");
            request.setAttribute("product", productDAO.getProductsDetail(id));
            request.setAttribute("openEdit", true);
            request.getRequestDispatcher("WarehouseStaff/ProductDetail.jsp").forward(request, response);
        }
    }
}
