//Flot Line Chart
var responseJson = [];

var Obj_Nnode = {
    DOMList: [$('#btnMainLight'), $('#btnWallLight'), $('#btnFan')],
    ID: ["1", "2", "3"],
    State: ["0", "0", "0"]
}

var Obj_Lnode = {
    DOMList: [
        [$('#btnCurtain1'), $('#btnCurtain2'), $('#btnCurtain3')]
    ],
    ID: ["7"],
    State: [
        ["0", "0", "1"]
    ]
}

var Obj_Snode = {
    DOMList: [
        [
            [$('#btnCurtain11'), $('#btnCurtain12')],
            [$('#btnCurtain21'), $('#btnCurtain22')],
            [$('#btnCurtain31'), $('#btnCurtain32')]
        ]
    ],
    ID: ["7"]
}

var Obj_IRnode = {
    DOMList: [
        $('#btnTVON'), $('#btnMenu'), $('#btnTVEXIT'), $('#btnTVStop'),
        $('#btnTVChannelUp'), $('#btnTVChannelDown'), $('#btnTVVoiceUp'), $('#btnTVVoiceDown'),
        $('#btnTVMute'), $('#btnTV1'), $('#btnTV2'), $('#btnTV3'),
        $('#btnTV4'), $('#btnTV5'), $('#btnTV6'), $('#btnTV7'),
        $('#btnTV8'), $('#btnTV9'), $('#btnTV0'), $('#btnTVEnter')
    ],
    ID: ["9"],
    State: [
        "on", "menu", "exit", "stop",
        "chup", "chdown", "voiceup", "voicedown",
        "mute", "tv1", "tv2", "tv3",
        "tv4", "tv5", "tv6", "tv7",
        "tv8", "tv9", "tv0", "tventer"
    ]
}






var nodeUrlBase = "http://192.168.31.245:8000/api/V1/node/"

$(document).ready(function() {
    console.log("document ready");
    // 一次得到所有狀態的resufl
    // 獲得目前開關所有的狀態
    get_NodeBtnStatus(true);

    // 使用者控制開關
    // post_NodeBtnStatus();
    // N node
    $.each(Obj_Nnode.ID, function(i) {
        // console.log(i);
        Obj_Nnode.DOMList[i].change(function(event) {

            var nodeUrl = nodeUrlBase + Obj_Nnode.ID[i] + "/";
            // console.log(NnodeUrl);
            if ($(this).prop("checked") == true) {
                Obj_Nnode.State[i] = "1";
            } else {
                Obj_Nnode.State[i] = "0";
            }
            // console.log(Obj_Nnode.State[i]);
            checkNodeNState(Obj_Nnode.State[i], nodeUrl);

        });
    });
    // L node
    $.each(Obj_Lnode.ID, function(i) {
        // console.log(i);
        $.each(Obj_Lnode.DOMList[i], function(j) {
            Obj_Lnode.DOMList[i][j].change(function(event) {
                var nodeUrl = nodeUrlBase + Obj_Lnode.ID[i] + "/";

                if ($(this).prop("checked") == true) {
                    Obj_Lnode.State[i][j] = "1";
                } else {
                    Obj_Lnode.State[i][j] = "0";
                }
                // console.log(Obj_Lnode.State[i]);
                var LnoseSTATE = "";
                LnoseSTATE = Conveter_LnodeBit2State(Obj_Lnode.State[i]);
                checkNodeLState(LnoseSTATE, nodeUrl);
            });
        });

    });
    // IR node

    $.each(Obj_IRnode.DOMList, function(i) {
        Obj_IRnode.DOMList[i].click(function(event) {
            var nodeUrl = nodeUrlBase + Obj_IRnode.ID + "/";
            console.log(Obj_IRnode.State[i]);
            checkNodeIRState(Obj_IRnode.State[i], nodeUrl);
        });
    });

    // 確認L節點得狀態
    // var timerticker = setInterval(get_NodeStatus, 4000);

});

function get_NodeBtnStatus(b_firstTimer) {

    // 0223 change status bug
    // check N node status
    if (b_firstTimer == true) {
        for (var i = 0; i < Obj_Nnode.ID.length; i++) {
            var nodeUrL = nodeUrlBase + Obj_Nnode.ID[i] + "/";
            console.log(nodeUrL);
            $.ajax({
                url: nodeUrL,
                dataType: "json",
                success: function(response) {
                    console.log(response);
                    var index = Obj_Nnode.ID.indexOf(response.ID.toString());
                    Obj_Nnode.State[index] = response.State.toString();

                    if (Obj_Nnode.State[index].toString() == "0") {
                        Obj_Nnode.DOMList[index].bootstrapToggle('off');
                    } else {
                        Obj_Nnode.DOMList[index].bootstrapToggle('on');
                    }
                },
                error: function(response) {
                    console.log("error");
                }
            });
        }
    }


    // check L node status
    for (var i = 0; i < Obj_Lnode.ID.length; i++) {
        var nodeUrL = nodeUrlBase + Obj_Lnode.ID[i] + "/";
        console.log(nodeUrL);

        $.ajax({
            url: nodeUrL,
            dataType: "json",
            success: function(response) {
                console.log(response);

                var index = Obj_Lnode.ID.indexOf(response.ID.toString());
                Obj_Lnode.State[index] = Conveter_LnodeState2Bit(response.State.toString());
                // console.log(index);
                console.log(Obj_Lnode.State[index]);
                for (var i in Obj_Lnode.DOMList[index]) {
                    if (Obj_Lnode.State[index][i].toString() == "0") {
                        Obj_Lnode.DOMList[index][i].bootstrapToggle('off');
                        Obj_Snode.DOMList[index][i][0].bootstrapToggle('off');
                        Obj_Snode.DOMList[index][i][1].bootstrapToggle('off');
                    } else {
                        Obj_Lnode.DOMList[index][i].bootstrapToggle('on');
                         Obj_Snode.DOMList[index][i][0].bootstrapToggle('on');
                        Obj_Snode.DOMList[index][i][1].bootstrapToggle('on');
                    }
                }
            },
            error: function(response) {
                console.log("error");
            }
        });
    }
}


// no use


// check node status
function checkNodeNState(State, nodeUrl) {
    var open = '{"State": 1}';
    var close = '{"State": 0}';
    // ON status --> close
    if (State == "1") {
        nodeChangeState(open, nodeUrl)
    } else {
        nodeChangeState(close, nodeUrl)
    }

}

function checkNodeLState(State, nodeUrl) {

    var sendStatus = '{"State": ';
    sendStatus = sendStatus + State + '}';
    // console.log(sendStatus);
    // ON status --> close
    nodeChangeState(sendStatus, nodeUrl)
}

function checkNodeIRState(State, nodeUrl) {
    var sendStatus = '{"State": "';
    sendStatus = sendStatus + State + '"}';

    // console.log(sendStatus);
    // ON status --> close
    nodeChangeState(sendStatus, nodeUrl)

}

//改變開關狀態 REST PUT 改變狀態 
function nodeChangeState(inputStatus, nodeurl) {
    $.ajax({
        url: nodeurl,
        headers: {
            "Content-Type": "application/json"
        },
        type: "PUT",
        data: inputStatus,
        success: function(response) {
            console.log(response);
        },
        error: function(response) {
            console.log("error");
        }
    });
}


function Conveter_LnodeState2Bit(inputStatus) {
    switch (inputStatus) {
        case "0":
            return ["0", "0", "0"]
            break;
        case "1":
            return ["0", "0", "1"]
            break;
        case "2":
            return ["0", "1", "0"]
            break;
        case "3":
            return ["0", "1", "1"]
            break;
        case "4":
            return ["1", "0", "0"]
            break;
        case "5":
            return ["1", "0", "1"]
            break;
        case "6":
            return ["1", "1", "0"]
            break;
        case "7":
            return ["1", "1", "1"]
            break;
        default:
            return ["error"]
    }

}

function Conveter_LnodeBit2State(inputStrArray) {
    var tempint = [];
    var total = 0;
    for (var i in inputStrArray) {
        tempint[i] = parseInt(inputStrArray[i]);
    }
    if (tempint[0] == 1) {
        total += 4;
    }
    if (tempint[1] == 1) {
        total += 2;
    }
    if (tempint[2] == 1) {
        total += 1;
    }
    return total.toString();

}


function get_NodeStatus() {
    // console.log("timer");
    get_NodeBtnStatus(false);

}

function abortTimer() { // to be called when you want to stop the timer
    clearInterval(timerticker);
}


function getNodeLState(nodeurl) {

    $.ajax({
        url: nodeurl,
        type: "GET",
        success: function(response) {
            console.log(response);
            return response;
        },
        error: function(response) {
            console.log("error");
        }
    });
}
