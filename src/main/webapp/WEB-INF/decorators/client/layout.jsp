<%@ include file="/WEB-INF/common/taglib.jsp" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="utf-8">
        <title>
            <sitemesh:write property='title' default='Electro - Electronics Website Template' />
        </title>

        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <link href="/client/lib/animate/animate.min.css" rel="stylesheet">
        <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="/client/css/bootstrap.min.css" rel="stylesheet">
        <link href="/client/css/style.css" rel="stylesheet">

        <sitemesh:write property='head' />
    </head>

    <body>
        <%@ include file="/WEB-INF/views/client/common/header.jsp" %>

            <sitemesh:write property='body' />

            <%@ include file="/WEB-INF/views/client/common/footer.jsp" %>
                <!-- Back to Top -->
                <a href="#" class="btn btn-primary btn-lg-square back-to-top" style="display: none;"><i
                        class="fa fa-arrow-up"></i></a>
    </body>

    </html>