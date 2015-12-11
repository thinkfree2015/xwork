
//分配任务
function sendUser(obj,taskId,url){
    var userId = $(obj).val();
    $.ajax({
        type: "post",
        url: url,
        data:{taskId:taskId,userId:userId},
        success: function (data) {


        }
    });
}
