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

<%--@elvariable id="currentNode"
type="org.jahia.services.content.JCRNodeWrapper" --%>
<%--@elvariable id="out" type="java.io.PrintWriter" --%>
<%--@elvariable id="script"
type="org.jahia.services.render.scripting.Script" --%>
<%--@elvariable id="scriptInfo" type="java.lang.String" --%>
<%--@elvariable id="workspace" type="java.lang.String" --%>
<%--@elvariable id="renderContext"
type="org.jahia.services.render.RenderContext" --%>
<%--@elvariable id="currentResource"
type="org.jahia.services.render.Resource" --%>
<%--@elvariable id="url"
type="org.jahia.services.render.URLGenerator"
--%>

<template:addResources type="css"
    resources="testimonialBlock.css" />
<c:set var="rand">
    <%= java.lang.Math.round(java.lang.Math.random()
        * 10000) %>
</c:set>
<c:set var="bannerId"
    value="banner-${rand}" />

<jcr:nodeProperty node="${currentNode}"
    name="jcr:title" var="title" />
<jcr:nodeProperty node="${currentNode}"
    name="quote" var="quote" />
<jcr:nodeProperty node="${currentNode}"
    name="quoteAuthor" var="quoteAuthor" />

<c:set var="mediaNode"
    value="${currentNode.properties['backgroundBanner'].node}" />
<%@ include file="../../getMediaURL.jspf" %>
    <c:set var="imageUrl"
        value="${mediaURL}" />
    <template:addCacheDependency
        node="${mediaNode}" />

    <style>
        #${bannerId}.testimonialBanner {

            background-image: url('${imageUrl}');

        }
    </style>
    <div id="${bannerId}"
        class="testimonialBanner">
        <div class="testimonialItem">
            <div class="quote">${quote}
            </div>
            <p>&nbsp;</p><br />
            <div class="author">
                ${quoteAuthor}</div>
        </div>
    </div>