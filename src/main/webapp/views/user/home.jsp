<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Mua Sắm - Khách Hàng</title>
    <style>
        :root {
            --primary-color: #007bff;
            --bg-color: #f8f9fa;
            --text-color: #333;
            --card-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        
        body { 
            font-family: 'Inter', 'Segoe UI', Tahoma, sans-serif; 
            background-color: var(--bg-color); 
            color: var(--text-color);
            margin: 0;
            padding: 20px;
        }

        .container { max-width: 1200px; margin: 0 auto; }

        .category-container { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr)); 
            gap: 24px; 
            margin-top: 30px; 
        }

        .category-card { 
            background: #fff; 
            border: none;
            border-radius: 12px; 
            padding: 20px; 
            text-align: center; 
            box-shadow: var(--card-shadow);
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            cursor: pointer;
            overflow: hidden;
        }

        .category-card:hover { 
            transform: translateY(-8px); 
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }

        .category-card img { 
            width: 100%; 
            height: 140px; 
            object-fit: cover; 
            border-radius: 8px; 
            margin-bottom: 12px;
            transition: transform 0.5s ease;
        }
        
        .category-card:hover img { transform: scale(1.05); }

        .category-card h4 { 
            margin: 0; 
            font-weight: 600;
            font-size: 1.1rem;
            color: #2d3436;
        }

        h2 { font-weight: 700; color: #1a1a1a; margin-bottom: 8px; }
        h3 { color: #636e72; font-weight: 500; font-size: 1.2rem; }
        hr { border: 0; height: 1px; background: #e0e0e0; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="container">
        <%@ include file="/common/web/topbar.jsp" %>
        
        <h2>Chào mừng bạn đến với không gian mua sắm!</h2>
        <h3>Khám phá các danh mục nổi bật nhất hôm nay</h3>
        <hr/>
        
        <div class="category-container">
            <c:forEach items="${cateList}" var="cate">
                <c:if test="${cate.status == 1}">
                    <div class="category-card">
                        <c:choose>
                            <c:when test="${empty cate.images}">
                                <img src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='180' height='140' viewBox='0 0 180 140'><rect width='180' height='140' fill='%23e9ecef'/><text x='50%' y='50%' dominant-baseline='middle' text-anchor='middle' font-family='sans-serif' font-size='12' fill='%236c757d'>No Image</text></svg>" alt="No Image" />
                            </c:when>
                            <c:when test="${cate.images.startsWith('http')}">
                                <img src="${cate.images}" alt="${cate.categoryname}" />
                            </c:when>
                            <c:otherwise>
                                <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
                                <img src="${imgUrl}" alt="${cate.categoryname}" />
                            </c:otherwise>
                        </c:choose>
                        <h4>${cate.categoryname}</h4>
                    </div>
                </c:if>
            </c:forEach>
        </div>
    </div>
</body>
</html>