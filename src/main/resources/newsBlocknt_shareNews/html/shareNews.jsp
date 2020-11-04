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

<c:set var="bindedComponent" value="${ui:getBindedComponent(currentNode, renderContext, 'j:bindedComponent')}"/>
<c:if test="${not empty bindedComponent && jcr:isNodeType(bindedComponent, 'jnt:news, jnt:heading')}">
    <c:set var="targetProps" value="${bindedComponent.properties}"/>
    <c:set var="targetNode" value="${bindedComponent}"/>
</c:if>
<c:set var="newsTitle" value="${targetProps['jcr:title'].string}"/>

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="shareTitle"/>
<c:set value="${url.server}${targetNode.url}" var="newsUrl"/>

<c:url value="https://www.facebook.com/sharer/sharer.php" var="facebookUrl">
    <c:param name="u" value="${newsUrl}" />
</c:url>
<c:url value="https://twitter.com/intent/tweet" var="twitterUrl">
    <c:param name="text" value="${newsTitle} ${newsUrl}" />
</c:url>
<c:url value="https://www.linkedin.com/sharing/share-offsite/" var="linkedinUrl">
    <c:param name="url" value="${newsUrl}" />
</c:url>



<h3 class="text-primary">${shareTitle}&nbsp;&nbsp;
<a href=${facebookUrl} class="fa fa-facebook"/></a>&nbsp;
<a href=${twitterUrl} class="fa fa-twitter"></a>&nbsp;
<a href=${linkedinUrl} class="fa fa-linkedin"></a></h3>