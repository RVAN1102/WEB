<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="topbar">
    <c:choose>
        <%-- Chưa đăng nhập -> Hiện nút Đăng nhập / Đăng ký --%>
        <c:when test="${sessionScope.account == null}">
            <ul>
                <li><a href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                <li><a href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
            </ul>
        </c:when>

        <%-- Đã đăng nhập -> Hiện Tên người dùng & Nút Đăng xuất --%>
        <c:otherwise>
            <ul>
                <li>Xin chào, <b>${sessionScope.account.fullName}</b></li>
                <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
            </ul>
        </c:otherwise>
    </c:choose>
</div>