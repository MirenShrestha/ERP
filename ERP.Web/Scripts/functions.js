function PopupModal(url, modalSize, modalTitle, id) {
 
    var sizeClass = modalSizeClass(modalSize);
 
    if (!$("#form-modal").hasClass(sizeClass))
        $("#isform-modal").addClass(sizeClass)

    $("#form-modal-label").html(modalTitle);
    
    $.ajax({
        type: "GET",
        url: url,
        async: true,
        data: { "id": id },
    }).done(function (response) {
      
        $("#form-modal-body").html(response);
       // $("#form-modal-body").html("<p>test</p>");
        $('#form-modal').modal('show');
    })
    .fail(function (xhr, ajaxOptions, thrownError) {
        GlobalFunctions.GetMessage(thrownError, null, "1", 0, null, null);
    });
    


   



    //$.ajax({
    //    type: 'GET',
    //    url: url,
    //    data: { "id": id },
    //    success: function (response) {
    //        alert(response);
    //        $("#form-modal-body").html(response);
    //    }
    //});
    return;
}

function ConfirmPopupModal(modalSize, modalTitle, modalBody) {
    
    var sizeClass = modalSizeClass(modalSize);
   
    if(!$("#confirm-modal").hasClass(sizeClass))
        $("#isconfirmmodal").addClass(sizeClass)

    $("#confirm-modal-label").html(modalTitle);
    $("#confirm-modal-body").html(modalBody);

    //$("##confirm-modal").html(response);
    $("#confirm-modal").show();
    return;
  
}

function modalSizeClass(modalSize) {
    
    var sizeClass = "";
    
    switch (modalSize) {

        case "extra-large":
            sizeClass = "modal-exlg"
            break
        case "large":
            sizeClass = "modal-lg";
            break
        case "small":
            sizeClass = "modal-sm";
            break
        case "medium":
            sizeClass = "modal-md";
            break
        default:
            sizeClass = "modal-lg";
            break
           
    }
    return sizeClass;
}

function confirmAlert(title, message) {
    //var eventMessage = false;
    lnv.confirm({
        title: title,
        content: message,
        confirmBtnText: 'Confirm',
        confirmHandler: function () {
           // eventMessage = true;
           // callback(true);
        },
        cancelBtnText: 'Cancel',
        cancelHandler: function () {
            //eventMessage = false;
            //callback(false);
        }
    })
    //return eventMessage;
   
}
//function callback(value) {
//    if (value) {
//        return true;
//    } else {
//        return false;
//    }
//}
function PopupModal2(url, modalSize, modalTitle, id) {

    var sizeClass = modalSizeClass(modalSize);

    if (!$("#form-modal2").hasClass(sizeClass))
        $("#isform-modal2").addClass(sizeClass)

    $("#form-modal-label2").html(modalTitle);

    $.ajax({
        type: "GET",
        url: url,
        async: true,
        data: { "id": id },
    }).done(function (response) {

        $("#form-modal-body2").html(response);
        // $("#form-modal-body").html("<p>test</p>");
        $('#form-modal2').modal('show');
    })
        .fail(function (xhr, ajaxOptions, thrownError) {
            GlobalFunctions.GetMessage(thrownError, null, "1", 0, null, null);
        });







    //$.ajax({
    //    type: 'GET',
    //    url: url,
    //    data: { "id": id },
    //    success: function (response) {
    //        alert(response);
    //        $("#form-modal-body").html(response);
    //    }
    //});
    return;
}

