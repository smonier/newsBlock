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


<jcr:nodeProperty node="${currentNode}" name="image" var="newsImage"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="newsTitle"/>
<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="Categories"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:uuid" var="uuid"/>
<jcr:nodeProperty node="${currentNode}" name="j:tagList" var="newsTags"/>

<c:set var="myCat" value=""/>
<c:if test="${!empty Categories }">
    <c:forEach items="${Categories}" var="category">
        <c:set var="myCat" value="${myCat} ${category.node.name}"/>
    </c:forEach>
</c:if>
<c:set var="myTags" value=""/>
<c:if test="${!empty newsTags }">
    <c:forEach items="${newsTags}" var="tag">
        <c:set var="myTags" value="${myTags} ${tag.string}"/>
    </c:forEach>
</c:if>

<div class="card w-100 mh-50 ${myTags} ${myCat}">
    <c:if test="${not empty newsImage}">
        <c:set var="mediaNode" value="${currentNode.properties['image'].node}"/>
        <%@ include file="../../getMediaURL.jspf" %>
        <c:set var="imageUrl" value="${mediaURL}"/>
        <template:addCacheDependency node="${mediaNode}"/>        <img class="card-img-top" src="${url.files}${newsImage.node.path}" alt="${newsTitle}">
    </c:if>
    <div class="card-img-overlay h-100 d-flex flex-column justify-content-end bg-light text-dark opacity-3">
        <div class="card-body">
            <h5 class="card-title">${fn:escapeXml(newsTitle.string)}</h5>
            <p class="card-text">${functions:abbreviate(functions:removeHtmlTags(currentNode.properties.desc.string),400,450,'...')}</p>
        </div>
    </div>
</div>