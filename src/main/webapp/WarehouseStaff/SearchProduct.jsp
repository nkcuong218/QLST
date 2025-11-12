<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Redirect to servlet if accessed directly
    if (request.getAttribute("products") == null) {
        response.sendRedirect(request.getContextPath() + "/product");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm kiếm sản phẩm</title>
    <style>
        :root {
            --primary-start: #4f46e5; /* indigo-600 */
            --primary-end: #06b6d4;   /* cyan-500 */
            --text-main: #111827;     /* gray-900 */
            --text-sub: #6b7280;      /* gray-500 */
            --border: #e5e7eb;        /* gray-200 */
            --bg: #f8fafc;            /* slate-50 */
            --white: #ffffff;
            --btn: #4f46e5;
            --btn-hover: #4338ca;
        }

        * { box-sizing: border-box; }
        html, body { height: 100%; }
        body {
            margin: 0;
            font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Helvetica, Arial, "Apple Color Emoji", "Segoe UI Emoji";
            color: var(--text-main);
            background: var(--bg);
        }

        /* Top bar */
        .app-bar {
            background: linear-gradient(90deg, var(--primary-start), var(--primary-end));
            color: var(--white);
            padding: 12px 20px;
            font-weight: 600;
            border-bottom-left-radius: 8px;
            border-bottom-right-radius: 8px;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        /* Container */
        .container {
            max-width: 1060px;
            margin: 24px auto;
            padding: 0 16px;
        }

        /* Card */
        .card {
            background: var(--white);
            border: 1px solid var(--border);
            border-radius: 10px;
            box-shadow: 0 4px 14px rgba(15,23,42,0.06);
            padding: 18px;
        }

        .card h2 {
            margin: 4px 0 14px 0;
            font-size: 18px;
        }

        /* Search row */
        .search-row {
            display: grid;
            grid-template-columns: 1fr 140px;
            gap: 12px;
            margin-bottom: 14px;
        }

        .input {
            width: 100%;
            height: 38px;
            padding: 0 12px;
            border: 1px solid var(--border);
            border-radius: 8px;
            background: #fafafa;
            outline: none;
        }

        .input:focus {
            border-color: #c7d2fe; /* indigo-200 */
            box-shadow: 0 0 0 3px rgba(79,70,229,0.15);
            background: var(--white);
        }

        .btn-primary {
            height: 38px;
            border: none;
            border-radius: 8px;
            background: var(--btn);
            color: var(--white);
            font-weight: 600;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        .btn-primary:hover { background: var(--btn-hover); }

        /* Table */
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 8px;
        }
        .table th, .table td {
            padding: 10px 12px;
            border-bottom: 1px solid var(--border);
            text-align: left;
            font-size: 14px;
        }
        .table th { color: var(--text-sub); font-weight: 600; }

        .table tr:last-child td { border-bottom: none; }

        .table tbody tr {
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .table tbody tr:hover {
            background-color: rgba(79,70,229,0.06);
        }

        /* Footer actions */
        .actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 14px;
        }

        .btn-outline {
            height: 34px;
            padding: 0 16px;
            border: 1px solid var(--btn);
            color: var(--btn);
            background: transparent;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
        }
        .btn-outline:hover { background: rgba(79,70,229,0.06); }

        @media (max-width: 560px) {
            .search-row { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<div class="app-bar">Hệ thống quản lý siêu thị điện máy</div>
<div class="container">
    <div class="card">
        <h2>Tìm kiếm thông tin sản phẩm</h2>

        <form method="get" action="${pageContext.request.contextPath}/product">
            <div class="search-row">
                <input class="input" type="text" name="q" placeholder="Nhập tên sản phẩm" value="<%= request.getAttribute("q") != null ? request.getAttribute("q") : "" %>" />
                <button type="submit" class="btn-primary" aria-label="Tìm kiếm">
                    <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
                    Tìm kiếm
                </button>
            </div>
        </form>

        <table class="table">
            <thead>
            <tr>
                <th>Mã sản phẩm</th>
                <th>Tên sản phẩm</th>
            </tr>
            </thead>
            <tbody>
            <%
                java.util.List<com.example.qlst.model.Product> products = (java.util.List<com.example.qlst.model.Product>) request.getAttribute("products");
                if (products != null && !products.isEmpty()) {
                    for (com.example.qlst.model.Product p : products) {
            %>
            <%
                String q = (String) request.getAttribute("q");
                if(q==null) request.getParameter("q");
            %>
            <tr onclick="window.location.href='${pageContext.request.contextPath}/product?id=<%= p.getId() %>'">
                <td>MH<%= String.format("%03d", p.getId()) %></td>
                <td><%= p.getName() %></td>
            </tr>
            <%
                }
            }
            %>
            </tbody>
        </table>

    </div>
</div>
</body>
</html>


