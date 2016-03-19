 //原始json資料
 var responseJson = [];
 // 解析後放入datatable
 var praseJsonNodeData = [];
 var praseJsonScheduleData = [];
 // var dataSet = [
 //     ["Tiger Nixon", "System Architect", "Edinburgh", "5421", "2011/04/25", "$320,800"],
 //     ["Garrett Winters", "Accountant", "Tokyo", "8422", "2011/07/25", "$170,750"],
 //     ["Ashton Cox", "Junior Technical Author", "San Francisco", "1562", "2009/01/12", "$86,000"],
 // ];
 var tableSelectNode = [];
 var tableSelectSchedule = [];

 var submitScheduleNode = [
     []
 ];


 var nodeUrl = "../api/V1/node/";
 var scheduleUrl = "../api/V1/schedule/";

 $(document).ready(function() {
     // InitInputItem
     initInputItem();
     // get the scheduleUrl data by RESTful and show data in NodeSchedule
     praseJsonScheduleData = get_NodeSchedule(scheduleUrl);
     // get the nodeUrl data by RESTful and show data in NodeList
     praseJsonNodeData = get_AllNodeList(nodeUrl);

     // delete schedule
     delete_NodeSchedule(scheduleUrl);

     // select node for schedule
     action_SelectNode();
     // select time and date.
     action_DateTime();
     // 確認是否填完排程資料
     check_submitNodeData();
     // 上傳排程資料
     post_submitNodeData(scheduleUrl);
     //delete_NodeSchedule(nodeUrl);

 });


 function initInputItem() {
     $('#SelectNodeName').val("");
     $('#SelectNodeApp').val("");
     $("#selectDateTime").val("");
     $("#datepicker").val("");
     $("#timepicker").val("");
 }

 function get_NodeSchedule(scheduleUrl) {
     var NodeSchedule = [];
     $.ajax({
         url: scheduleUrl,
         // test 
         // url: "schedule.json",
         dataType: "json",
         success: function(response) {
             responseJson = response;
             console.log(responseJson);
             // UTC time to local time.

             for (var index = 0; index < responseJson.length; index++) {
                 var jsonToDateString = responseJson[index].triggerTime.toString();
                 var date = new Date(jsonToDateString)

                 var tmp = [responseJson[index].TaskID.toString(), responseJson[index].NodeID.toString(), date.toLocaleString(),
                     responseJson[index].Commend.toString(), responseJson[index].completed.toString()
                 ];
                 console.log(tmp);
                 NodeSchedule.push(tmp)


             }
             // display data
             showScheduleTable(NodeSchedule)
         },
         error: function(response) {
             console.log("error");
         }
     });

     function showScheduleTable(data) {

         tableSelectSchedule = $('#tableScheduleView').DataTable({
             responsive: true,
             destroy: true,
             data: data,
             pageLength: 5,
             paging: false,
             columns: [{
                 title: "任務#"
             }, {
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
 }


 function delete_NodeSchedule(scheduleUrl) {

     var SelectScheduleData = [];
     //點選節點表單，選則對應節點功能
     $('#tableScheduleView tbody').on('click', 'tr', function() {
         // SelectNodeData = {}
         SelectScheduleData = tableSelectSchedule.row(this).data();
         console.log(SelectScheduleData);

         $('#SelectSchedule').text("刪除任務: " + SelectScheduleData[0]);

     });

     $('#btnDeleteSchedule').click(function(event) {
         var PostData = '{ "TaskID" : ' + SelectScheduleData[0] + '}';
         console.log(PostData);
         $.ajax({
             url: scheduleUrl,
             headers: {
                 "Content-Type": "application/json"
             },
             type: "DELETE",
             data: PostData,
             success: function(response) {
                 console.log(response);
                 $('html, body').animate({
                     scrollTop: 0
                 }, 'slow');
                 window.location.reload();

             },
             error: function(response) {
                 console.log("error");
             }
         });
     });

 }


 function get_AllNodeList(nodeUrl) {
     var NodeTable = [];
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
                 NodeTable.push(tmp)
             }
             // display data
             showNodeTable(NodeTable)
         },
         error: function(response) {
             console.log("error");
         }
     });

     function showNodeTable(data) {
         tableSelectNode = $('#tableNodeSelect').DataTable({
             responsive: true,
             destroy: true,
             data: data,
             pageLength: 5,
             bAutoWidth: false,
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
                 title: "預估電費"
             }]
         });
     }
 }

 function action_SelectNode() {
     //點選節點表單，選則對應節點功能
     $('#tableNodeSelect tbody').on('click', 'tr', function() {
         // SelectNodeData = {}
         SelectNodeData = tableSelectNode.row(this).data();
         //console.log(SelectNodeData);

         $('#SelectNodeName').val(SelectNodeData[0]);
         $('#SelectNodeApp').val(SelectNodeData[2]);

         // 確認節點類型後，展示對應開關介面
         if (SelectNodeData[1] == "N" || SelectNodeData[1] == "IR") {
             $('#NodeNSwitch').show();
             $('#NodeLSwitch').hide();
         } else if (SelectNodeData[1] == "L") {
             $('#NodeNSwitch').hide();
             $('#NodeLSwitch').show();
         } else {}
     });
 }

 function action_DateTime() {
     // 日期顯示繁中
     $("#datepicker").datepicker($.datepicker.regional["zh-TW"]);
     $('#timepicker').timepicker({
         'scrollDefault': 'now'
     });

     // 觸發事件
     $("#datepicker").change(function(event) {
         checkScheduleTimeDate();
     });
     $("#timepicker").change(function(event) {
         checkScheduleTimeDate();
     });

     function checkScheduleTimeDate() {
         if ($("#datepicker").val() != "" && $("#timepicker").val() != "") {
             var tmp;
             tmp = $("#datepicker").val() + " " + $("#timepicker").val();
             $("#selectDateTime").val(tmp);
         }
     }
 }


 function check_submitNodeData() {
     $("#btnCheckSchedule").click(function(event) {
         // 如果都填完，開啟表單
         if ($("#SelectNodeName").val() != "" && $("#selectDateTime").val() != "") {
             // object array
             submitScheduleNode = [
                 []
             ];
             submitScheduleNode[0].push($('#SelectNodeName').val().toString());
             submitScheduleNode[0].push($('#selectDateTime').val().toString());
             if (SelectNodeData[1] == "N" || SelectNodeData[1] == "IR") {
                 if ($("#NodeN1Switch").prop('checked') == true) {
                     submitScheduleNode[0].push("1");
                 } else {
                     submitScheduleNode[0].push("0");
                 }
             } else if (SelectNodeData[1] == "L") {
                 var value = 0;
                 if ($("#NodeL1Switch").prop('checked') == true) {
                     value = value + 1;
                 }
                 if ($("#NodeL2Switch").prop('checked') == true) {
                     value = value + 2;
                 }
                 if ($("#NodeL3Switch").prop('checked') == true) {
                     value = value + 4;
                 }
                 submitScheduleNode[0].push(value.toString());

             } else {

             }

             console.log(submitScheduleNode);
             showSelectScheduleTable(submitScheduleNode);

         }
     });

     function showSelectScheduleTable(checkNodeScheduleData) {
         tableSelectSchedule = $('#tableScheduleSetting').DataTable({
             responsive: true,
             destroy: true,
             bFilter: false,
             bInfo: false,
             paging: false,
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
 }


 function post_submitNodeData(scheduleUrl) {
     $("#btnSubmitSchedule").click(function(event) {
         var nodeSubmitScheduleUrl = scheduleUrl + submitScheduleNode[0][0] + "/";
         // nodeSubmitScheduleUrl = "http://192.168.31.168:8000/api/V1/schedule/1/"
         console.log(nodeSubmitScheduleUrl);
         var sendcommend = '{"triggerTime": "' + submitScheduleNode[0][1] + ':00" , "State": ' + submitScheduleNode[0][2] + ' }';
         // example '{"triggerTime": "2016-01-19 08:38:15" , "State": 1 }'

         sendcommend = sendcommend.replace('/', '-');
         sendcommend = sendcommend.replace('/', '-');
         console.log(sendcommend);
         nodeSubmitSchedule(sendcommend, nodeSubmitScheduleUrl);

     });

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
                 $('html, body').animate({
                     scrollTop: 0
                 }, 'slow');
                 window.location.reload();
             },
             error: function(response) {
                 console.log("error");
             }
         });

     }
 }
