<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="query" uri="http://www.jahia.org/tags/queryLib" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="s" uri="http://www.jahia.org/tags/search" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<template:addResources type="css" resources="bookingCard.css"/>
<c:set var="siteNode" value="${renderContext.site}"/>
<jcr:nodeProperty node="${currentNode}" name="image" var="newsImage"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="newsTitle"/>
<jcr:nodeProperty node="${currentNode}" name="date" var="newsDate"/>
<jcr:nodeProperty node="${currentNode}" var="newsCategories" name="j:defaultCategory"/>

<c:if test="${not empty newsImage}">
    <c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>
    <c:if test="${not empty newsImage}">
        <c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>
    </c:if>
</c:if>

<ul>
    <li class="booking-card flex" style="background-image: url(${imageUrl})">
        <div class="book-container">
            <div class="content">
                <a class="btn btn-outline-primary" href="<c:url value='${url.base}${currentNode.path}.html?jsite=${siteNode.UUID}'/>"><fmt:message key='label.readmore'/></a>
            </div>
        </div>
        <div class="informations-container text-primary">
            <h2 class="title">${newsTitle}</h2>
            <c:if test="${!empty newsCategories }">
                <jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="cat"/>
                <c:if test="${cat != null}">
                    <c:forEach items="${cat}" var="category">
                        <i class="fa fa-tag" aria-hidden="true"></i> ${category.node.displayableName}&nbsp;&nbsp;
                    </c:forEach>
                </c:if>
            </c:if>

            <div class="more-information ">
                <i class="fa fa-calendar-check-o" aria-hidden="true"></i> <small class="text-muted"><fmt:formatDate value="${newsDate.date.time}" pattern="MMM dd, yyyy"/></small>
                <p class="disclaimer">${functions:abbreviate(functions:removeHtmlTags(currentNode.properties.desc.string),300,350,'...')}</p>
            </div>
        </div>
    </li>
</ul>




