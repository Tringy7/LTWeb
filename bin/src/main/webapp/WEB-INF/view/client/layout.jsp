<html>
    <head>
        <title>${sitemesh.page.title}</title>
        ${sitemesh.page.head}
    </head>
    <body>
        <jsp:include page="/WEB-INF/view/client/common/header.jsp" />

        ${sitemesh.page.content}

        <jsp:include page="/WEB-INF/view/client/common/footer.jsp" />
    </body>
</html>
