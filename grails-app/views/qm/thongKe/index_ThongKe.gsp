<%@ page import="com.melanin.security.*" %>

<html>
<head>
    <meta name="layout" content="m-melanin-layout"/>
    <title>Thống kê</title>

    <input type="hidden" id="toastrMessage" value='${flash.message}'/>

    <asset:javascript src="assets/plugins/bootstrap/js/bootstrap.min.js"/>
    <asset:stylesheet src="assets/plugins/data-tables/datatableExt_Editor-1.9.4/css/editor.dataTables.css"/>
    <asset:javascript src="assets/plugins/data-tables/datatableExt_Editor-1.9.4/js/dataTables.editor_ng12t8n20.js"/>

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
                  model="${[menuItemName: 'TK']}"/>
    </ul>

    <!-- END SIDEBAR MENU -->
</div>
<!-- END SIDEBAR -->
<div class="page-content">
    <!-- BEGIN PAGE HEADER-->
    <!-- BEGIN PAGE TITLE & BREADCRUMB-->
    <ul id="m-melanin-breadcrum" class="page-breadcrumb breadcrumb">
        <g:render template="/templates/m-melanin-breadcrum"
                  model="${[
                          items: [[href: createLink(uri: '/'), title: 'home', label: 'Home'],
                                  [href: createLink(controller: 'thongKe', action: 'index_ThongKe'), title: 'Thống kê', label: 'Thống kê']]
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
        <div id="portlet_danhMuc" style="display: flex; flex-direction: column;align-items: center;">

            <canvas id="mostAskedTopicChart" style="width:100%;max-width:100rem; padding: 2rem 0"></canvas>
            <canvas id="foundResultsChart" style="width:100%;max-width:50rem"></canvas>

            <canvas id="numberOfQuestionsInAPeriod" style="width:100%; max-width:100rem;padding: 2rem 0"></canvas>


            <div id="percentageOfQuestionsFoundResults" style="width:100%; max-width:110rem; height: 60rem"></div>

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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
    window.mapData_percentageOfQuestionsFoundResults = [["Contry", "Mhl"], ["a", 10], ["c", 7]]
    window.mapData_numberOfQuestionsInAPeriod = [['Thời gian', 'Câu hỏi'],]

    $(document).ready(function () {
        $.ajax({
            type: "GET",
            async: false,
            url: "${createLink(controller:'thongKe',action:'mostAskedTopicChart')}",
            success: function (data) {
                common.showSpinner();
                if (data?.error == true) {
                    common.showToastr('error', 'Lỗi', data?.msg, 'toast-top-right');
                } else {
                    new Chart("mostAskedTopicChart", {
                        type: "bar",
                        data: {
                            labels: data?.xValues_MostAskedTopicChart,
                            datasets: [{
                                backgroundColor: data?.barColors_MostAskedTopicChart,
                                data: data?.yValues_MostAskedTopicChart
                            }]
                        },
                        options: {
                            legend: {display: false},
                            title: {
                                display: true,
                                text: "Chủ đề được hỏi nhiều nhất",
                                fontSize: 20,
                            }
                        }
                    });
                }
                setTimeout(function () {
                    common.hideSpinner();
                }, 300);
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

        $.ajax({
            type: "GET",
            async: false,
            url: "${createLink(controller:'thongKe',action:'numberOfQuestionsInAPeriod')}",
            success: function (data) {
                common.showSpinner();
                if (data?.error == true) {
                    common.showToastr('error', 'Lỗi', data?.msg, 'toast-top-right');
                } else {
                    var xValues = [50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150];
                    var yValues = [7, 8, 8, 9, 9, 9, 10, 11, 14, 14, 15];

                    new Chart("numberOfQuestionsInAPeriod", {
                        type: "line",
                        data: {
                            labels: data?.xValues_numberOfQuestionsInAPeriod,
                            datasets: [{
                                fill: false,
                                lineTension: 0,
                                backgroundColor: "rgba(0,0,255,1.0)",
                                borderColor: "rgba(0,0,255,0.1)",
                                data: data?.yValues_numberOfQuestionsInAPeriod
                            }]
                        },
                        options: {
                            title: 'Số lượng câu hỏi trong một khoảng thời gian',
                            fontSize: 20,
                            legend: {display: false},
                            scales: {
                                yAxes: [{ticks: {min: 6, max: 16}}],
                            }
                        }
                    });
                }
                setTimeout(function () {
                    common.hideSpinner();
                }, 300);
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

        $.ajax({
            type: "GET",
            async: false,
            url: "${createLink(controller:'thongKe',action:'foundResultsChart')}",
            success: function (data) {

                common.showSpinner();
                if (data?.error == true) {
                    common.showToastr('error', 'Lỗi', data?.msg, 'toast-top-right');
                } else {
                    new Chart("foundResultsChart", {
                        type: "pie",
                        data: {
                            labels: data?.xValues_FoundResultsChart,
                            datasets: [{
                                backgroundColor: data?.barColors_FoundResultsChart,
                                data: data?.yValues_FoundResultsChart
                            }]
                        },
                        options: {
                            title: {
                                display: true,
                                text: "Số lượng câu hỏi tìm được kết quả",
                                fontSize: 20,
                            }
                        }
                    });
                }
                setTimeout(function () {
                    common.hideSpinner();
                }, 300);
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

        %{--$.ajax({--}%
        %{--    type: "GET",--}%
        %{--    async: false,--}%
        %{--    url: "${createLink(controller:'thongKe',action:'foundResultsChart')}",--}%
        %{--    success: function (data) {--}%
        %{--        common.showSpinner();--}%
        %{--        if (data?.error == true) {--}%
        %{--            common.showToastr('error', 'Lỗi', data?.msg, 'toast-top-right');--}%
        %{--        } else {--}%
        %{--            google.charts.load('current', {'packages': ['corechart']});--}%
        %{--            google.charts.setOnLoadCallback(drawChart);--}%

        %{--            function drawChart() {--}%
        %{--                // var data = google.visualization.arrayToDataTable([--}%
        %{--                //     [data?.mapData_FoundResultsChart_google[0][0], data?.mapData_FoundResultsChart_google[0][1]],--}%
        %{--                //     [data?.xValues_FoundResultsChart[0], parseFloat(data?.yValues_FoundResultsChart[0])],--}%
        %{--                //     [data?.xValues_FoundResultsChart[1], parseFloat(data?.yValues_FoundResultsChart[1])],--}%
        %{--                // ], false); // 'false' means that the first row contains labels, not data.--}%
        %{--                var data = google.visualization.arrayToDataTable(data?.mapData_FoundResultsChart_google,false);--}%

        %{--                var options = {--}%
        %{--                    title: 'Tỷ lệ % câu hỏi tìm được kết quả',--}%
        %{--                    fontSize: 20,--}%
        %{--                };--}%

        %{--                var chart = new google.visualization.PieChart(document.getElementById('percentageOfQuestionsFoundResults'));--}%
        %{--                chart.draw(data, options);--}%
        %{--            }--}%
        %{--        }--}%
        %{--        setTimeout(function () {--}%
        %{--            common.hideSpinner();--}%
        %{--        }, 300);--}%
        %{--    },--}%
        %{--    error: function (jqXHR, textStatus, errorThrown) {--}%
        %{--        common.hideSpinner();--}%
        %{--        if (textStatus === "timeout") {--}%
        %{--            jquery_alert('Thông báo', 'Kết nối quá hạn, xin vui lòng thực hiện lại hoặc đăng nhập lại tài khoản'); //Handle the timeout--}%
        %{--        } else {--}%
        %{--            common.hideSpinner();--}%
        %{--            if (jqXHR.status == '403') {--}%
        %{--                common.showToastr('error', 'Lỗi', 'Bạn không có quyền thực hiện thao tác này!', 'toast-top-right');--}%
        %{--            } else {--}%
        %{--                common.showToastr('error', 'Lỗi', errorThrown, 'toast-top-right');--}%
        %{--            }--}%
        %{--        }--}%
        %{--    }--}%
        %{--});--}%

    });

    $(function () {
        set_active_tab('TK');
        $.configureBoxes();
        melanin_validate.role_validate();

    });

    function load_PercentageOfQuestionsFoundResults(xValues_FoundResultsChart, yValues_FoundResultsChart, mapData_FoundResultsChart_google, callback) {
        // window.percentageOfQuestionsFoundResults[1] = [xValues_FoundResultsChart[0], yValues_FoundResultsChart[0]];
        // window.percentageOfQuestionsFoundResults[2] = [xValues_FoundResultsChart[1], yValues_FoundResultsChart[1]];
        window.percentageOfQuestionsFoundResults = mapData_FoundResultsChart_google;
        callback;
    }

    function drawChart_PercentageOfQuestionsFoundResults() {
        google.charts.load('current', {'packages': ['corechart']});
        google.charts.setOnLoadCallback(drawChart);

        function drawChart() {
            var data = google.visualization.arrayToDataTable(window.percentageOfQuestionsFoundResults);

            var options = {
                title: 'Tỷ lệ % câu hỏi tìm được kết quả',
                fontSize: 20,
            };

            var chart = new google.visualization.PieChart(document.getElementById('percentageOfQuestionsFoundResults'));
            chart.draw(data, options);
        }
    }
</script>
</body>
</html>