<%--
  Created by IntelliJ IDEA.
  User: 半夏微凉
  Date: 2016/9/26
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <%@include file="/WEB-INF/views/include/head.jsp" %>
    <link rel="stylesheet" href="${ctxStatic}/semantic/semantic.min.css"/>
    <script type="text/javascript" src="${ctxStatic}/semantic/semantic.min.js"></script>
    <script type="text/javascript" src="${ctxStatic}/jquery/jquery.zoom.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.ui.modal').modal({allowMultiple: true, closable: false, autofocus: false});
            //dropdown初始化并且设定onChange事件
            $('#sel-game').dropdown('setting', 'onChange', function () {
                var gameId = $("#game").val();

                //union dropdown
                var unionSelector = '#sel-union';
                $(unionSelector + ' .menu .item').remove();
                var unionHtml = '<div class="item" data-value="">全部</div>';
                $(unionSelector + ' .menu').html(unionHtml);
                $(unionSelector).dropdown('set selected', '');

                // team dropdown
                var teamSelector = '#sel-team';
                $(teamSelector + ' .menu .item').remove();
                var teamHtml = '<div class="item" data-value="">全部</div>';
                $(teamSelector + ' .menu').html(teamHtml);
                $(teamSelector).dropdown('set selected', '');

                // activity dropdown
                var activitySelector = '#sel-activity';
                $(activitySelector + ' .menu .item').remove();
                var activityHtml = '<div class="item" data-value="">全部</div>';
                $(activitySelector + ' .menu').html(activityHtml);
                $(activitySelector).dropdown('set selected', '');

                if (gameId == '') {
                    return;
                }

                $.get('/console/dkp/union', {
                    gameId: gameId
                }, function (data, state) {
                    if (data && data.length >= 0) {
                        var selector = '#sel-union';
                        $(selector + ' .menu .item').remove();
                        var html = '<div class="item" data-value="">全部</div>';
                        for (var i = 0; i < data.length; i++) {
                            html += '<div class="item" data-value="' + data[i].id + '">' + data[i].unionName + '</div>'
                        }
                        $(selector + ' .menu').html(html);
                        $(selector).dropdown('set selected', '');
                    }
                })
            });

            $('#sel-union').dropdown('setting', 'onChange', function () {
                var gameId = $("#game").val();
                var unionId = $("#union").val();
                if (unionId == '') {
                    return;
                }
                $.get('/console/dkp/team/', {
                    gameId: gameId,
                    unionId: unionId
                }, function (data, state) {
                    if (data && data.length >= 0) {
                        var selector = '#sel-team';
                        var html = '<div class="item" data-value="">全部</div>';
                        for (var i = 0; i < data.length; i++) {
                            html += '<div class="item" data-value="' + data[i].id + '">' + data[i].name + '</div>'
                        }
                        $(selector + ' .menu').html(html);
                        $(selector).dropdown('set selected', '')
                    }
                })
            })

            //team dropdown
            $('#sel-team').dropdown('setting', 'onChange', function () {
                var teamId = $("#team").val();
                var gameId = $('#game').val();
                var unionId = $("#union").val();
                if (teamId == '') {
                    return;
                }
                $.get('/console/dkp/activity/', {
                    gameId: gameId,
                    teamId: teamId,
                    unionId: unionId
                }, function (data, state) {
                    if (data && data.length >= 0) {
                        var selector = '#sel-activity';
                        $(selector + ' .menu .item').remove();
                        var html = '<div class="item" data-value="">全部</div>';
                        for (var i = 0; i < data.length; i++) {
                            html += '<div class="item" data-value="' + data[i].id + '">' + data[i].name + '</div>';
                        }
                        $(selector + ' .menu').html(html);
                        $(selector).dropdown('set selected', '');
                    }
                });
            });

            //没选游戏的时候报错
            $('.ui.form').form({
                fields: {
                    game: {
                        identifier: 'game',
                        rules: [
                            {
                                type: 'empty',
                                prompt: '请选择游戏',
                            }
                        ]
                    },
                }
            });

            // 查询按钮
            $('#btn-query').click(function () {
                if ($('#game').val() == '') {
                    return;
                }
                queryData(1);
            });
        });
        //上面的到document为止，页面刷新完毕后加载

        //获取当前页信息
        function queryData(pageNo) {
            showLoading();
            $.get("/console/dkp/list", {
                gameId: $("#game").val(),
                teamId: $("#team").val(),
                activityId: $("#activity").val(),
                pageNo: pageNo,
                pageNum: 10
            }, function (data, state) {
                if (data && data.dkpInfoList) {
                    var dkpInfoList = data.dkpInfoList;
                    $('#tbl-data tbody tr').remove();
                    var trHtml = '';
                    for (var i = 0; i < dkpInfoList.length; i++) {
                        trHtml += '<tr>';
                        trHtml += '<td>' + dkpInfoList[i].gameName + '</td>';
                        trHtml += '<td>' + dkpInfoList[i].teamName + '</td>';
                        trHtml += '<td>' + dkpInfoList[i].userName + '</td>';
                        trHtml += '<td>' + dkpInfoList[i].activityName + '</td>';
                    }
                    $('#tbl-data tbody').html(trHtml);
                    $('#currentPage-popup').val(data.pageNo);
                    $('#no-data').hide();
                    $('#tbl-data').show();
                    showPaging(data.pageNo, data.sumPage);
                }
            });
            hideLoading();
        }

        //分页信息
        function showPaging(currentPage, totalCount) {
            var pageCount = totalCount;
            var pagingHtml;
            if (currentPage == 1) {
                pagingHtml = '<a class="icon item disabled"><i class="angle left icon"></i>';
            } else {
                pagingHtml = '<a class="icon item" onclick="pagingPrevious()"><i class="angle left icon"></i>';
            }
            for (var i = 1; i <= pageCount; i++) {
                if (currentPage == i) {
                    pagingHtml += '<a class="item active">' + i + '</a>';
                } else {
                    pagingHtml += '<a class="item" onclick="queryData(' + i + ')">' + i + '</a>';
                }
            }
            if (currentPage == pageCount) {
                pagingHtml += '<a class="icon item disabled"><i class="angle right icon"></i>';
            } else {
                pagingHtml += '<a class="icon item" onclick="pagingNext()"><i class="angle right icon"></i>';
            }
            $('#paging .item').remove();
            $('#paging').html(pagingHtml);
            $('.ui.first.modal').modal('refresh');
        }

        //页码前进按钮
        function pagingPrevious() {
            var pageNo = $('#currentPage').val();
            pageNo = parseInt(pageNo) - 1;
            queryData(pageNo);
        }

        //页码后退按钮
        function pagingNext() {
            var pageNo = $('#currentPage').val();
            pageNo = parseInt(pageNo) + 1;
            queryData(pageNo);
        }

        //批阅异常详细信息列表
        function detailSet(testId, pageNo) {
            $.get('/console/markException/detail/list', {
                testId: testId,
                pageNo: pageNo,
                pageSize: 7
            }, function (data, state) {
                if (data && data.markExceptionInfoList && data.markExceptionInfoList.length > 0) {
                    var dataList = data.markExceptionInfoList;
                    $('#tbl-data-detail tbody tr').remove();
                    var trHtml = '';
                    for (var i = 0; i < dataList.length; i++) {
                        var imgEmptyFlag = dataList[i].imgEmptyFlag;
                        fn =
                                "updateDetailSet('" + dataList[i].id + "','" + dataList[i].testId + "','" + dataList[i].number + "'," +
                                "'" + dataList[i].paperId + "','" + dataList[i].question + "','" + dataList[i].subjectId + "'," +
                                "'" + dataList[i].path + "','" + dataList[i].ansImgId + "','" + dataList[i].anscardId + "','" + dataList[i].version + "','" + dataList[i].sideFlag + "','" + dataList[i].updateTime + "','" + dataList[i].questionImgId + "','" + dataList[i].imgEmptyFlag + "'," +
                                "'" + dataList[i].subjectName + "')";
                        trHtml += '<tr>';
                        trHtml += '<td>' + dataList[i].testId + '</td>';
                        trHtml += '<td>' + dataList[i].ansImgId + '</td>';
                        trHtml += '<td>';
                        if (imgEmptyFlag == 1) {
                            trHtml += '<div class="ui button" name="btn-query-update" style="color: red;" onclick="' + fn + '">处理</div>';
                        } else {
                            trHtml += '<div class="ui button" name="btn-query-update" onclick="' + fn + '">处理</div>';
                        }
                        trHtml += '</td>';
                    }
                    $('#tbl-data-detail tbody').html(trHtml);
                    $('#currentPage-popup').val(data.pageNo);
                    $('#no-data-detail').hide();
                    $('#tbl-data-detail').show();
                    showPaging(data.pageNo, data.pageSize, data.totalCount);
                } else {
                    if (pageNo == 1) {
                        $('#tbl-data-detail').hide();
                        $('#no-data-detail').show();
                    } else {
                        detailQueryData(pageNo - 1);
                    }
                }
                $('.ui.first.modal').modal('refresh');
            });
            var page = $('#currentPage').val();
            $('.ui.first.modal').modal('show');

            //内置窗体分页
            var showPaging = function (currentPage, pageSize, totalCount) {
                var pageCount = totalCount;
                var pagingHtml;
                if (currentPage == 1) {
                    pagingHtml = '<a class="icon item disabled"><i class="angle left icon"></i>';
                } else {
                    pagingHtml = '<a class="icon item" name="detailPagingPrevious"><i class="angle left icon"></i>';
                }
                for (var i = 1; i <= pageCount; i++) {
                    if (currentPage == i) {
                        pagingHtml += '<a class="item active">' + i + '</a>';
                    } else {
                        pagingHtml += '<a class="item" name="detailQueryData" data-page-no="' + i + '">' + i + '</a>';
                    }
                }
                if (currentPage == pageCount) {
                    pagingHtml += '<a class="icon item disabled"><i class="angle right icon"></i>';
                } else {
                    pagingHtml += '<a class="icon item" name="detailPagingNext"><i class="angle right icon"></i>';
                }
                $('#detailPaging .item').remove();
                $('#detailPaging').html(pagingHtml);

                //内置框题前一页
                $('[name="detailPagingPrevious"]').click(function () {
                    var pageNo = $('#currentPage-popup').val();
                    pageNo = parseInt(pageNo) - 1;
                    detailQueryData(pageNo);
                })

                //内置窗体后一页
                $('[name="detailPagingNext"]').click(function () {
                    var pageNo = $('#currentPage-popup').val();
                    pageNo = parseInt(pageNo) + 1;
                    detailQueryData(pageNo);
                })

                //内置窗体数字页
                $('[name="detailQueryData"]').click(function (e) {
                    var self = $(e.target);
                    var pageNo = self.data("page-no")
                    detailQueryData(pageNo);
                })
            }

            //根据pageNo获取批阅异常列表详细信息
            var detailQueryData = function (pageNo) {
                $.get('/console/markException/detail/list', {
                    testId: testId,
                    pageNo: pageNo,
                    pageSize: 7
                }, function (data, state) {
                    if (data && data.markExceptionInfoList && data.markExceptionInfoList.length > 0) {
                        var dataList = data.markExceptionInfoList;
                        $('#tbl-data-detail tbody tr').remove();
                        var trHtml = '';
                        for (var i = 0; i < dataList.length; i++) {
                            var imgEmptyFlag = dataList[i].imgEmptyFlag;
                            fn =
                                    "updateDetailSet('" + dataList[i].id + "','" + dataList[i].testId + "','" + dataList[i].number + "'," +
                                    "'" + dataList[i].paperId + "','" + dataList[i].question + "','" + dataList[i].subjectId + "'," +
                                    "'" + dataList[i].path + "','" + dataList[i].ansImgId + "','" + dataList[i].anscardId + "','" + dataList[i].version + "'," +
                                    "'" + dataList[i].sideFlag + "','" + dataList[i].updateTime + "','" + dataList[i].questionImgId + "','" + dataList[i].imgEmptyFlag + "','" + dataList[i].subjectName + "')";
                            trHtml += '<tr>';
                            trHtml += '<td>' + dataList[i].testId + '</td>';
                            trHtml += '<td>' + dataList[i].ansImgId + '</td>';
                            trHtml += '<td>';
                            if (imgEmptyFlag == 1) {
                                trHtml += '<div class="ui button" name="btn-query-update" style="color: red;" onclick="' + fn + '">处理</div>';
                            } else {
                                trHtml += '<div class="ui button" name="btn-query-update" onclick="' + fn + '">处理</div>';
                            }
                            trHtml += '</td>';
                        }
                        $('#tbl-data-detail tbody').html(trHtml);
                        $('#currentPage-popup').val(data.pageNo);
                        $('#no-data-detail').hide();
                        $('#tbl-data-detail').show();
                        showPaging(data.pageNo, data.pageSize, data.totalCount);
                    } else {
                        $('#tbl-data-detail').hide();
                        $('#no-data-detail').show();
                    }
                    $('.ui.first.modal').modal('refresh');
                });
                var page = $('#currentPage').val();
                $('.ui.first.modal').modal('show');
            }
        }

        //显示批阅异常试题信息
        function updateDetailSet(id, testId, number, paperId, question, subjectId, path, ansImgId, originalAnsCard, type, pageNum, updateTime, questionImgId, imgEmptyFlag, subjectName) {
            var exception = '#sel-exception-popup';
            var html =
                    '<input id="id-popup" name="id-popup"  value="' + id + '" type="hidden"/>' +
                    '<input id="testId-popup" name="testId-popup"  value="' + testId + '" type="hidden"/>' +
                    '<input id="number-popup" name="number-popup"  value="' + number + '" type="hidden"/>' +
                    '<input id="paperId-popup" name="paperId-popup"  value="' + paperId + '" type="hidden"/>' +
                    '<input id="question-popup" name="question-popup"  value="' + question + '" type="hidden"/>' +
                    '<input id="subject-popup" name="subject-popup"  value="' + subjectId + '" type="hidden"/>' +
                    '<input id="originalAnsCard-popup" name="originalAnsCard-popup"  value="' + originalAnsCard + '" type="hidden"/>' +
                    '<input id="type-popup" name="type-popup"  value="' + type + '" type="hidden"/>' +
                    '<input id="pageNum-popup" name="pageNum-popup"  value="' + pageNum + '" type="hidden"/>' +
                    '<input id="updateTime-popup" name="updateTime-popup"  value="' + updateTime + '" type="hidden"/>' +
                    '<input id="path-popup" name="path-popup"  value="' + path + '" type="hidden"/>' +
                    '<input id="ansImgId-popup" name="ansImgId-popup" type="hidden" value="' + ansImgId + '"/>' +
                    '<input id="questionImgId-popup" name="questionImgId-popup" type="hidden" value="' + questionImgId + '"/>' +
                    '<input id="imgEmptyFlag-popup" name="imgEmptyFlag-popup" type="hidden" value="' + imgEmptyFlag + '"/>' +
                    '<input id="subjectName-popup" name="subjectName-popup" type="hidden" value="' + subjectName + '"/>';
            $(exception).html(html);
            var ansImgId = ansImgId.replace(".jpg", "");
            var path = path.replace('backup/', '');
            var pointSelector = '#sel-picture-popup';
            $(pointSelector + ' img').remove();
            var questionImgIdArray = questionImgId.split(",");
            var pictureHtml = '';
            for (var i = 0; i < questionImgIdArray.length; i++) {
                pictureHtml += '<img alt= "图片" style="width:750px;height=400px;" src="${ctxStatic}' + '/answer' + path + 'rotated' + '/' + paperId + '/' + number + '/' + ansImgId + '/' + questionImgIdArray[i] + '.jpg' + '"/>';
            }
            $(pointSelector).html(pictureHtml);

            $.get('/console/markException/showLabel', {
                paperId: paperId,
                question: question
            }, function (data, state) {
                var sHtml = '<p>' + ' 科目 :' + (subjectName) + '</p>';
                var qHtml = '<p>' + ' 试题号 :' + (data) + '</p>';
                $('#sel-subject-popup').html(sHtml);
                $('#sel-question-popup').html(qHtml);
            })

            $('#sel-fireWork-popup').hide();
            $('#sel-chooseDo-popup').hide();
            $('#sel-prompt-popup').hide();

            $('#sel-message2-popup').hide();

            $("input[type='radio']").removeAttr('checked');

            var updateHtml = '<button class="fluid ui button"  onclick="updateException()">确认修改</button>';
            $('#update-button').html(updateHtml);
            $('#sel-button-popup').show();

            if (imgEmptyFlag == 1) {
                //给radio添加选中状态
                $("input[name='errorType']").get(2).checked = true;
                seeDetailMarkException();
            }
            var pageNo = $('#currentPage-popup').val();
            $('.ui.second.modal').modal({
                autofocus: false,
                closable: false,
                onHidden: function () {
                    detailSet(testId, pageNo);
                }
            }).modal('show');
        }

        //重新切图异常显示界面
        function showMarkException() {
            $('#sel-message-popup').hide();
            $('#sel-message2-popup').hide();
            var number = $('#number-popup').val();
            var type = $('#type-popup').val();
            var id = $('#id-popup').val();
            var question = $('#question-popup').val();
            var testId = $('#testId-popup').val();
            var paperId = $('#paperId-popup').val();
            var type = $('#type-popup').val();
            var pageNum = $('#pageNum-popup').val();
            var updateTime = $('#updateTime-popup').val();
            var ansImgId = $('#ansImgId-popup').val();
            var path = $('#path-popup').val();

            var picturePopup = '#sel-picture-popup';
            $('#sel-point-popup').hide();
            $(picturePopup).show();
            var htmlPicture = '<img alt= "图片" style="width:750px;height:850px;" src="${ctxStatic}/' + 'answer' + path + ansImgId + '"/>';
            $(picturePopup).html(htmlPicture);
            $(picturePopup).zoom({on: 'toggle'});


            if (pageNum == 1) {
                $("#sel-right").hide();
            } else {
                $("#sel-right").show();
            }

            var buttonHtml = '<button class="fluid ui button"  onclick="updateFireWorkException()">确认修改 </button>';
            $('#update-button').html(buttonHtml);

            $('#sel-fireWork-popup').show();
            $('#sel-chooseDo-popup').hide();
            $('#sel-prompt-popup').hide();
            $('#sel-button-popup').show();

            var defaultPaper;
            var getDefaultPaper = function () {
                return $.get('/console/markException/defaultPaper', {
                    testId: testId
                })
                        .then(function (data) {
                            defaultPaper = data;
                            return $.Deferred().resolve().promise(); //这个是什么意思
                        });
            }

            //获得试卷组
            var getPopupGroup = function () {
                var selector = '#sel-group-popup';
                $(selector + ' .menu .item').remove();
                return $.get('/console/markException/paperGroup')
                        .then(function (data) {
                            var html = '';
                            for (var i = 0; i < data.length; i++) {
                                html += '<div class="item" data-value="' + data[i].id + '">' + data[i].name + '</div>';
                            }
                            $(selector + ' .menu').html(html);
                            return $.Deferred().resolve().promise();
                        }).then(function () {
                            var $this = $(selector);
                            $this.dropdown('refresh');
                            $this.dropdown('set selected', defaultPaper.groupId);
                            var d = $.Deferred();
                            d.resolve();
                            return d.promise();
                        });
            }

            //获得试卷
            var getPopupPaper = function () {
                var d = $.Deferred().resolve();
                var selector = '#sel-paper-popup';
                $(selector + ' .menu .item').remove();
                return $.get('/console/markException/paper', {
                    testId: testId
                })
                        .then(function (data) {
                            var html = '<div class="item" data-value="">全部</div>';
                            for (var i = 0; i < data.length; i++) {
                                html += '<div class="item" data-value="' + data[i].paperId + '">' + data[i].paperName + '<input id="test-popup" name="test-popup" type="hidden" value="' + data[i].testId + '"/>' + '</div>';
                            }
                            $(selector + ' .menu').html(html);
                            $(selector).dropdown('refresh');
                            $(selector).dropdown('set selected', '');
                            return d.promise();
                        }).then(function () {
                            var $this = $(selector);
                            $this.dropdown('refresh');
                            $('#sel-answerNoLeft-popup').dropdown('refresh');
                            $('#sel-answerNoLeft-popup').dropdown('set selected', '');
                            $('#sel-answerNoRight-popup').dropdown('refresh');
                            $('#sel-answerNoRight-popup').dropdown('set selected', '');
                            $this.dropdown('setting', 'onChange', paperPopupChange);
                            return d.promise();
                        }).always(function () {
                        });
            }

            //试卷下拉框事件改变
            var paperPopupChange = function () {
                var paperId = $('#paper-popup').val();
                var d = $.Deferred();
                d.resolve();
                if (paperId == '') {
                    $('#sel-answerNoLeft-popup .menu .item').remove();
                    $('#sel-answerNoLeft-popup .menu').html('<div class="item" data-value="">全部</div>');
                    $('#sel-answerNoLeft-popup').dropdown('refresh');
                    $('#sel-answerNoLeft-popup').dropdown('set selected', '');

                    $('#sel-answerNoRight-popup .menu .item').remove();
                    $('#sel-answerNoRight-popup .menu').html('<div class="item" data-value="">全部</div>');
                    $('#sel-answerNoRight-popup').dropdown('refresh');
                    $('#sel-answerNoRight-popup').dropdown('set selected', '');
                } else {
                    return getPopupAnswerNo(paperId);
                }
            };

            //获得答题卡
            var getPopupAnswerNo = function (paperId) {

                var type = $('#type-popup').val();

                var d = $.Deferred().resolve();

                var LeftSelector = '#sel-answerNoLeft-popup';
                var RightSelector = '#sel-answerNoRight-popup';
                $(LeftSelector + ' .menu .item').remove();
                $(RightSelector + ' .menu .item').remove();
                return $.get('/console/markException/ansCardInfo', {
                    paperId: paperId,
                    type: type
                })
                        .then(function (data) {
                            var html = '<div class="item" data-value="">全部</div>';
                            for (var i = 0; i < data.length; i++) {
                                var answer = data[i].anscardId;
                                var num = answer.substring(answer.length - 1, answer.length);
                                html += '<div class="item" data-value="' + data[i].anscardId + '">第   ' + num + '   页</div>';
                            }
                            $(LeftSelector + ' .menu').html(html);
                            $(RightSelector + ' .menu').html(html);
                            return d.promise();
                        }).then(function () {
                            $('#sel-answerNoLeft-popup').dropdown('refresh');
                            $('#sel-answerNoLeft-popup').dropdown('set selected', '');

                            $('#sel-answerNoRight-popup').dropdown('refresh');
                            $('#sel-answerNoRight-popup').dropdown('set selected', '');
                            $(LeftSelector).dropdown('setting', 'onChange', leftAnswerNoPopupChange);
                            $(RightSelector).dropdown('setting', 'onChange', rightAnswerNoPopupChange);
                            return d.promise();
                        });
            }

            var rightAnswerNoPopupChange = function () {
                var right = $('#answerNoRight-popup').val();
                var rightLast = right.substring(right.length - 1, right.length);
                var left = right.substring(0, right.length - 1);
                if (rightLast % 2 == 0) {
                    rightLast = rightLast - 1;
                } else {
                    rightLast = parseInt(rightLast) + 1;
                }
                $('#sel-answerNoLeft-popup').dropdown('refresh');
                $('#sel-answerNoLeft-popup').dropdown('set selected', left + rightLast);
            }
            var leftAnswerNoPopupChange = function () {
                var left = $('#answerNoLeft-popup').val();
                var leftLast = left.substring(left.length - 1, left.length);
                var right = left.substring(0, left.length - 1);
                if (leftLast % 2 == 0) {
                    leftLast = leftLast - 1;
                } else {
                    leftLast = parseInt(leftLast) + 1;
                }
                $('#sel-answerNoRight-popup').dropdown('refresh');
                $('#sel-answerNoRight-popup').dropdown('set selected', right + leftLast);

            };

            //获取默认试卷信息
            getDefaultPaper()
                    .then(getPopupGroup)
                    .then(function () {
                        return getPopupPaper();
                    }).then(function () {
                defaultPaper = null;
            });

            if (!(path.indexOf("empty") > -1)) {
                showErrorOnPopup2("无需重新选择答题卡信息，请重新选择异常解决方案");
            }
        }

        //选做题异常显示界面
        function showChooseDo() {
            $('#sel-message-popup').hide();
            $('#sel-message2-popup').hide();
            var id = $('#id-popup').val();
            var paperId = $('#paperId-popup').val();
            var number = $('#number-popup').val();
            var updateTime = $('#updateTime-popup').val();
            var path = $('#path-popup').val();
            var originalAnsCardId = $('#originalAnsCard-popup').val();
            var ansImgId = $('#ansImgId-popup').val().replace(".jpg", "");
            var questionImgId = $('#questionImgId-popup').val();
            var question = $('#question-popup').val();
            var path = path.replace('backup/', '');
            var subjectName = $('#subjectName-popup').val();

            var buttonHtml = '<button class="fluid ui button"  onclick="updateChooseDoException()">确认修改 </button>';
            $('#update-button').html(buttonHtml);

            $('#sel-prompt-popup').hide();
            $('#sel-fireWork-popup').hide();
            $('#sel-chooseDo-popup').show();

            $('#sel-button-popup').show();
            var d = $.Deferred().resolve();
            $.get('/console/markException/selectChooseDo', {
                answerNo: originalAnsCardId,
                question: question
            }, function (data, state) {
                var pointSelector = '#sel-picture-popup';
                $(pointSelector + ' img').remove();
                var questionImgIdArray = questionImgId.split(",");
                var pictureHtml = '';
                for (var i = 0; i < questionImgIdArray.length; i++) {
                    pictureHtml += '<img alt= "图片" style="width:750px;height=400px;" src="${ctxStatic}' + '/answer' + path + 'rotated' + '/' + paperId + '/' + number + '/' + ansImgId + '/' + questionImgIdArray[i] + '.jpg' + '"/>';
                }
                $(pointSelector).html(pictureHtml);
                if (data.length == 0) {

                    showErrorOnPopup2("非选做题选择错误！请重新选择异常解决方案");
                    $('#chooseDo-label').hide();
                } else {
                    $('#sel-message2-popup').hide();
                    $('#chooseDo-label').show();
                    var selector = '#choose-do';
                    var html = '';
                    for (var i = 0; i < data.length; i++) {
                        html += '<div class="ui radio checkbox" style="margin-right: 30px;">' + '<input type="radio" value="' + data[i] + '" name="attribute">' +
                                '<label>' + data[i] + '</label>' + '</input>' + '</div>';
                    }
                    $(selector).html(html);
                    return d.promise();
                }
            })
        }

        //无法看到学生答案显示界面
        function seeDetailMarkException() {
            $('#sel-message-popup').hide();
            var testId = $('#testId-popup').val();
            var paperId = $('#paperId-popup').val();
            var number = $('#number-popup').val();
            var path = $('#path-popup').val();
            var questionImgId = $('#questionImgId-popup').val();
            var ansImgId = $('#ansImgId-popup').val();
            var imgEmptyFlag = $('#imgEmptyFlag-popup').val();

            var html = '<p>' + ' 考试号 :   ' + (testId) + '</p>' + '</br>';
            html += '<p>' + ' 学生号 :   ' + (number) + '</p>' + '</br>';
            html += '<p>' + ' 试卷号 :  ' + (paperId) + '</p>' + '</br>';
            html += '<p>' + ' 试题图片 :   ' + (questionImgId) + '.jpg' + '</p>' + '</br>';
            html += '<p>' + ' 原始切图 :   ' + (ansImgId) + '' + '</p>' + '</br>';
            html += '<p>' + ' 图片路径 :   ' + (path) + '</p>' + '</br>';
            html += '<p style="color: red">' + '<i class="star icon"></i>' + ' 其他异常错误! 请点击保存!由管理员处理!  ' + '</p>' + '</br>';

            $('#prompt-message').html(html);


            var ansImgId = ansImgId.replace(".jpg", "");
            var path = path.replace('backup/', '');
            var pointSelector = '#sel-picture-popup';
            $(pointSelector + ' img').remove();
            var questionImgIdArray = questionImgId.split(",");
            var pictureHtml = '';
            for (var i = 0; i < questionImgIdArray.length; i++) {
                pictureHtml += '<img alt= "图片" style="width:750px;height=400px;" src="${ctxStatic}' + '/answer' + path + 'rotated' + '/' + paperId + '/' + number + '/' + ansImgId + '/' + questionImgIdArray[i] + '.jpg' + '"/>';
            }
            $(pointSelector).html(pictureHtml);
            $('#sel-message2-popup').hide();
            $('#sel-prompt-popup').show();
            $('#sel-fireWork-popup').hide();
            $('#sel-chooseDo-popup').hide();
            $('#sel-button-popup').hide();
            if (imgEmptyFlag == 1) {
                $('#revoke-button2').show();
                $('#delete-button2').show();
                $('#submit-button').hide();
            } else {
                $('#revoke-button2').hide();
                $('#delete-button2').hide();
                $('#submit-button').show();
            }
        }

        //保存 答案颠倒异常 修改后试题信息
        function updateChooseDoException() {
            var testId = $('#testId-popup').val();
            var number = $('#number-popup').val();
            var paperId = $('#paperId-popup').val();
            var question = $('#question-popup').val();
            var subjectId = $('#subject-popup').val();
            var attribute = $('#choose-do input[name="attribute"]:checked').val();
            var id = $('#id-popup').val();
            var errorId = $('#error-type input[name="errorType"]:checked').val();
            var updateTime = $('#updateTime-popup').val();
            var originalAnsCardId = $('#originalAnsCard-popup').val();

            if (attribute == undefined) {
                showErrorOnPopup("请选择试题,或重新选择异常处理方案");
                return;
            }

            $.post('/console/markException/updateChooseDoException', {
                number: number,
                paperId: paperId,
                testId: testId,
                question: question,
                subjectId: subjectId,
                attribute: attribute,
                id: id,
                errorId: errorId,
                updateTime: updateTime,
                originalAnsCardId: originalAnsCardId
            }, function (data, state) {
                if (data == 2) {
                    showErrorOnPopup("非选做题选择错误！请重新选择异常解决方案")
                } else if (data == 3) {
                    $('.ui.second.modal').modal('hide');
                    var pageNo = $('#currentPage').val();
                    queryData(pageNo);
                } else {
                    $('.ui.second.modal').modal('hide');
                }
            });
        }

        //保存批阅异常中答案与科目不符错误
        function updateFireWorkException() {
            var id = $('#id-popup').val();
            var number = $('#number-popup').val();
            var paperId = $('#paper-popup').val();
            var pageSize = $('#pageNum-popup').val();
            if (pageSize == 2) {
                var leftAnswerNo = $('#answerNoLeft-popup').val();
                var rightAnswerNo = $('#answerNoRight-popup').val();
                var answerNo = leftAnswerNo + ";" + rightAnswerNo;
            } else {
                var leftAnswerNo = $('#answerNoLeft-popup').val();
                var answerNo = $('#answerNoLeft-popup').val();
            }
            var originalAnsCardId = $('#originalAnsCard-popup').val();
            var ansImgId = $('#ansImgId-popup').val();
            var errorId = $('#error-type input[name="errorType"]:checked').val();
            var testId = $('#testId-popup').val();
            var test = $('#test-popup').val();
            var updateTime = $('#updateTime-popup').val();
            var path = $('#path-popup').val();

            if (paperId.length == 0) {
                showErrorOnPopup("请选择试卷,或重新选择异常处理方案");
                return;
            }
            if ((pageSize == 1) && (leftAnswerNo.length == 0)) {
                showErrorOnPopup("请选择答题卡");
                return;
            }

            if (pageSize == 2) {
                if (leftAnswerNo.length == 0 && rightAnswerNo.length != 0) {
                    showErrorOnPopup('请选择左答题卡');
                    return;
                }
                else if (leftAnswerNo.length != 0 && rightAnswerNo.length == 0) {
                    showErrorOnPopup('请选择右答题卡');
                    return;
                } else if (leftAnswerNo.length == 0 && rightAnswerNo.length == 0) {
                    showErrorOnPopup('请选择答题卡');
                    return;
                }
            }

            if (pageSize == 2) {
                var left = (leftAnswerNo.substring(leftAnswerNo.length - 1, leftAnswerNo.length)) / 2
                var right = (rightAnswerNo.substring(rightAnswerNo.length - 1, rightAnswerNo.length)) / 2
                var LeftLast = Math.ceil(left);
                var RightLast = Math.ceil(right);
                if (left == right) {
                    showErrorOnPopup('请选择不同答题卡');
                    return;
                }
                if (LeftLast != RightLast) {
                    showErrorOnPopup('请选择相邻答题卡');
                    return;
                }
            }

            $.post('/console/markException/updateFireWorkException', {
                testId: testId,
                id: id,
                number: number,
                paperId: paperId,
                answerNo: answerNo,
                ansImgId: ansImgId,
                pageSize: pageSize,
                originalAnsCardId: originalAnsCardId,
                errorId: errorId,
                test: test,
                updateTime: updateTime,
                path: path
            }, function (data, state) {
                if (data == 3) {
                    $('.ui.second.modal').modal('hide');
                    var pageNo = $('#currentPage').val();
                    queryData(pageNo);
                } else if (data == 4) {
                    showErrorOnPopup("无需重新选择答题卡信息，请重新选择异常解决方案");
                } else {
                    $('.ui.second.modal').modal('hide');
                }
            })
        }

        function updateException() {
            showErrorOnPopup("请选择异常解决方案");

        }

        //撤销批阅异常
        function revokeMarkException() {
            var id = $('#id-popup').val();
            var paperId = $('#paperId-popup').val();
            var number = $('#number-popup').val();
            var testId = $('#testId-popup').val();
            var subjectId = $('#subject-popup').val();
            var originalAnsCardId = $('#originalAnsCard-popup').val();
            var updateTime = $('#updateTime-popup').val();
            var errorId = $('#error-type input[name="errorType"]:checked').val();
            $.post('/console/markException/revokeMarkException', {
                id: id,
                errorId: errorId,
                paperId: paperId,
                number: number,
                testId: testId,
                subjectId: subjectId,
                originalAnsCardId: originalAnsCardId,
                updateTime: updateTime
            }, function (data, state) {
                $('.ui.second.modal').modal('hide');
                if (data == 3) {
                    //刷首页
                    var pageNo = $('#currentPage').val();
                    queryData(pageNo);
                }
            })
        }

        //删除批阅异常
        function deleteDetailMarkException() {
            var id = $('#id-popup').val();
            var paperId = $('#paperId-popup').val();
            var number = $('#number-popup').val();
            var testId = $('#testId-popup').val();
            var originalAnsCardId = $('#originalAnsCard-popup').val();
            var updateTime = $('#updateTime-popup').val();
            $.post('/console/markException/deleteDetailMarkException', {
                testId: testId,
                id: id,
                paperId: paperId,
                number: number,
                originalAnsCardId: originalAnsCardId,
                updateTime: updateTime
            }, function (data, state) {
                $('.ui.second.modal').modal('hide');
                if (data == 3) {
                    //刷新首页
                    var pageNo = $('#currentPage').val();
                    queryData(pageNo);
                }
            })
        }

        //无法看到学生答案时操作
        function updateImgEmptyFlag() {
            var id = $('#id-popup').val();
            var updateTime = $('#updateTime-popup').val();
            $.get('/console/markException/updateImgEmptyFlag', {
                id: id,
                updateTime: updateTime
            }, function (data, state) {
                $('.ui.second.modal').modal('hide');
            })
        }

        //以下皆为通用函数(转圈圈，错误信息提示等)
        function showLoading() {
            $('#dimmer').addClass('active');
        }

        function hideLoading() {
            $('#dimmer').removeClass('active');
        }

        function showSecondPopupLoading() {
            $('.ui.second.modal').dimmer('show');
        }

        function hideSecondPopupLoading() {
            $('.ui.second.modal').dimmer('hide');
        }

        function showFirstPopupLoading() {
            $('.ui.first.modal').dimmer('show');
        }

        function hideFirstPopupLoading() {
            $('.ui.first.modal').dimmer('hide');
        }

        function showErrorOnPopup(msg) {
            $('#sel-message-popup').html(msg);
            $('#sel-message-popup').show();
            $('#sel-message-popup').delay(5000).hide(0);
        }

        function showErrorOnPopup2(msg) {
            $('#sel-message2-popup').html(msg);
            $('#sel-message2-popup').show();
            $('#sel-message2-popup').delay(500000).hide(0);
        }

        function showError(msg) {
            $('#error-message').html(msg);
            $('#error-message').show();
            $('#error-message').delay(5000).hide(0);
        }
        //以上皆为通用函数(转圈圈，错误信息提示等)

    </script>
    <title>DKP管理</title>
</head>
<body>
<a href="${ctxStatic}/const/task_progress.xls" download="task_progress.xls" hidden><span id="a-export">运行导出</span></a>
<div style="padding:0px 80px 20px 80px">
    <%@include file="../include/navi_menu.jspf" %>
    <div class="ui negative message" style="display:none" id="error-message">
    </div>

    <div class="ui form">
        <div class="ui error message hide"></div>
        <div class="fields">
            <div class="field">
                <div class="ui search selection dropdown" id="sel-game">
                    <input id="game" name="game" type="hidden"/>
                    <i class="dropdown icon"></i>
                    <div class="default text">选择游戏</div>
                    <div class="menu">
                        <c:forEach items="${gameInfoList}" var="game">
                            <div class="item" data-value="${game.id}">${game.gameName}</div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            <div class="field">
                <div class="ui selection dropdown" id="sel-union">
                    <input id="union" name="union" type="hidden"/>
                    <i class="dropdown icon"></i>
                    <div class="default text">选择工会</div>
                    <div class="menu">
                    </div>
                </div>
            </div>
            <div class="field">
                <div class="ui selection dropdown" id="sel-team">
                    <input id="team" name="team" type="hidden"/>
                    <i class="dropdown icon"></i>
                    <div class="default text">选择团队</div>
                    <div class="menu">
                    </div>
                </div>
            </div>
            <div class="field">
                <div class="ui selection dropdown" id="sel-activity">
                    <input id="activity" name="activity" type="hidden"/>
                    <i class="dropdown icon"></i>
                    <div class="default text">选择活动</div>
                    <div class="menu">
                    </div>
                </div>
            </div>
            <div class="ui submit button" id="btn-query">
                查询
            </div>
        </div>
    </div>

    <div class="ui divider"></div>

    <input type="hidden" value="1" id="currentPage"/>

    <div id="no-data" style="display:none">NO DATA</div>

    <table class="ui celled compact table" style="display:none" id="tbl-data">
        <thead>
        <tr>
            <th>游戏名称</th>
            <th>工会名称</th>
            <th>团队名称</th>
            <th>工会活动</th>
            <th>团队成员</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
        <tfoot>
        <tr>
            <th colspan="10">
                <div class="ui right floated pagination menu" id="paging">
                    <a class="icon item disabled">
                        <i class="angle left icon"></i>
                    </a>
                    <a class="item">1</a>
                    <a class="icon item">
                        <i class="angle right icon"></i>
                    </a>
                </div>
            </th>
        </tr>
        </tfoot>
    </table>
</div>
<div class="ui first coupled modal" style="z-index: -1;width: 1000px;">
    <i class="close icon"></i>
    <div class="header">
        批阅异常详细列表
    </div>
    <input type="hidden" value="1" id="currentPage-popup"/>
    <div id="no-data-detail" style="display:none">NO DATA</div>
    <div class="content">
        <table class="ui celled compact table" style="display:none" id="tbl-data-detail">
            <thead>
            <tr>
                <th>考试号</th>
                <th>图片名称</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
            <tfoot>
            <tr>
                <th colspan="10">
                    <div class="ui right floated pagination menu" id="detailPaging">
                        <a class="icon item disabled">
                            <i class="angle left icon"></i>
                        </a>
                        <a class="item">1</a>
                        <a class="icon item">
                            <i class="angle right icon"></i>
                        </a>
                    </div>
                </th>
            </tr>
            </tfoot>
        </table>
        <div class="ui page inverted dimmer">
            <div class="ui loader"></div>
        </div>
    </div>
</div>

<div class="ui second coupled modal" style="width:1250px;  height:1000px;">
    <i class="close icon"></i>
    <div class="header" style="margin-top: 20px;margin-bottom: 30px">
        <h2>批阅异常处理</h2>
    </div>
    <div class="content">
        <div id="left" style="float:left ; width:65% ; height:100% ;">
            <div id="sel-picture-popup" name="sel-picture-popup" class="zoom">

            </div>

            <div id="sel-exception-popup" name="sel-exception-popup">

            </div>
        </div>


        <div id="right" style="float:right ; width:35% ; height:100%;border-left: 2px;">

            <div class="ui form" style="margin-bottom: 20px;" id="error-type">
                <div class="grouped fields">
                    <label><h3>异常信息</h3></label>
                    <div class="field" style="margin-bottom: 20px;">
                        <div class="fields">
                            <div class="five wide field" id="sel-subject-popup">

                            </div>
                        </div>
                    </div>

                    <div class="field" style="margin-bottom: 20px;">
                        <div class="fields">
                            <div class="nine wide field" id="sel-question-popup">

                            </div>
                        </div>
                    </div>
                    <label><h3>异常解决方案</h3></label>
                    <div class="field">
                        <div class="ui radio checkbox" style="margin-bottom: 30px;margin-top: 10px">
                            <input type="radio" name="errorType" onclick="showChooseDo()" value="1">
                            <label>选做题重新选择</label>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui radio checkbox" style="margin-bottom: 30px;">
                            <input type="radio" name="errorType" onclick="showMarkException()" value="2">
                            <label>答题卡信息重新选择</label>
                        </div>
                    </div>
                    <div class="field">
                        <div class="ui radio checkbox" style="margin-bottom: 30px;">
                            <input type="radio" name="errorType" id="errorType" onclick="seeDetailMarkException()"
                                   value="3">
                            <label>其他异常错误！请上报管理员</label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="ui form" style="margin-bottom: 20px">
                <div class="fields">

                    <div class="ui negative message" style="display:none" id="sel-message2-popup">

                    </div>
                </div>
            </div>

            <%--选做题异常--%>
            <div class="ui form" style="margin-bottom: 80px" id="sel-chooseDo-popup">
                <div class="inline fields" style="margin-top: 10px;margin-bottom: 60px;">
                    <label><h3 id="chooseDo-label">选做题试题重新选择</h3></label>
                </div>
                <div class="grouped  fields" id="choose-do">

                </div>
            </div>

            <%--错误信息提示--%>
            <div class="ui form" style="margin-bottom: 100px" id="sel-prompt-popup">
                <div class="content">
                    <div id="prompt-message">

                    </div>
                    <div class="ui form">
                        <div class="fields">
                            <div class="six wide field" id="revoke-button2">
                                <button class="fluid ui button" onclick="revokeMarkException()">非批阅异常</button>
                            </div>
                            <div class="five wide field" id="delete-button2">
                                <button class="fluid ui button" onclick="deleteDetailMarkException()">确认放弃</button>
                            </div>
                            <div class="four wide field" id="submit-button">
                                <button class="fluid ui button" onclick="updateImgEmptyFlag()">提交</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%--重新切图部分--%>
            <div class="ui form" id="sel-fireWork-popup">
                <div class="ui form" style="margin-bottom: 60px">
                    <div class="field">
                        <label><h3>试卷组选择</h3></label>
                        <div class="field" style="margin-top: 10px">
                            <div class="ui disabled selection dropdown" id="sel-group-popup">
                                <input id="group-popup" name="group-popup" type="hidden"/>
                                <i class="dropdown icon"></i>
                                <div class="default text">选择试卷组</div>
                                <div class="menu">

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="ui form" style="margin-bottom: 60px">
                    <div class="field">
                        <label><h3>试卷选择</h3></label>
                        <div class="field" style="margin-top: 10px">
                            <div class="ui selection dropdown" id="sel-paper-popup">
                                <input id="paper-popup" name="paper-popup" type="hidden"/>
                                <i class="dropdown icon"></i>
                                <div class="default text">选择试卷</div>
                                <div class="menu">

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="ui form">
                    <div class="field">
                        <label><h3>答题卡选择</h3></label>
                        <div class="two fields" style="margin-top: 10px">
                            <div class="field">
                                <div class="ui selection dropdown" id="sel-answerNoLeft-popup">
                                    <input id="answerNoLeft-popup" name="answerNoLeft-popup" type="hidden"/>
                                    <i class="dropdown icon"></i>
                                    <div class="default text">选择左答题卡</div>
                                    <div class="menu">
                                    </div>
                                </div>
                            </div>
                            <div class="field" id="sel-right">
                                <div class="ui selection dropdown" id="sel-answerNoRight-popup">
                                    <input id="answerNoRight-popup" name="answerNoRight-popup" type="hidden"/>
                                    <i class="dropdown icon"></i>
                                    <div class="default text">选择右答题卡</div>
                                    <div class="menu">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%--按钮区域--%>
            <div class="ui form" style="margin-top: 80px;" id="sel-button-popup">
                <div class="fields">
                    <div class="five wide field" id="update-button">
                        <button class="fluid ui button" onclick="updateException()">确认修改</button>
                    </div>
                    <div class="six wide field" id="revoke-button">
                        <button class="fluid ui button" onclick="revokeMarkException()">非批阅异常</button>
                    </div>
                    <div class="five wide field" id="delete-button">
                        <button class="fluid ui button" onclick="deleteDetailMarkException()">确认放弃</button>
                    </div>
                </div>
            </div>

            <%--错误信息提示--%>
            <div class="ui form" style="margin-top: 10px;">
                <div class="fields">

                    <div class="ui negative message" style="display:none" id="sel-message-popup">

                    </div>
                </div>
            </div>
        </div>
        <div class="ui page inverted dimmer">

        </div>
    </div>
</div>

<div class="ui page inverted dimmer" id="dimmer">
    <div class="ui loader"></div>
</div>
</body>
</html>
