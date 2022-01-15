<%@ page import="com.melanin.security.*" %>

<html>
<head>
    <meta name="layout" content="m-melanin-layout"/>
    <title>Huấn luyện và thực nghiệm</title>

    %{--    <asset:stylesheet src="datatables.min.css"/>--}%
    %{--    <asset:javascript src="datatables.min.js"/>--}%


    <input type="hidden" id="toastrMessage" value='${flash.message}'/>

    %{--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">--}%
    %{--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--}%
    %{--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>--}%

    <asset:javascript src="assets/plugins/bootstrap/js/bootstrap.min.js"/>
    <asset:stylesheet src="assets/plugins/data-tables/datatableExt_Editor-1.9.4/css/editor.dataTables.css"/>
    <asset:javascript src="assets/plugins/data-tables/datatableExt_Editor-1.9.4/js/dataTables.editor_ng12t8n20.js"/>
    <asset:stylesheet src="style_handle_soantd1.css"></asset:stylesheet>
    <style type="text/css">
    .ml10px {
        margin-left: 10px;
    }
    </style>
</head>

<body>
<!-- BEGIN CONTAINER -->
<!-- BEGIN SIDEBAR -->
<div class="page-sidebar navbar-collapse collapse">
    <!-- BEGIN SIDEBAR MENU -->
    <ul class="page-sidebar-menu">
        <li>
            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
            <div class="sidebar-toggler hidden-phone primary m-melanin-toggle-side-bar"></div>
            <!-- BEGIN SIDEBAR TOGGLER BUTTON -->
        </li>
    </ul>
    <!-- BEGIN SIDEBAR MENU -->
    <ul class="page-sidebar-menu">
        <g:render template="/m-melanin-fingerprint/sidebar_item/template/div_DynamicSidebar"
                  model="${[menuItemName: 'HUAN_LUYEN']}"/>
    </ul>

    <!-- END SIDEBAR MENU -->
</div>
<!-- END SIDEBAR -->
<div class="page-content">
    <!-- BEGIN PAGE HEADER-->
    <!-- BEGIN PAGE TITLE & BREADCRUMB-->
    <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
        <g:render template="/templates/m-melanin-action-bar"
                  model="${[
                          buttons: [
                                  [name: 'button-training-bot', label: 'Huấn luyện', class: 'green default', icon: 'icon-rocket'],
//                                  [name: 'button-get-data', label: 'Get data', class: 'green default', icon: 'icon-rocket'],
                          ]
                  ]}"/>
        <g:render template="/templates/m-melanin-breadcrum"
                  model="${[
                          items: [[href: createLink(uri: '/'), title: 'home', label: 'Home'],
                                  [href: createLink(controller: 'huanLuyenVaThucNghiem', action: 'index_HuanLuyenVaThucNghiem'), title: 'Huấn luyện và thực nghiệm', label: 'Huấn luyện và thực nghiệm']]
                  ]}"/>
    </ul>
    <!-- END PAGE TITLE & BREADCRUMB-->
    <!-- END PAGE HEADER-->

    <!-- BEGIN PAGE CONTENT-->
    <div id="m-melanin-main-content">
        <!-- BEGIN Div them moi chart -->
        <div id="portlet_timKiem">
        </div>
        <!-- END Div them moi chart -->

        <!-- BEGIN DATA TABLE -->
        <div id="portlet_danhMuc" style="height: 50rem;">
            <section class="msger">
                <header class="msger-header">
                    <div class="msger-header-title">
                    </i> MSB Banking Bot </i>
                    </div>
                </header>

                <main class="msger-chat">
                    <div class="msg left-msg">
                        <div class="msg-img"
                             style="background-image: url(https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsmixxd9G9oV20aU-el1EIz4t0GKHGBVGjNw&usqp=CAU)">
                        </div>

                        <div class="msg-bubble">
                            <div class="msg-info">
                                <div class="msg-info-name ">MSBBankingBot</div>

                                <div class="msg-info-time"></div>
                            </div>

                            <div class="msg-text">
                                Xin chào! Chào mừng bạn đến với Ngân hàng TMCP Hàng Hải Việt Nam (MSB) 😄
                            </div>

                            <div class="msg-text">
                                Bạn có hỏi bất cứ điệu gì về MSB như: Internet Banking (cá nhân hoặc doanh nghiệp), dịch vụ MSB Bankplus, v.v.
                            </div>
                        </div>
                    </div>

                </main>

                <form class="msger-inputarea">
                    <input type="text" class="msger-input" id="textInput"
                           placeholder="Nhập tin nhắn...">
                    <button type="submit" class="msger-send-btn">Gửi</button>
                </form>
            </section>

        </div>
        <!-- END DATA TABLE -->

    </div>

    <style>
    /*.portlet.box.deepblue {*/
    /*    border: 1px solid #255796;*/
    /*    border-top:1px solid #255796;*/
    /*}*/
    .modal-backdrop {
        overflow: hidden;
    }

    #spinner {
        overflow: hidden;
    }
    </style>

    <!-- END PAGE CONTENT-->
</div>
<!-- END CONTAINER -->
<script src='https://use.fontawesome.com/releases/v5.0.13/js/all.js'></script>
<script>
    const msgerForm = get(".msger-inputarea");
    const msgerInput = get(".msger-input");
    const msgerChat = get(".msger-chat");


    // Icons made by Freepik from www.flaticon.com
    const BOT_IMG = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsmixxd9G9oV20aU-el1EIz4t0GKHGBVGjNw&usqp=CAU";
    const PERSON_IMG = "https://scontent.fhan5-8.fna.fbcdn.net/v/t1.6435-9/130905377_2745297575800423_4934307131550793363_n.jpg?_nc_cat=110&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=areNTZv8WnAAX__ewvJ&_nc_ht=scontent.fhan5-8.fna&oh=00_AT_e0c0ywnNkWYeuE5RXBuKVv50VBc1uwa2nj8g9-F4nBg&oe=620315EB";
    const BOT_NAME = "MSBBankingBot";
    const PERSON_NAME = "Bạn";

    msgerForm.addEventListener("submit", event => {
        event.preventDefault();

        const msgText = msgerInput.value;
        if (!msgText) return;

        appendMessage(PERSON_NAME, PERSON_IMG, "right", msgText);
        msgerInput.value = "";
        botResponse(msgText);
    });

    function appendMessage(name, img, side, text) {
        let msg_text_item = "";

        if (text !== "") {
            let textArr = text.split("n-");
            for (let i = 0; i < textArr.length; i++) {
                if (textArr[i].startsWith('- ')) {
                    msg_text_item += "<p style='margin-left: 10px;'>\n" + textArr[i] + "</p>";
                } else {
                    msg_text_item += "<p>" + textArr[i] + "</p>";
                }
            }
        } else {
            msg_text_item = "${com.commons.Constant.MSG_NULL_RESPONSE_BOT_1}"
        }
        console.log("msg_text_item: " + msg_text_item);

        const msgHTML = `
                <div class="msg ` + side + `-msg">
                <div class="msg-img" style="background-image: url(` + img + `)"></div>
                <div class="msg-bubble">
                    <div class="msg-info">
                    <div class="msg-info-name">` + name + `</div>
                    <div class="msg-info-time">${formatDate(date: new Date(), format: 'HH:mm')}</div>
                    </div>
                    <div class="msg-text">
                        ` + msg_text_item + `
                    </div>
                </div>
                </div>
                `;

        msgerChat.insertAdjacentHTML("beforeend", msgHTML);
        msgerChat.scrollTop += 500;
    }

    function botResponse(rawText) {
        // Bot Response
        $.get("<g:createLink controller='huanLuyenVaThucNghiem' action='getBotResponse'/>", {
            msg: encodeURI(rawText),
            msg_NoEncode: rawText,
        }).done(function (data) {
            const msgText = data?.result;
            appendMessage(BOT_NAME, BOT_IMG, "left", msgText);
        });
        // const msgText = "Ha aha fakfdskj gskghdsk gklgds p gsdg";
        // appendMessage(BOT_NAME, BOT_IMG, "left", msgText);
    }

    // Utils
    function get(selector, root = document) {
        return root.querySelector(selector);
    }

</script>
<script type="text/javascript">
    window.data_DsCH_TL = []
    $(function () {
        set_active_tab('HUAN_LUYEN');
        $.configureBoxes();
        melanin_validate.role_validate();

        $("button[name=button-training-bot]").click(function (e) {
            e.preventDefault();
            $(":button:contains('OK')").attr('disabled', true);

            $.ajax({
                type: "GET",
                async: false,
                url: "${createLink(controller:'huanLuyenVaThucNghiem',action:'trainingBot')}",
                success: function (data) {
                    common.showSpinner();
                    if (data?.result != null) {
                        common.showToastr('success', 'Thông báo', data?.result, 'toast-top-right');

                        setTimeout(function () {
                            common.hideSpinner();
                        }, 300);
                    } else {
                        common.showToastr('error', 'Lỗi', 'Có lỗi xảy ra', 'toast-top-right');
                        setTimeout(function () {
                            common.hideSpinner();
                        }, 300);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    common.hideSpinner();
                    if (textStatus === "timeout") {
                        jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                    } else {
                        common.hideSpinner();
                        if (jqXHR.status == '403') {
                            common.showToastr('error', 'Lỗi', 'Bạn không có quyền thực hiện thao tác này!', 'toast-top-right');
                        } else {
                            common.showToastr('error', 'Lỗi', errorThrown, 'toast-top-right');
                        }
                    }
                }
            });
        });

        $("button[name=button-get-data]").click(function (e) {
            e.preventDefault();
            $(":button:contains('OK')").attr('disabled', true);

            $.ajax({
                type: "GET",
                async: false,
                url: "${createLink(controller:'huanLuyenVaThucNghiem',action:'writeDataToFile')}",
                success: function (data) {
                    common.showSpinner();
                    if (data?.result != null) {
                        common.showToastr('success', 'Thông báo', data?.result, 'toast-top-right');
                        window.data_DsCH_TL = data?.data
                        setTimeout(function () {
                            common.hideSpinner();
                        }, 300);
                    } else {
                        common.showToastr('error', 'Lỗi', 'Có lỗi xảy ra!', 'toast-top-right');
                        setTimeout(function () {
                            common.hideSpinner();
                        }, 300);
                    }

                },
                error: function (jqXHR, textStatus, errorThrown) {
                    common.hideSpinner();
                    if (textStatus === "timeout") {
                        jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout
                    } else {
                        common.hideSpinner();
                        if (jqXHR.status == '403') {
                            common.showToastr('error', 'Lỗi', 'Bạn không có quyền thực hiện thao tác này!', 'toast-top-right');
                        } else {
                            common.showToastr('error', 'Lỗi', errorThrown, 'toast-top-right');
                        }
                    }
                }
            });
        });

    });
</script>

</body>
</html>