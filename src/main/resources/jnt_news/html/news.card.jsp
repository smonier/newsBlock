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

<style>
    .middle {
        transition: .5s ease;
        opacity: 0;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        -ms-transform: translate(-50%, -50%);
        text-align: center;
    }
    .card:hover .newsImg {
        opacity: 0.3;
    }
    .card:hover .cardText .card-text    {
        opacity: 0.2;
    }
    .card:hover .middle {
        opacity: 1;
    }

    .card .newsImg {
        opacity: 0.8;
        display: block;
        width: 100%;
        height: auto;
        transition: .5s ease;
        backface-visibility: hidden;
    }
    .card .cardText .h3 card-title {
        opacity: 1.2;
        background-color: #1e1e1e;

    }
</style>
<jcr:nodeProperty node="${currentNode}" name="image" var="newsImage"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="newsTitle"/>
<jcr:nodeProperty node="${currentNode}" name="j:defaultCategory" var="Categories"/>
<jcr:nodeProperty node="${currentNode}" name="jcr:uuid" var="uuid"/>
<jcr:nodeProperty node="${currentNode}" name="j:tagList" var="newsTags"/>

<c:set var="myCat" value=""/>
<c:if test="${!empty Categories }">
    <c:forEach items="${Categories}" var="category">
        <c:set var="myCat" value="${myCat} ${category.node.displayableName}"/>
    </c:forEach>
</c:if>
<c:set var="myTags" value=""/>
<c:if test="${!empty newsTags }">
    <c:forEach items="${newsTags}" var="tag">
        <c:set var="myTags" value="${myTags} ${tag.string}"/>
    </c:forEach>
</c:if>


<div class="card bg-dark text-white mb-2 ${myCat} ${myTags}" style="width:100%">
    <c:if test="${not empty newsImage}">
        <c:url value="${url.files}${newsImage.node.path}" var="imageUrl"/>
        <div class="newsImg">
            <a href="<c:url value='${url.base}${currentNode.path}.html'/>">
                <img class="card-img" src="${imageUrl}" alt="${newsTitle}" width="100%"/>
            </a>
        </div>
    </c:if>

    <div class="card-img-overlay cardText">
        <a href="<c:url value='${url.base}${currentNode.path}.html'/>"><h3 class="card-title"
                                                                           style="color: #fff">${fn:escapeXml(newsTitle.string)}</h3>
        </a>
        <p class="card-text">${functions:abbreviate(functions:removeHtmlTags(currentNode.properties.desc.string),400,450,'...')}</p>
    </div>
    <div class="middle">
        <a href="<c:url value='${url.base}${currentNode.path}.html'/>" class="btn btn-swansea btn-lg">Read More        </a>
    </div>
</div>


