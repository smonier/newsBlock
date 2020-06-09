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

<template:addResources type="css" resources="portfolio.css"/>
<template:addResources type="javascript" resources="filter.js"/>
<script src="https://unpkg.com/isotope-layout@3.0.3/dist/isotope.pkgd.js"></script>


<c:set var="siteNode" value="${renderContext.site}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<jcr:nodeProperty node="${currentNode}" name="bannerText" var="bannerText"/>
<jcr:nodeProperty node="${currentNode}" name="maxNews" var="maxNews"/>
<jcr:nodeProperty node="${currentNode}" name="filter" var="filters"/>

<c:forEach items="${filters}" var="catfilter" varStatus="status">
    <c:if test="${status.first}">
        <c:set var="myFilter" value="AND (" />
    </c:if>
    <c:set var="myFilter" value="${myFilter} news.[j:defaultCategory] = '${catfilter.string}'" />
    <c:choose>
        <c:when test="${status.last}">
            <c:set var="myFilter" value="${myFilter})" />
        </c:when>
        <c:otherwise>
            <c:set var="myFilter" value="${myFilter} OR " />
        </c:otherwise>
    </c:choose>
</c:forEach>

<%-- get the child items --%>

<c:choose>
    <c:when test="${empty filters}">
        <c:set var="queryNewsStatement" value="select * from [jnt:news] as news where ISDESCENDANTNODE(news,'${currentNode.resolveSite.path}') order by news.[date] desc "/>
    </c:when>
    <c:otherwise>
        <c:set var="queryNewsStatement" value="select * from [jnt:news] as news where ISDESCENDANTNODE(news,'${currentNode.resolveSite.path}') ${myFilter} order by news.[date] desc"/>
    </c:otherwise>
</c:choose>
<jcr:sql var="newsList"
         sql="${queryNewsStatement}"
         limit="${maxNews.long}"/>

<!-- Portfolio Grid Section -->
    <section id="portfolio" class="bg-light-gray">
    <div class="gallary animate-grid">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">${title}</h2>
                    <h3 class="section-subheading text-muted">${bannerText}</h3>
                </div>
            </div>
                <div class="row">
                <div class="col-xs-12 w-100">
                    <div class="categories">
                        <ul>
                            <li>
                                <ol>
                                    <li><a href="#" data-filter="*" class="btn btn-outline-primary active">All</a></li>
                                    <script language="JavaScript">
                                        var categories = [];
                                        <c:forEach items="${newsList.nodes}" var="news" varStatus="status">
                                            <jcr:nodeProperty node="${news}" var="newsCategories" name="j:defaultCategory"/>
                                            <c:if test="${!empty newsCategories}">
                                                <c:forEach items="${newsCategories}" var="category">
                                                categories.push("${category.node.displayableName}");
                                                </c:forEach>
                                            </c:if>
                                        </c:forEach>
                                        var uniqueCategories = [];
                                        $.each(categories, function (i, el) {
                                            if ($.inArray(el, uniqueCategories) === -1) uniqueCategories.push(el);
                                        });

                                        for (var j = 0; j < uniqueCategories.length; j++) {
                                            document.write('<li><a class="btn btn-primary-outline" href="#" data-filter=".'+uniqueCategories[j]+'">'+uniqueCategories[j]+'</a></li>')
                                        }
                                    </script>

                                </ol>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row gallary-thumbs">
                <c:forEach items="${newsList.nodes}" var="news" varStatus="status">
                    <jcr:nodeProperty node="${news}" var="newsCategories" name="j:defaultCategory"/>

                    <!-- category -->
                    <c:set var="myVar" value="" />
                    <c:if test="${!empty newsCategories }">
                            <c:forEach items="${newsCategories}" var="category">
                                <c:set var="myVar" value="${myVar} ${category.node.displayableName}" />
                            </c:forEach>
                    </c:if>
                    <div class="col-md-4 col-sm-6 portfolio-item ${myVar}">
                    <a href="${url.base}${news.path}.html?jsite=${siteNode.UUID}" class="portfolio-link">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="faNews fa-search-plus"></i>
                            </div>
                        </div>
                        <jcr:nodeProperty node="${news}" name="image" var="newsImage"/>

                        <c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>

                        <img src="${imageUrl}" class="img-fluid w-100" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>${news.properties['jcr:title'].string}</h4>
                        <p class="text-muted">
                            <c:set var="myVar" value="" />
                            <c:if test="${!empty newsCategories }">
                                <c:forEach items="${newsCategories}" var="category">
                                    <c:set var="myVar" value="${myVar} ${category.node.displayableName}" />
                                </c:forEach>
                            </c:if>
                            ${myVar}
                        </p>
                    </div>
                </div>

                </c:forEach>
            </div>
        </div>
    </section>

   




<c:if test="${renderContext.editMode}">
    <%--
    As only one child type is defined no need to restrict
    if a new child type is added restriction has to be done
    using 'nodeTypes' attribute
    --%>
    <template:module path="*" />
</c:if>