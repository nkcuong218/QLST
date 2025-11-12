<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.qlst.model.Product" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thông tin sản phẩm</title>
  <style>
    :root {
      --primary-start: #4f46e5; --primary-end: #06b6d4; --text-main: #111827; --text-sub: #6b7280;
      --border: #e5e7eb; --bg: #f8fafc; --white: #ffffff; --btn: #4f46e5; --btn-hover: #4338ca;
      --purple: #825ee4; --purple-hover: #6d4dd4;
    }
    * { box-sizing: border-box; }
    html, body { height: 100%; }
    body { margin: 0; font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji"; color: var(--text-main); background: var(--bg); }
    .app-bar { background: linear-gradient(90deg, var(--primary-start), var(--primary-end)); color: var(--white); padding: 12px 20px; font-weight: 600; border-bottom-left-radius: 8px; border-bottom-right-radius: 8px; box-shadow: 0 2px 6px rgba(0,0,0,0.08); }
    .container { max-width: 900px; margin: 24px auto; padding: 0 16px; }
    .card { background: var(--white); border: 1px solid var(--border); border-radius: 10px; box-shadow: 0 4px 14px rgba(15,23,42,0.06); padding: 24px; position: relative; }
    .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid var(--border); }
    .card-title { margin: 0; font-size: 20px; font-weight: 600; color: var(--text-main); }
    .btn-edit { display: inline-flex; align-items: center; gap: 6px; padding: 8px 16px; background: var(--purple); color: var(--white); border: none; border-radius: 8px; font-weight: 600; font-size: 14px; cursor: pointer; transition: background 0.2s; text-decoration: none; }
    .btn-edit:hover { background: var(--purple-hover); }
    .product-info { display: flex; flex-direction: column; gap: 16px; }
    .info-row { display: grid; grid-template-columns: 180px 1fr; gap: 16px; align-items: start; padding: 12px 0; border-bottom: 1px solid var(--border); }
    .info-row:last-child { border-bottom: none; }
    .info-label { font-weight: 600; color: var(--text-sub); font-size: 14px; }
    .info-value { color: var(--text-main); font-size: 14px; }
    .info-value.price { font-weight: 600; color: var(--primary-start); }
    @media (max-width: 640px) { .info-row { grid-template-columns: 1fr; gap: 4px; } .card-header { flex-direction: column; align-items: flex-start; gap: 12px; } }
    /* Toggle edit */
    .hidden { display: none; }
    .edit-on .view-only { display: none; }
    .edit-on .edit-only { display: block; }
    .input { width: 100%; height: 38px; padding: 0 12px; border: 1px solid var(--border); border-radius: 8px; background: #fafafa; outline: none; }
    .input:focus { border-color: #c7d2fe; box-shadow: 0 0 0 3px rgba(79,70,229,0.15); background: var(--white); }
  </style>

  <script>
    function enableEdit() {
      document.getElementById('card').classList.add('edit-on');
    }
    function cancelEdit(ctxPath, id) {
      // Reload lại về chế độ xem (không lưu)
      window.location.href = ctxPath + "/product?id=" + id;
    }
    // Mở form nếu server yêu cầu (khi validation lỗi)
    window.addEventListener('DOMContentLoaded', function () {
      var openEdit = "<%= String.valueOf(request.getAttribute("openEdit")) %>";
      if (openEdit != null && openEdit !== "null" && openEdit !== "false") {
        enableEdit();
      }
    });
  </script>
</head>
<body>
<div class="app-bar">Hệ thống quản lý siêu thị điện máy</div>
<div class="container">
  <div id="card" class="card">
    <div class="card-header">
      <h2 class="card-title">Thông tin sản phẩm</h2>
      <%
        Product product = (Product) request.getAttribute("product");
        String ctx = request.getContextPath();
      %>
      <div>
        <!-- Nút Chỉnh sửa (chỉ hiện khi chế độ xem) -->
        <button type="button" class="btn-edit view-only" onclick="enableEdit()" <%= (product==null)?"disabled":"" %>>Chỉnh sửa</button>
        <!-- Nút Hủy (chỉ hiện khi chế độ edit) -->
        <button type="button" class="btn-edit edit-only hidden" style="background:#6b7280;"
                onclick="cancelEdit('<%= ctx %>', <%= product!=null?product.getId():0 %>)">Hủy</button>
      </div>
    </div>

    <div class="product-info">
      <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
      %>
      <div class="info-row">
        <div class="info-value" style="color:#dc2626;"><%= error %></div>
      </div>
      <%
        }
        if (product != null) {
      %>

      <!-- ===== CHẾ ĐỘ XEM ===== -->
      <div class="view-only">
        <div class="info-row">
          <div class="info-label">Mã hàng:</div>
          <div class="info-value">MH<%= String.format("%03d", product.getId()) %></div>
        </div>
        <div class="info-row">
          <div class="info-label">Tên:</div>
          <div class="info-value"><%= product.getName() != null ? product.getName() : "" %></div>
        </div>
        <div class="info-row">
          <div class="info-label">Giá:</div>
          <div class="info-value price"><%= String.format("%,.0f", product.getPrice()) %> VNĐ</div>
        </div>
        <div class="info-row">
          <div class="info-label">Số lượng tồn kho:</div>
          <div class="info-value"><%= product.getStockQuantity() %></div>
        </div>
        <div class="info-row">
          <div class="info-label">Loại:</div>
          <div class="info-value"><%= (product.getType()!=null && !product.getType().isEmpty()) ? product.getType() : "Chưa có mô tả" %></div>
        </div>
      </div>

      <!-- ===== CHẾ ĐỘ SỬA (FORM) ===== -->
      <form class="edit-only hidden" method="post" action="<%= ctx %>/product?action=update">
        <input type="hidden" name="id" value="<%= product.getId() %>"/>

        <div class="info-row">
          <div class="info-label">Mã hàng:</div>
          <div class="info-value">MH<%= String.format("%03d", product.getId()) %></div>
        </div>

        <div class="info-row">
          <label class="info-label" for="name">Tên:</label>
          <div class="info-value">
            <input class="input" type="text" id="name" name="name" required
                   value="<%= product.getName()!=null ? product.getName() : "" %>"/>
          </div>
        </div>

        <div class="info-row">
          <label class="info-label" for="unitPrice">Giá (VNĐ):</label>
          <div class="info-value">
            <input class="input" type="number" id="unitPrice" name="unitPrice" min="0" step="0.01"
                   value="<%= String.format("%.0f", product.getPrice()) %>" required/>
          </div>
        </div>

        <div class="info-row">
          <label class="info-label" for="stockQuantity">Số lượng tồn kho:</label>
          <div class="info-value">
            <input class="input" type="number" id="stockQuantity" name="stockQuantity" min="0"
                   value="<%= product.getStockQuantity() %>" required/>
          </div>
        </div>

        <div class="info-row">
          <label class="info-label" for="type">Loại:</label>
          <div class="info-value">
            <input class="input" type="text" id="type" name="type"
                   value="<%= product.getType()!=null ? product.getType() : "" %>"/>
          </div>
        </div>

        <div class="info-row" style="display:flex; gap:10px; border-bottom:none;">
          <button type="submit" class="btn-edit">Lưu</button>
          <button type="button" class="btn-edit" style="background:#6b7280;"
                  onclick="cancelEdit('<%= ctx %>', <%= product.getId() %>)">Hủy</button>
        </div>
      </form>

      <%
      } else {
      %>
      <div class="info-row">
        <div class="info-value">Không tìm thấy thông tin sản phẩm</div>
      </div>
      <%
        }
      %>
    </div>
  </div>
</div>
</body>
</html>
