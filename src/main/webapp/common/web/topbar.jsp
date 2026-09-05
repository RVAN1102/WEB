<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .topbar {
        background-color: #212529;
        padding: 10px 24px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.08);
    }
    .topbar ul {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: flex-end;
        align-items: center;
        gap: 20px;
    }
    .topbar ul li {
        color: #e9ecef;
        font-size: 14px;
        font-family: Arial, sans-serif;
    }
    .topbar ul li b {
        color: #fff;
    }
    .topbar ul li a {
        color: #0dcaf0;
        text-decoration: none;
        font-weight: 500;
        transition: color 0.2s ease;
    }
    .topbar ul li a:hover {
        color: #ffffff;
        text-decoration: underline;
    }
</style>

<div class="topbar">
    <c:choose>
        <%-- Chưa đăng nhập -> Hiện nút Đăng nhập / Đăng ký --%>
        <c:when test="${sessionScope.account == null}">
            <ul>
                <li><a href="<c:url value='/'/>">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/login">Đăng nhập</a></li>
                <li><a href="${pageContext.request.contextPath}/register">Đăng ký</a></li>
            </ul>
        </c:when>

        <%-- Đã đăng nhập -> Hiện Tên người dùng, Trang chủ, Hồ sơ & Nút Đăng xuất --%>
        <c:otherwise>
            <ul>
                <li>Xin chào, <b>${sessionScope.account.fullName}</b></li>
                <li><a href="<c:url value='/waiting'/>">Trang chủ</a></li>
                <li><a href="<c:url value='/myprofile'/>">Hồ sơ cá nhân</a></li>
                <li><a href="${pageContext.request.contextPath}/logout">Đăng xuất</a></li>
            </ul>
        </c:otherwise>
    </c:choose>
</div>