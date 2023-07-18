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
<c:set var="newsImage" value="${currentNode.properties.image}"/>
<jcr:nodeProperty node="${currentNode}" name="date" var="newsDate"/>
<jcr:nodeProperty node="${currentNode}" name='jcr:uuid' var="uuid"/>


<div class="card mb-3" id="${uuid}">
    <c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>
    <img src="${imageUrl}" class="card-img" alt="${fn:escapeXml(newsTitle)}" style="max-height:200px;filter: brightness(50%);">

    <div class="" >
        <h6 class="card-title text-white text-img-overlay">${fn:escapeXml(newsTitle.string)}</h6>
        <p class="card-text mt-auto" style="position: absolute; top: 165px; right: 10px; text-align: right;"><small class="text-white"><fmt:formatDate value="${newsDate.date.time}"
                                                                       pattern="MMM dd, yyyy"/></small></p>
    </div>

    <div class="card-body">
        <p class="card-text" style="line-height:1.2">${functions:abbreviate(functions:removeHtmlTags(currentNode.properties.desc.string),100,150,'...')}</p>
        <a href="<c:url value='${url.base}${currentNode.path}.html'/>" class="btn btn-outline-primary btn-sm"
           style="float:right">Read More</a>
    </div>


</div>


