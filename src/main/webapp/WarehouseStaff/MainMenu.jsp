<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hệ thống quản lý siêu thị điện máy</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: rgb(232, 232, 232);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .header {
            background: linear-gradient(90deg, #5e72e4 0%, #825ee4 100%);
            color: white;
            padding: 15px 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .header h1 {
            font-size: 18px;
            font-weight: 500;
        }

        .container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        .home-link {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            color: #333;
            text-decoration: none;
            font-size: 16px;
            margin-bottom: 30px;
            padding: 12px;
            border-radius: 8px;
            transition: background-color 0.3s;
        }

        .home-link:hover {
            background-color: #f5f5f5;
        }

        .home-icon {
            font-size: 20px;
        }

        .btn {
            background: linear-gradient(90deg, #5e72e4 0%, #825ee4 100%);
            color: white;
            border: none;
            padding: 14px 30px;
            border-radius: 8px;
            font-size: 15px;
            cursor: pointer;
            width: 100%;
            transition: transform 0.2s, box-shadow 0.2s;
            box-shadow: 0 4px 15px rgba(94, 114, 228, 0.3);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(94, 114, 228, 0.4);
        }

        .btn:active {
            transform: translateY(0);
        }
    </style>
</head>
<body>
<div class="header">
    <h1>Hệ thống quản lý siêu thị điện máy</h1>
</div>

<div class="container">
    <div class="card">
        <a  class="home-link">
            <span>Giao diện chính</span>
        </a>

        <a href="${pageContext.request.contextPath}/WarehouseStaff/SearchProduct.jsp" class="home-link">
            <button type="button" class="btn">Sửa thông tin mặt hàng</button>
        </a>

    </div>
</div>
</body>
</html>