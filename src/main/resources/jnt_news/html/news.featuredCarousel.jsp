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


<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="newsTitle"/>
<jcr:nodeProperty node="${currentNode}" name="desc" var="newsBody"/>
<jcr:nodeProperty node="${currentNode}" name="date" var="newsDate"/>
<jcr:nodeProperty node="${currentNode}" name="featuredNews" var="featuredNews"/>
<jcr:nodeProperty node="${currentNode}" name="image" var="newsImage"/>


<div class="card border-0 rounded-0 text-light overflow zoom">
    <div class="position-relative">
        <!--thumbnail img-->
        <div class="ratio_left-cover-1 image-wrapper">
            <c:if test="${not empty newsImage}">
                <jahia:addCacheDependency node="${newsImage.node}" />
                <c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>
                <img class="img-fluid w-100" src="${imageUrl}" alt="${newsTitle.string}">
            </c:if>
        </div>
        <div class="position-absolute p-2 p-lg-3 b-0 w-100 bg-shadow">
            <!--title-->
            <a href="<c:url value='${url.base}${currentNode.path}.html'/>">
                <h2 class="h3 post-title text-white my-1">${newsTitle}</h2>
            </a>
            <!-- meta title -->
            <div class="news-meta">
              <i class="fa fa-calendar-check-o" aria-hidden="true"></i> <small class="text-muted"><fmt:formatDate value="${newsDate.date.time}" pattern="MMM dd, yyyy"/></small>
            </div>
        </div>
    </div>
</div>

