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

<div class="card mb-2" style="width:100%">
  <c:if test="${not empty newsImage}">
        <jahia:addCacheDependency node="${newsImage.node}" />
        <c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>
        <div class="newsImg">
            <a href="<c:url value='${url.base}${currentNode.path}.html'/>">
                
                        <img class="card-img-top" src="${imageUrl}" alt=""${newsTitle}" width="100%">
                   
            </a>
        </div>
    </c:if>
  <div class="card-body">
    <h4 class="card-title">${fn:escapeXml(newsTitle.string)}</h4>
    <p class="card-text">${functions:abbreviate(functions:removeHtmlTags(currentNode.properties.desc.string),400,450,'...')}</p>
    <a href="<c:url value='${url.base}${currentNode.path}.html'/>" class="btn btn-primary">Learn More</a>
  </div>
</div>

