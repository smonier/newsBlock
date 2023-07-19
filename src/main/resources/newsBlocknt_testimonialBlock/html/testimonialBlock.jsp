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

<jcr:nodeProperty node="${currentNode}" name="jcr:title" var="title"/>
<jcr:nodeProperty node="${currentNode}" name="quote" var="quote"/>
<jcr:nodeProperty node="${currentNode}" name="quoteAuthor" var="quoteAuthor"/>

<c:set var="mediaNode" value="${currentNode.properties['backgroundBanner'].node}"/>
<%@ include file="../../getMediaURL.jspf" %>
<c:set var="imageUrl" value="${mediaURL}"/>
<template:addCacheDependency node="${mediaNode}"/>

<style>
    /* CSS to style the full-width banner */
    body {
        margin: 0;
        padding: 0;
    }

    .banner {
        position: relative;
        width: 100%;
        height: 500px; /* Adjust the height as per your preference */
        background-image: url('${imageUrl}');
        background-size: cover;
        background-position: center;
        color: white;
        text-align: center;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
    }

    .quote {
        font-style: italic;
    color: #fff;
    font-size: 1.3rem;
    text-align: center;
    display: flex;
    flex-direction: column;
    margin: 0 auto;
    }

    .author {
        text-align: right;
    font-size: 1.3rem;
    color: #fff;
    }

 .testimonialItem {
    position: relative;
    display: flex;
    flex-direction: column;
    max-width: 45%;
    margin: 0 auto;
}

.testimonialQuote.bottom {
    bottom: initial;
    left: initial;
    right: 22%;
    transform: rotate(180deg);
    top: 35%;
    font-size: 14rem;
    color: #fff;
    position: absolute;
    letter-spacing: -19px;
    line-height: 1rem;
}

.testimonialQuote.top {
    bottom: initial;
    left: initial;
    font-size: 14rem;
    color: #fff;
    position: absolute;
    letter-spacing: -19px;
    bottom: 86%;
    line-height: 1rem;
    left: 4%;
}
</style>
<div class="banner">
    <div class="testimonialItem">
    <span class="testimonialQuote top">"</span>
        <div class="quote">${quote}</div>
    <span class="testimonialQuote bottom">"</span>
    <p>&nbsp;</p><br/>
    <div class="author">${quoteAuthor}</div>
</div>
</div>