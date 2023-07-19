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

<template:addResources type="css" resources="newsCarousel.css"/>
<template:addResources type="css" resources="owl.carousel.css"/>
<template:addResources type="css" resources="owl.theme.default.css"/>
<template:addResources type="javascript" resources="owl.carousel.js"/>

<c:set var="siteNode" value="${renderContext.site}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<jcr:nodeProperty node="${currentNode}" name="bannerText" var="bannerText"/>
<jcr:nodeProperty node="${currentNode}" name="maxNews" var="maxNews"/>
<jcr:nodeProperty node="${currentNode}" name="filter" var="filter"/>

<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random() * 10000) %>
</c:set>
<c:set var="carouselId" value="carousel-${rand}"/>
<%-- get the child items --%>

<c:choose>
    <c:when test="${empty filter.string}">
        <c:set var="queryNewsStatement" value="select * from [jnt:news] as news where ISDESCENDANTNODE(news,'${currentNode.resolveSite.path}') order by news.[date] desc "/>
    </c:when>
    <c:otherwise>
        <c:set var="queryNewsStatement" value="select * from [jnt:news] as news where ISDESCENDANTNODE(news,'${currentNode.resolveSite.path}') and news.[j:defaultCategory]='${filter.string}' order by news.[date] desc"/>
    </c:otherwise>
</c:choose>
<jcr:sql var="newsList"
         sql="${queryNewsStatement}"
         limit="${maxNews.long}"/>


<div class="container-fluid pb-4 pt-5">
    <div class="container">
        <div>
            <div class="fh5co_heading fh5co_heading_border_bottom py-2 mb-4">${title}</div>
        </div>
        <div class="owl-carousel owl-theme animated" id="${carouselId}">
            <c:forEach items="${newsList.nodes}" var="news" varStatus="status">
                <jcr:nodeProperty node="${news}" var="newsCategories" name="j:defaultCategory"/>

                <!-- category -->
                <c:set var="myVar" value="" />
                <c:if test="${!empty newsCategories }">
                    <c:forEach items="${newsCategories}" var="category">
                        <c:set var="myVar" value="${myVar} ${category.node.displayableName}" />
                    </c:forEach>
                </c:if>
                <c:set var="mediaNode" value="${currentNode.properties['image'].node}"/>
                <%@ include file="../../getMediaURL.jspf" %>
                <c:set var="imageUrl" value="${mediaURL}"/>
                <template:addCacheDependency node="${mediaNode}"/>
            <div class="item px-2">
                <div class="fh5co_hover_news_img">
                    <div class="fh5co_news_img"><img src="${imageUrl}" alt=""/></div>
                    <div>
                        <a href="${url.base}${news.path}.html" class="d-block fh5co_small_post_heading"><span class="">${news.properties['jcr:title'].string}</span></a>
                        <div class="c_g"><i class="fa fa-calendar-check-o" aria-hidden="true"></i> <small class="text-muted"><fmt:formatDate value="${news.properties['date'].time}" pattern="MMM dd, yyyy"/></small></div>
                    </div>
                </div>
            </div>
            </c:forEach>
        </div>
    </div>
</div>


<script>
    $('#${carouselId}').owlCarousel({
        loop: true,
        margin: 10,
        dots: true,
        nav: true,
        autoplay: true,
        navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        animateOut: 'slideOutDown',
        animateIn: 'flipInX',
        responsive: {
            0: {
                items: 1
            },
            600: {
                items: 2
            },
            1000: {
                items: 3
            }
        }
    });
</script>




<c:if test="${renderContext.editMode}">
    <%--
    As only one child type is defined no need to restrict
    if a new child type is added restriction has to be done
    using 'nodeTypes' attribute
    --%>
    <template:module path="*" />
</c:if>