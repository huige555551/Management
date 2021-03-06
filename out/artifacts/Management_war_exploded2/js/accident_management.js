$(document).ready(function(){
    initTable();
    vadidateModal();
    initSelect();
    $('#search_text').keydown(function (e) {
        if (e.keyCode === 13) {
            $('#search_btn').click();
        }
    });
    $('.datetimepicker').datetimepicker({
        autoclose: true,
        clearBtn: true,
        language: 'zh-CN',
        orientation: 'bottom',
        todayHighlight: true
    })
});
function addAccident() {
    $('#add_accident_form').data('bootstrapValidator').validate();
    if(!$('#add_accident_form').data('bootstrapValidator').isValid()){
        return ;
    }
    $('#add_modal').modal('hide');
    var order_number = $('#add_order_number').val();
    var time = $('#add_time').val();
    var place = $('#add_place').val();
    var type = $('#add_type').val();
    var data = {
        "order_number": order_number,
        "time": time,
        "place": place,
        "type": type
    };
    $.ajax({
        type: "post",
        url: "addAccidentServlet",
        data: data,
        dataType: "json",
        async: false,
        success: function(json) {
            if(parseInt(json.code) === 1) {
                alert("添加失败！");
            }
            else {
                alert("添加成功！");
            }
        }
    });
    $('#accident_info').bootstrapTable('refresh');
    resetModal();
}
function searchAccident() {
    var order_number = $("#search_text").val();
    var data = {
        "order_number": order_number
    };
    $.ajax({
        type: "post",
        url: "searchAccidentServlet",
        data: data,
        dataType: "json",
        success: function(json){
            $('#accident_info').bootstrapTable('load', json);
        }
    });
    $('#search_text').val('');
}
function initTable() {
    $('#accident_info').bootstrapTable('destroy');
    $("#accident_info").bootstrapTable({
        //使用post请求到服务器获取数据
        method: "post",
        //获取数据的Servlet地址
        url: "accidentServlet",
        //表格显示条纹
        striped: true,
        //启动分页
        pagination: true,
        //每页显示的记录数
        pageSize: 20,
        //记录数可选列表
        pageList: [10, 15, 20, 25, 30],
        //是否启用查询
        search: false,
        //显示下拉框勾选要显示的列
        showColumns: true,
        //显示刷新按钮
        showRefresh: true,
        //设置是由客户端分页还是由服务端分页
        sidePagination: "client",
        columns: [{
            field: 'order_number',
            title: '订单编号',
            sortable: true
        }, {
            field: 'time',
            title: '事故时间',
            editable: {
                title: '输入事故时间',
                type: 'text',
                validate: function(v) {
                    if (!v) {
                        return '事故时间不能为空';
                    }
                }
            }
        }, {
            field: 'place',
            title: '事故地点',
            editable: {
                title: '输入事故地点',
                type: 'text',
                validate: function(v) {
                    if (!v) {
                        return '事故地点不能为空';
                    }
                }
            }
        },{
            field: 'type',
            title: '事故类型',
            type: 'text',
            editable: {
                title: '输入事故类型',
                type: 'text',
                validate: function(v) {
                    if (!v) {
                        return '事故类型不能为空';
                    }
                }
            }
        }, {
            field: 'button',
            title: '操作',
            events: operateEvents = {
                'click #delete_button': function (e, value, row) {
                    var data = {
                        "order_number": row.order_number
                    };
                    $.ajax({
                        type: "post",
                        url: "deleteAccidentServlet",
                        data: data,
                        dataType: "json",
                        success: function(json){
                            if(parseInt(json.code) === 1) {
                                alert("删除失败！");
                            }
                            else {
                                alert("删除成功！");
                                $('#accident_info').bootstrapTable('refresh');
                            }
                        }
                    });
                }
            },
            formatter: function () {
                return ['<button id="delete_button" class="btn btn-default">删除</button>'].join('');
            }
        }],
        onEditableSave: function(field, row) {
            // row.accident_time = getFormatTime();
            var data = {
                "order_number": row.order_number,
                "time": row.time,
                "place": row.place,
                "type": row.type
            };
            $.ajax({
                type: "post",
                url: "updateAccidentServlet",
                data: data,
                dataType: "json",
                async: false,
                success: function(json) {
                    if(parseInt(json.code) === 1) {
                        alert("更改失败！");
                    }
                    else {
                        alert("更改成功！");
                    }
                }
            });
        }
    });
}

function initSelect() {
    $.ajax({
        type: "post",
        url: "orderServlet",
        dataType: "json",
        success: function (json) {
            var html = '';
            $.each(json, function (key, value) {
                html += '<option value="' + value.order_number + '">' + value.order_number + '</option>';
            });
            $('#add_order_number').html(html);
            $('#add_order_number').selectpicker('refresh');
        }
    });
}

function vadidateModal() {
    $('#add_accident_form').bootstrapValidator({
        feedbackIcons: {
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            time: {
                validators: {
                    notEmpty: {
                        message: '违约时间不能为空'
                    }
                }
            },
            place: {
                validators: {
                    notEmpty: {
                        message: '违约地点不能为空'
                    }
                }
            },
            type: {
                validators: {
                    notEmpty: {
                        message: '违约类型不能为空'
                    }
                }
            }
        }
    });
}
function resetModal() {
    $('#add_accident_form').find('input').val('');
    $('#add_accident_form').data('bootstrapValidator').destroy();
    $('#add_accident_form').data('bootstrapValidator', null);
    $('#add_order_number').selectpicker('refresh');
    vadidateModal();
}