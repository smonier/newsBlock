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
<template:addResources type="javascript" resources="filter.js"/>

<script src="https://unpkg.com/isotope-layout@3.0.3/dist/isotope.pkgd.js"></script>


<c:set var="siteNode" value="${renderContext.site}"/>
<c:set var="title" value="${currentNode.properties['jcr:title'].string}"/>
<jcr:nodeProperty node="${currentNode}" name="bannerText" var="bannerText"/>
<jcr:nodeProperty node="${currentNode}" name="maxnews" var="maxnews"/>
<jcr:nodeProperty node="${currentNode}" name="filter" var="filter"/>


<%-- get the child items --%>

<c:choose>
    <c:when test="${empty filter.string}">
        <c:set var="querynewsStatement"
               value="select * from [jnt:news] as news where ISDESCENDANTNODE(news,'${currentNode.resolveSite.path}') order by news.[date] desc "/>
    </c:when>
    <c:otherwise>
        <c:set var="querynewsStatement"
               value="select * from [jnt:news] as news where ISDESCENDANTNODE(news,'${currentNode.resolveSite.path}') and news.[j:defaultCategory]='${filter.string}' order by news.[date] desc"/>
    </c:otherwise>
</c:choose>
<jcr:sql var="newsList"
         sql="${querynewsStatement}"
         limit="${maxnews.long}"/>


<!-- Portfolio Grid Section -->

<div class="animate-grid">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2 class="section-heading">${title}</h2>
                <h3 class="section-subheading text-muted">${bannerText}</h3>
            </div>
        </div>
        <div class="row">
            <div class="col-3">

                <div class="card categories">
                    <div class="card-body">
                        <h5 class="card-title">Categories</h5>
                        <ul class="list-menu">
                            <li><a href="#" data-filter="*">All</a></li>


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
                                    document.write('<li><a href="#" data-filter=".' + uniqueCategories[j] + '">' + uniqueCategories[j] + '<span class="badge badge-pill badge-light float-right">' + countInArray(categories, uniqueCategories[j]) + '</span></a></li>');
                                }
                            </script>

                            <h5 class="card-title mt-4">Tags</h5>

                            <script language="JavaScript">
                                var tags = [];
                                <c:forEach items="${newsList.nodes}" var="news" varStatus="status">
                                <jcr:nodeProperty node="${news}" var="newsTags" name="j:tagList"/>
                                <c:if test="${!empty newsTags}">
                                <c:forEach items="${newsTags}" var="tag">
                                tags.push("${tag.string}");
                                </c:forEach>
                                </c:if>
                                </c:forEach>
                                var uniqueTags = [];
                                $.each(tags, function (i, el) {
                                    if ($.inArray(el, uniqueTags) === -1) uniqueTags.push(el);
                                });

                                for (var j = 0; j < uniqueTags.length; j++) {
                                    document.write('<li><a href="#" data-filter=".' + uniqueTags[j] + '" style="text-transform: capitalize;">' + uniqueTags[j] + '<span class="badge badge-pill badge-light float-right">' + countInArray(tags, uniqueTags[j]) + '</span></a></li>');
                                }
                            </script>
                        </ul>
                    </div>
                </div> <!-- card.// -->

            </div>
            <div class="col-9">
                <div class="card-deck gallary-thumbs">
                    <c:forEach items="${newsList.nodes}" var="news" varStatus="status">
                        <template:module node="${news}" view="card"/>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</div>

<c:if test="${renderContext.editMode}">
    <%--
    As only one child type is defined no need to restrict
    if a new child type is added restriction has to be done
    using 'nodeTypes' attribute
    --%>
    <template:module path="*"/>
</c:if>