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





<div class="card mb-3">
    <div class="row no-gutters">
        <div class="col-md-6">
            <c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>

            <a href="<c:url value='${url.base}${currentNode.path}.html'/>">
                <img class="img-fluid" src="${imageUrl}" alt=${fn:escapeXml(newsTitle)}">
            </a>
        </div>
        <div class="col-md-6">
            <div class="card-body">
                <h5 class="card-text text-primary">${fn:escapeXml(newsTitle.string)}</h5>
                <p class="card-text small">${functions:abbreviate(functions:removeHtmlTags(currentNode.properties.desc.string),200,250,'...')}</p>
                <i class="fa fa-calendar-check-o" aria-hidden="true"></i> <small class="text-muted"><fmt:formatDate value="${newsDate.date.time}" pattern="MMM dd, yyyy"/></small>
                <a href="<c:url value='${url.base}${currentNode.path}.html'/>" class="btn btn-outline-primary mb-3 btn-sm"
                   style="float:right">READ MORE</a>
            </div>
        </div>
    </div>
</div>
