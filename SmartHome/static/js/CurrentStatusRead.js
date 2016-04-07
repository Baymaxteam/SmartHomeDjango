//Flot Line Chart

var statYearUrl = "../api/V1/bill/house/year/";
var statMonthUrl = "../api/V1/bill/house/month/";
var statDayUrl = "../api/V1/bill/house/day/";
var statNodeUrl = "../api/V1/node/";

var statNodeData = [
    ["1", "檯燈", "客廳", "1", "85"],
    ["2", "微波爐", "客廳", "1", "45"],
    ["3", "風扇", "客廳", "0", "50"],
    ["4", "風扇", "主臥室", "1", "21"],
    ["5", "檯燈", "主臥室", "1", "85"],
    ["6", "除濕機", "主臥室", "0", "35"],
    ["7", "主燈", "客廳", "0", "80"],
    ["8", "主燈", "主臥室", "2", "49"],
    ["9", "電視", "客廳", "ON", "33"]
];


var yearstatdata = {
    "Interval": "year",
    "data": [
        [
            1451606400000,
            546.199
        ],
        [
            1454284800000,
            511.042
        ],
        [
            1456790400000,
            541.042

        ],
        [
            1459468800000,
            546.199
        ],
        [
            1462060800000,
            746.199
        ],
        [
            1464739200000,
            786.199
        ],
        [
            1467331200000,
            806.199
        ],
        [
            1470009600000,
            846.199
        ],
        [
            1472688000000,
            646.199
        ],
        [
            1475280000000,
            576.199
        ],
        [
            1477958400000,
            546.199
        ],
        [
            1480550400000,
            100
        ]
    ]
};

var monthstatdata = {
    'Interval': 'month',
    'data': [
        [1454284800000.0, 17.657],
        [1454371200000.0, 17.651],
        [1454457600000.0, 17.638],
        [1454544000000.0, 17.624],
        [1454630400000.0, 17.593],
        [1454716800000.0, 20.605],
        [1454803200000.0, 17.651],
        [1454889600000.0, 17.589],
        [1454976000000.0, 20.632],
        [1455062400000.0, 17.602],
        [1455148800000.0, 17.652],
        [1455235200000.0, 34.606],
        [1455321600000.0, 17.634],
        [1455408000000.0, 17.598],
        [1455494400000.0, 23.666],
        [1455580800000.0, 17.614],
        [1455667200000.0, 17.62007316666667],
        [1455753600000.0, 17.649437666666664],
        [1455840000000.0, 40.622947833333335],
        [1455926400000.0, 17.59395366666667],
        [1456012800000.0, 17.55722833333333],
        [1456099200000.0, 12.666],
        [1456185600000.0, 17.666],
        [1456272000000.0, 17.666],
        [1456358400000.0, 20.666],
        [1456444800000.0, 17.666],
        [1456531200000.0, 17.666],
        [1456617600000.0, 17.666],
        [1456704000000.0, 17.666]
    ]
};

var daystatdata = {
    'Interval': 'day',
    'data': [

        [1456185600000, 15.9],
        [1456189200000, 20.3],
        [1456192800000, 14.4],
        [1456196400000, 21.1],
        [1456200000000, 21],
        [1456203600000, 15.9],
        [1456207200000, 16.9],
        [1456210800000, 15.9],
        [1456214400000, 17.9],
        [1456218000000, 15.9],
        [1456221600000, 13.9],
        [1456225200000, 15.9],
        [1456228800000, 11.1],
        [1456232400000, 23.1],
        [1456236000000, 24.1],
        [1456239600000, 21.1],
        [1456243200000, 24.5],
        [1456246800000, 21.1],
        [1456250400000, 21.1],
        [1456254000000, 16.5],
        [1456257600000, 24.5],
        [1456261200000, 22.5],
        [1456264800000, 16.5],
        [1456268400000, 16.5]

    ]
};


$(document).ready(function() {
    console.log("document ready");

    showMonthdata();
    showYeardata();
    get_Daydata(statDayUrl);
    get_AllNodeList(statNodeUrl);
});

// function showNodedata() {
//     $('#tableNodeStatus').DataTable({
//         bFilter: false,
//         paging: false,
//         responsive: true,
//         destroy: true,
//         data: statNodeData,

//         columns: [{
//             title: "ID"
//         }, {
//             title: "應用"
//         }, {
//             title: "位置"
//         }, {
//             title: "狀態"
//         }, {
//             title: "預估電費NTD(本日)"
//         }]
//     });
// }



function showDaydata() {

    var barOptions = {
        series: {
            bars: {
                show: true,
                barWidth: 2232000
            }
        },
        xaxis: {
            mode: "time",
            timeformat: "%I:%M %p",
            // timeformat: "%m/%d",
            // twelveHourClock: true,
            //minTickSize: [1, "day"]
            minTickSize: [1, "hour"]
        },
        yaxis: {
            axisLabel: "平均電費",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 2,
            tickFormatter: function(v, axis) {
                return "$" + v;
            }
        },
        grid: {
            hoverable: true
        },
        legend: {
            show: false
        },
        tooltip: true,
        tooltipOpts: {
            content: "x: %x, y: %y"
        }
    };
    var barData = {
        label: "bar",
        color: "#ff0000",
        data: daystatdata.data
    };

    $.plot($("#Day-bar-chart"), [barData], barOptions);

}

function showMonthdata() {

    var barOptions = {
        series: {
            bars: {
                show: true,
                barWidth: 42320000
            }
        },
        xaxis: {
            mode: "time",
            timeformat: "%m/%d",
            minTickSize: [1, "day"]
        },
        yaxis: {
            axisLabel: "平均電費",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 2,
            tickFormatter: function(v, axis) {
                return "$" + v;
            }
        },
        grid: {
            hoverable: true
        },
        legend: {
            show: false
        },
        tooltip: true,
        tooltipOpts: {
            content: "x: %x, y: %y"
        }
    };
    var barData = {
        label: "bar",
        color: "#40ff00",
        data: monthstatdata.data
    };

    $.plot($("#Month-bar-chart"), [barData], barOptions);

}

function showYeardata() {
    var barOptions = {
        series: {
            bars: {
                show: true,
                barWidth: 1232000000
            }
        },
        xaxis: {
            mode: "time",
            timeformat: "%m/%d",
            minTickSize: [1, "month"]
        },
        yaxis: {
            axisLabel: "平均電費",
            axisLabelUseCanvas: true,
            axisLabelFontSizePixels: 12,
            axisLabelFontFamily: 'Verdana, Arial',
            axisLabelPadding: 2,
            tickFormatter: function(v, axis) {
                return "$" + v;
            }
        },
        grid: {
            hoverable: true
        },
        legend: {
            show: false
        },
        tooltip: true,
        tooltipOpts: {
            content: "x: %x, y: %y"
        }
    };
    var barData = {
        label: "bar",
        color: "#0000ff",
        data: yearstatdata.data
    };
    $.plot($("#Year-bar-chart"), [barData], barOptions);

}

function get_AllNodeList(nodeUrl) {
    var statNodeTable = [][];
    var item = ["ID","Appliances","Group","State","CurrentState"]; 
    var i , j = 0;
    
    $.ajax({
        url: nodeUrl,
        dataType: "json",
        success: function(response) {
            console.log(response);
            var len = response.length;
            // 暫時改成nodelist 去要
            for (i = 0; i < len; i++) {
                for (j = 0; j < 5; j++){
                    statNodeTable[i][j] = response[i][item[j]];

                }
               
               
            }
           
            console.log(statNodeTable);
            showNodeTable(statNodeTable);
        },
        error: function(response) {
            console.log("error");
        }
    });

    function showNodeTable(data) {
        $('#tableNodeStatus').DataTable({
            responsive: true,
            destroy: true,
            data: data,
            columns: [{
                title: "ID"
            }, {
                title: "應用"
            }, {
                title: "位置"
            }, {
                title: "狀態"
            }, {
                title: "即時耗電(mA)"
            }]
        });
    }
}

function get_Daydata(nodeUrl) {

    $.ajax({
        url: nodeUrl,
        dataType: "json",
        success: function(response) {
            console.log(response);
            showDay(response);
        },
        error: function(response) {
            console.log("error");
        }
    });



    function showDay(data) {
        var barOptions = {
            series: {
                bars: {
                    show: true,
                    barWidth: 2232000
                }
            },
            xaxis: {
                mode: "time",
                timeformat: "%I:%M %p",
                // timeformat: "%m/%d",
                // twelveHourClock: true,
                //minTickSize: [1, "day"]
                minTickSize: [1, "hour"]
            },
            yaxis: {
                axisLabel: "平均電費",
                axisLabelUseCanvas: true,
                axisLabelFontSizePixels: 12,
                axisLabelFontFamily: 'Verdana, Arial',
                axisLabelPadding: 2,
                tickFormatter: function(v, axis) {
                    return "$" + v;
                }
            },
            grid: {
                hoverable: true
            },
            legend: {
                show: false
            },
            tooltip: true,
            tooltipOpts: {
                content: "x: %x, y: %y"
            }
        };
        var barData = {
            label: "bar",
            color: "#ff0000",
            data: data.data
        };

        $.plot($("#Day-bar-chart"), [barData], barOptions);
    }




}
