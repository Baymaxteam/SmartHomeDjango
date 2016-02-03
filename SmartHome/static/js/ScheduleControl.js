// 原始json資料
var responseJson = [];
// 解析後放入datatable
var praseJsonNodeData = [];
var praseJsonScheduleData = [];
var dataSet = [
    ["Tiger Nixon", "System Architect", "Edinburgh", "5421", "2011/04/25", "$320,800"],
    ["Garrett Winters", "Accountant", "Tokyo", "8422", "2011/07/25", "$170,750"],
    ["Ashton Cox", "Junior Technical Author", "San Francisco", "1562", "2009/01/12", "$86,000"],
];
var tableSelectNode = [];
var tableSelectSchedule = [];

var submitScheduleNode = [
    []
];

$(document).ready(function() {

    var nodeUrl = "http://192.168.31.168:8000/api/V1/node/";
    var scheduleUrl = "http://192.168.31.168:8000/api/V1/schedule/";
    var SelectNodeData = [];

    InitInputItem();
    // get the nodeUrl data by RESTful
    $.ajax({
        url: nodeUrl,
        dataType: "json",
        success: function(response) {
            responseJson = response;
            console.log(responseJson);

            for (var index = 0; index < responseJson.length; index++) {
                var tmp = [responseJson[index].ID.toString(), responseJson[index].Type,
                    responseJson[index].Appliances, responseJson[index].Group,
                    responseJson[index].State, responseJson[index].CurrentState.toString()
                ];
                console.log(tmp);
                praseJsonNodeData.push(tmp)
            }
            // display data
            showNodeTable();
        },
        error: function(response) {
            console.log("error");
        }
    });

    // get the scheduleUrl data by RESTful
    $.ajax({
        url: scheduleUrl,
        dataType: "json",
        success: function(response) {
            responseJson = response;
            console.log(responseJson);
            // UTC time to local time.

            for (var index = 0; index < responseJson.length; index++) {
                var jsonToDateString = responseJson[index].triggerTime.toString();
                var date = new Date(jsonToDateString)

                var tmp = [responseJson[index].NodeID.toString(), date.toLocaleString(),
                    responseJson[index].Commend, responseJson[index].completed.toString()
                ];
                console.log(tmp);
                praseJsonScheduleData.push(tmp)

                // console.log("test:");
                // console.log(date);
                // console.log(date.toLocaleString());
                // console.log(date.toISOString());
            }
            // display data
            showScheduleTable();
        },
        error: function(response) {
            console.log("error");
        }
    });



    // 日期顯示繁中
    $("#datepicker").datepicker($.datepicker.regional["zh-TW"]);
    $('#timepicker').timepicker({
        'scrollDefault': 'now'
    });

    $("#datepicker").change(function(event) {
        checkScheduleTimeDate();
    });
    $("#timepicker").change(function(event) {
        checkScheduleTimeDate();
    });

    //點選節點表單，選則對應節點功能
    $('#tableNodeSelect tbody').on('click', 'tr', function() {
        // SelectNodeData = {}
        SelectNodeData = tableSelectNode.row(this).data();
        //console.log(SelectNodeData);

        $('#SelectNodeName').val(SelectNodeData[0]);
        $('#SelectNodeApp').val(SelectNodeData[2]);

        // 確認節點類型後，展示對應開關介面
        if (SelectNodeData[1] == "N") {
            $('#NodeNSwitch').show();
            $('#NodeLSwitch').hide();
        } else if (SelectNodeData[1] == "L") {
            $('#NodeNSwitch').hide();
            $('#NodeLSwitch').show();
        } else {}
    });

    // 確認是否填完排程資料
    $("#btnCheckSchedule").click(function(event) {

        if ($("#SelectNodeName").val() != "" && $("#selectDateTime").val() != "") {
            // object array
            submitScheduleNode = [
                []
            ];
            submitScheduleNode[0].push($('#SelectNodeName').val().toString());
            submitScheduleNode[0].push($('#selectDateTime').val().toString());
            if (SelectNodeData[1] == "N") {
                if ($("#NodeN1Switch").prop('checked') == true) {
                    submitScheduleNode[0].push("1");
                } else {
                    submitScheduleNode[0].push("0");
                }
            } else if (SelectNodeData[1] == "L") {
                var value = 0;
                if ($("#NodeN1Switch").prop('checked') == true) {
                    value = value + 1;
                }
                if ($("#NodeN2Switch").prop('checked') == true) {
                    value = value + 2;
                }
                if ($("#NodeN3Switch").prop('checked') == true) {
                    value = value + 4;
                }
                submitScheduleNode[0].push(value.toString());

            } else {

            }

            console.log(submitScheduleNode);
            showSelectScheduleTable(submitScheduleNode);

        }
    });
    // 確認是否填完排程資料
    $("#btnSubmitSchedule").click(function(event) {
        var nodeSubmitScheduleUrl = "http://192.168.31.168:8000/api/V1/schedule/" + submitScheduleNode[0][0] + "/";
        //nodeSubmitScheduleUrl = "http://192.168.31.168:8000/api/V1/schedule/1/"
        console.log(nodeSubmitScheduleUrl);
        var test = '{"triggerTime": "2016-01-19 08:38:15" , "State": 1 }'
        var sendcommend = '{"triggerTime": "' + submitScheduleNode[0][1] + ':00" , "State": ' + submitScheduleNode[0][2] + ' }';
        sendcommend = sendcommend.replace('/', '-');
        sendcommend = sendcommend.replace('/', '-');
        console.log(sendcommend);
        nodeSubmitSchedule(sendcommend, nodeSubmitScheduleUrl);

        $('html, body').animate({
            scrollTop: 0
        }, 'slow');

    });

});


function InitInputItem() {
    $('#SelectNodeName').val("");
    $('#SelectNodeApp').val("");
    $("#selectDateTime").val("");
    $("#datepicker").val("");
    $("#timepicker").val("");
}

function checkScheduleTimeDate() {
    if ($("#datepicker").val() != "" && $("#timepicker").val() != "") {
        var tmp;
        tmp = $("#datepicker").val() + " " + $("#timepicker").val();
        $("#selectDateTime").val(tmp);
    }
}

function showNodeTable() {
    tableSelectNode = $('#tableNodeSelect').DataTable({
        responsive: true,
        data: praseJsonNodeData,
        pageLength: 5,
        columns: [{
            title: "ID"
        }, {
            title: "類型"
        }, {
            title: "應用"
        }, {
            title: "位置"
        }, {
            title: "狀態"
        }, {
            title: "電流"
        }]
    });

    $('#tableCurrentStatus').DataTable({
        responsive: true,
        data: praseJsonNodeData,
        columns: [{
            title: "ID"
        }, {
            title: "類型"
        }, {
            title: "應用"
        }, {
            title: "位置"
        }, {
            title: "狀態"
        }, {
            title: "電流"
        }]
    });
}

function showScheduleTable() {
    // if ($.fn.DataTable.fnIsDataTable('#tableScheduleView table')) {
    //     a = $('#tableScheduleView table').dataTable();
    //     a.fnClearTable();
    //     a.fnDestroy();
    //     $('#tableScheduleView table thead').empty()
    // };

    $('#tableScheduleView').DataTable({
        responsive: true,
        destroy: true,
        data: praseJsonScheduleData,
        pageLength: 5,
        columns: [{
            title: "ID"
        }, {
            title: "時間"
        }, {
            title: "命令"
        }, {
            title: "是否完成"
        }]
    });
}

function showSelectScheduleTable(checkNodeScheduleData) {
    // if ($.fn.DataTable.fnIsDataTable('#tableScheduleSetting table')) {
    //     a = $('#tableScheduleSetting table').dataTable();
    //     a.fnClearTable();
    //     a.fnDestroy();
    //     $('#tableScheduleSetting table thead').empty()
    // };


    tableSelectSchedule = $('#tableScheduleSetting').DataTable({
        responsive: true,
        destroy: true,
        data: checkNodeScheduleData,

        columns: [{
            title: "ID"
        }, {
            title: "時間"
        }, {
            title: "命令"
        }]
    });
}


function nodeSubmitSchedule(inputSchedule, nodeurl) {
    $.ajax({
        url: nodeurl,
        headers: {
            "Content-Type": "application/json"
        },
        type: "PUT",
        data: inputSchedule,
        success: function(response) {
            console.log(response);
        },
        error: function(response) {
            console.log("error");
        }
    });

}
