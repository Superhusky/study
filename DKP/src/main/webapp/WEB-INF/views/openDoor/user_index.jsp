<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>DKP-管理台</title>
    <link href="${ctxStatic}/css/css.css" rel="stylesheet" type="text/css">
    <script src="${ctxStatic}/jquery/jquery-1.12.1.min.js"></script>
    <script src="${ctxStatic}/jquery/jquery.cookie.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            if ($.cookie("rmbUser") == "true") {
                $("#rememberMe").attr("checked", true);
                $("#username").val($.cookie("username"));
                $("#password").val($.cookie("password"));
            }
            refreshValidateCode();
        });

        function refreshValidateCode() {
            $("#img-validate-code").attr('src', '${request.contextPath}/servlet/validateCodeServlet?' + new Date().getTime());
            return false;
        }

        function showErrorMessAge(msg) {
            $('#error-msg-content').html(msg);
            $('#error-msg-content').show();
            $('#error-msg-content').delay(5000).hide(0);
        }

        function save() {
            if ($("#rememberMe").attr("checked")) {
                var str_username = $("#username").val();
                var str_password = $("#password").val();
                $.cookie("rmbUser", "true", {expires: 7}); //存储一个带7天期限的cookie
                $.cookie("username", str_username, {expires: 7});
                $.cookie("password", str_password, {expires: 7});
            }
            else {
                $.cookie("rmbUser", "false", {expire: -1});
                $.cookie("username", "", {expires: -1});
                $.cookie("password", "", {expires: -1});
            }
        }

        /*function ValidityInfo() {
            var loginName = $('#loginName').val();
            var password = $('#password').val();
            $.post('User/login',{
                loginName:loginName,
                password:password
            },function (data,state) {
                location.href = "";
            })
        }*/
    </script>
</head>
<body>
<div id="wrap" style="background: url(${ctxStatic}/images/bg.jpg) no-repeat center;background-size:cover">
    <div class="logo" style="height:102px;"></div>
    <form action="/login" method="post" name="form">
        <div class="main">
            <div class="admin"
                 style="background:url(${ctxStatic}/images/admin.png) no-repeat center;background-size: contain"></div>
            <div class="login"
                 style="background: url(${ctxStatic}/images/login-bg.png) no-repeat center;background-size: contain">
                <div class="name">
                    <input id="username" class="username" type="text" name="username" placeholder="用户名"
                           value="${username}"/>
                </div>
                <div class="pwd">
                    <input id="password" class="password" type="password" name="password" placeholder="密码"
                           value="${password}"/>
                </div>
                <div class="form-search">
                    <input id="validateCode" class="nrb" type="text" placeholder="验证码" name="validateCode" value/>
                    <a href="javascript:" title="刷新" onclick="refreshValidateCode()">
                        <img id="img-validate-code" src="${request.contextPath}/servlet/validateCodeServlet"
                             width="100" height="36" style="vertical-align: middle">
                        <i class="icon"></i>
                    </a>
                </div>

                <c:if test="${error_msg != null}">
                    <div class="error-msg">
                        <span class="error-msg-content">${error_msg}</span>
                    </div>
                </c:if>
                <div class="login-button">
                    <input type="submit" class="login-a" href="" value="登录"/>
                </div>
                <div class="next">
                    <input id="rememberMe" type="checkbox" name="rememberMe" value="true"/>
                    <label for="rememberMe" class="next-login">下次自动登录</label>
                </div>
                <%--<div class="error-msg">
                    <span class="error-msg-content" id="error-msg-content"></span>
                </div>--%>
            </div>
        </div>
    </form>
</div>
</body>
</html>

