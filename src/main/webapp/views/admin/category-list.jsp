<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="referrer" content="no-referrer">
    <title>Quản lý danh mục - JPA</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f6f9; margin: 20px; }
        .card { background: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); max-width: 1000px; margin: auto; }
        .header-bar { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; border-bottom: 2px solid #e9ecef; padding-bottom: 10px; }
        .btn-add { background-color: #28a745; color: white; padding: 9px 16px; text-decoration: none; border-radius: 5px; font-weight: bold; }
        .btn-add:hover { background-color: #218838; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th, td { padding: 12px; text-align: center; border-bottom: 1px solid #dee2e6; vertical-align: middle; }
        th { background-color: #f8f9fa; color: #495057; font-weight: 600; }
        tr:hover { background-color: #f1f3f5; }
        .img-thumb { width: 80px; height: 60px; object-fit: cover; border-radius: 4px; border: 1px solid #ced4da; }
        .badge { padding: 5px 10px; border-radius: 12px; font-size: 0.85em; font-weight: bold; }
        .badge-active { background-color: #d4edda; color: #155724; }
        .badge-locked { background-color: #f8d7da; color: #721c24; }
        .btn-action { padding: 5px 10px; border-radius: 4px; text-decoration: none; font-size: 0.9em; color: white; margin: 0 2px; }
        .btn-edit { background-color: #007bff; }
        .btn-edit:hover { background-color: #0069d9; }
        .btn-delete { background-color: #dc3545; }
        .btn-delete:hover { background-color: #c82333; }
    </style>
</head>
<body>
    <%@ include file="/common/web/topbar.jsp" %>

    <div class="card">
        <div class="header-bar">
            <h2>Quản Lý Danh Mục (JPA)</h2>
            <a href="<c:url value='/admin/category/add'/>" class="btn-add">+ Thêm danh mục mới</a>
        </div>

        <table>
            <thead>
                <tr>
                    <th width="8%">STT</th>
                    <th width="20%">Hình ảnh</th>
                    <th>Tên danh mục</th>
                    <th width="15%">Trạng thái</th>
                    <th width="20%">Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${listcate}" var="cate" varStatus="STT">
                    <tr>
                        <td>${STT.index + 1}</td>
                        <td>
							<c:choose>
							    <c:when test="${empty cate.images}">
							        <img class="img-thumb" src="https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80" alt="No Image" />
							    </c:when>
							    <c:when test="${cate.images.startsWith('http')}">
							        <img class="img-thumb" src="${cate.images}" alt="${cate.categoryname}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80';" />
							    </c:when>
							    <c:otherwise>
							        <c:url value="/image?fname=${cate.images}" var="imgUrl"/>
							        <img class="img-thumb" src="${imgUrl}" alt="${cate.categoryname}" onerror="this.onerror=null; this.src='https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?w=500&q=80';" />
							    </c:otherwise>
                            </c:choose>
                        </td>
                        <td><strong>${cate.categoryname}</strong></td>
                        <td>
                            <c:choose>
                                <c:when test="${cate.status == 1}">
                                    <span class="badge badge-active">Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-locked">Khóa</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="<c:url value='/admin/category/edit?id=${cate.categoryid}'/>" class="btn-action btn-edit">Sửa</a>
                            <a href="<c:url value='/admin/category/delete?id=${cate.categoryid}'/>" class="btn-action btn-delete" onclick="return confirm('Bạn chắc chắn muốn xóa?');">Xóa</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>