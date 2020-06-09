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
<jcr:nodeProperty node="${currentNode}" name="date" var="newsDate"/>
<jcr:nodeProperty node="${currentNode}" name="desc" var="newsDesc"/>
<jcr:nodeProperty node="${currentNode}" name="image" var="newsImage"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:lastModifiedBy" var="lastAuthor"/>

<jcr:nodeProperty node="${currentNode}" var="newsCategories" name="j:defaultCategory"/>
<c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>
<jahia:addCacheDependency node="${newsImage.node}" />

<div class="card mt-3 mb-3">
  <h2 class="card-title ml-3">${fn:escapeXml(newsTitle.string)}</h2>
  <div class="card-text ml-3">



        <div class="newsMeta">
          <i class="fa fa-user-circle" aria-hidden="true"></i> <small class="text-muted">by ${lastAuthor}</small> &nbsp;&nbsp;
           <!-- <span class="categoryLabel"><fmt:message key='label.categories'/> :</span> -->
              <c:if test="${!empty newsCategories }">
            <jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="cat"/>
            <c:if test="${cat != null}">
                <c:forEach items="${cat}" var="category">
                  <i class="fa fa-tag" aria-hidden="true"></i>  <small class="text-muted"><span class="categorytitle">${category.node.displayableName} </span></small>
                </c:forEach>

            </c:if>
                </c:if>
          	 &nbsp;&nbsp;<i class="fa fa-calendar-check-o" aria-hidden="true"></i> <small class="text-muted"><fmt:formatDate value="${newsDate.date.time}" pattern="MMM dd, yyyy"/>&nbsp;<fmt:formatDate value="${newsDate.date.time}" pattern="HH:mm" var="dateTimeNews"/>
 			<c:if test="${dateTimeNews != '00:00'}">${dateTimeNews}</c:if></small>

        </div>
    
    </div>
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
    
    
    <p class="card-text">${newsDesc.string}</p>
    <p class="card-text">
    <c:set var="parentPage" value="${jcr:getParentOfType(renderContext.mainResource.node, 'jnt:page')}" />
    <c:choose>
        <c:when test="${not empty parentPage}">
            <c:url value='${parentPage.url}' context="/" var="action"/>
        </c:when>
        <c:otherwise>
            <c:set var="action">javascript:history.back()</c:set>
        </c:otherwise>
    </c:choose>
    <a class="btn btn-primary" href="${action}" title='<fmt:message key="backToPreviousPage"/>'>Back</a>
      </p>
  </div>
</div>


