<%@ page import="com.melanin.commons.*" %>
<html>
<head>
    <meta name="layout" content="m-melanin-login-layout"/>
</head>

<body>

<script type="text/javascript">
    $(function () {
        set_active_tab('login');
    });

    //$('.page-prefooter').css('position','absolute');

    if (window.innerHeight < window.innerWidth) {
        //alert("Please use Landscape!");
        //$('.page-prefooter').css('position','relative');
    }
</script>

</body>
</html>