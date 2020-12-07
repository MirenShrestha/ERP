import { Toast } from "../../assets/vendor/bootstrap/js/bootstrap.bundle";

var GlobalFunctions = {
    
    GetAppArea: function () {
        var arrUrl = window.location.pathname.split('/');
        var appArea = arrUrl[1];
        return appArea.length > 0 ? appArea : "";
    },
    //to get Application Module Name from url
    GetAppModuleName: function () {
        var arrUrl = window.location.pathname.split('/');
        var appModule = arrUrl[2];
        return appModule.length > 0 ? appModule : "";
    },
    //to get Module Name from url
    GetModuleName: function () {
        var arrUrl = window.location.pathname.split('/');
        var moduleName = arrUrl[3];
        return moduleName.length > 0 ? moduleName : "";
    },
    GetNepaliNumber: function () {
        //do something
    },
    GetMessage: function (message, alertType, messageType, timeout, title, position) {
        //toastr.remove();
        toastr.options = {
            "closeButton": false,
            "debug": false,
            "onclick": null,
            "timeOut": timeout || 6000,
            "extendedTimeOut": timeout || 6000
        };
        switch (messageType) {
            case "0":
                toastr.success(message);
                break;
            case "1":
                toastr.error(message, title);
                break;
            case "2":
                toastr.warning(message, title);
                break;
            case "3":
                toastr.info(message, title);
                break;
            default:
                toastr.error(message, title);
                break;
        }

    },
    //Removing Value after adding or updating data
    ClearForm: function (that) {

        var $form = $(that);
        var $input = $form.closest('form').find(':input');
        if ($input.is(":checkbox")) {
            $input.prop("checked", false)
        }
        var $inputnotbutton = $input.not(":submit,:button,:reset,[name='__RequestVerificationToken']");
        $inputnotbutton.val('');
      
    },
}
//globally user variables in javascript 
var GlobalVariables = {
    locale: GlobalFunctions.GetLocale()
}


$(function () {
    function BindEvents() {
        //change locale on button click 
        $('#ze-locale').click(function () {
            var url = window.location.pathname.toLowerCase();
            if (GlobalVariables.locale == 'en') {

                if (url.indexOf('/en/') > -1) {
                    url = url.replace('/en/', '/ne/');
                } else if (url.indexOf('/en') > -1) {
                    url = url.replace('/en', '/ne');
                }
                else {
                    url = '/ne';
                }
            } else {
                if (url.indexOf('/ne/') > -1) {
                    url = url.replace('/ne/', '/en/');
                } else if (url.indexOf('/ne') > -1) {
                    url = url.replace('/ne', '/en');
                }
                else {
                    url = '/en';
                }
            }
            window.open(url, "_self");

        });
    }
   
    BindEvents();
});




///Ajax post method
function JQueryAjaxPost(form) {
    //return false;
    //$.validator.unobtrusive.parse(form);

    $.ajax({

        type: "POST",
        url: form.action,// '@Url.Action("CreateOrEdit", "BranchType")',
        data: new FormData(form),// form.serialize(),//; { formData: new FormData(form) },// { ids: "idlist"},// new FormData(form),
        dataType: "json",
        cache: false,
        processData: false,
        contentType: false,
        success: function (data) {
            GlobalFunctions.GetMessage(data.Message, null, data.ErrorCode, 0, null, null);
            if (data.Message != "UpdatedSuccessfully")
                GlobalFunctions.ClearForm(form)

            return;

        },
        //error: function (data) {
        //    // GlobalFunctions.GetMessage("error occurred", null,"1", 0,null, null);
        //    alert(data);
        //    return;
        //}


        error: function (xhr, ajaxOptions, thrownError) {
            GlobalFunctions.GetMessage(thrownError, null, "1", 0, null, null);
            //alert(xhr.status);
            //alert(thrownError);
            return;
        }



    });
    return false;
}


//Refreshing AddNew tab
function RefreshAddNewTab(resetUrl, showViewTab) {
    $.ajax({
        type: 'GET',
        url: resetUrl,
        success: function (response) {
            $("#tab_addedit").html(response);
            $('ul.nav.nav-tabs a:eq(1)').html('Add New');
            if (showViewTab)
                $('ul.nav.nav-tabs a:eq(0)').tab('show');
        }
    });
}

//Showing Edit Tab
function Action(url, actionType, id, gridUrl, listtab, addedittab) {
    // alert("entered"+url+" " +actionType+" "+id);

    var list_tab_id, addedit_tab_id;
    if (typeof listtab !== 'undefined') {
        list_tab_id = listtab;
    }
    else {
        list_tab_id = "list";
    }

    if (typeof addedittab !== 'undefined')
        addedit_tab_id = addedittab;
    else
        addedit_tab_id = "addedit";

    if (actionType == "edit") {

        $.ajax({
            type: 'GET',
            url: url,
            data: { "id": id },
            success: function (response) {
                $("#" + addedit_tab_id + "").html(response);
                $('ul.nav.nav-tabs a:eq(1)').html('Update');
                $('ul.nav.nav-tabs a:eq(0)').removeClass(' active show');
                $('ul.nav.nav-tabs a:eq(1)').addClass(' active show');
                $("#" + list_tab_id + "").removeClass(' active show');
                $("#" + addedit_tab_id + "").addClass(' active show');

            }
        })
    }
    else if (actionType == "delete") {

        bootbox.confirm({
            //size: "small",
            //  title: title,
            message: " Are you sure to delete?",
            buttons: {
                'confirm': {
                    label: 'Yes',
                    className: 'btn-danger'
                },
                'cancel': {
                    label: 'Cancel',
                    className: 'btn-default'
                }
            },
            callback: function (result) {
                if (result == true) {
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: { "id": id },
                        dataType: "json",
                        success: function (data) {

                            if (data.ErrorCode == 0) //refresh grid
                            {
                                bindView(gridUrl, list_tab_id);
                            }
                            GlobalFunctions.GetMessage(data.Message, null, data.ErrorCode, 0, null, null);
                            return;
                        },
                        error: function () {
                            GlobalFunctions.GetMessage("error occurred", null, "1", 0, null, null);
                            return;
                        }
                    });
                }
            }
        })

        return;
    }
    else if (actionType == "view") {

    }
}



function TransactionAction(url, actionType, id, gridUrl, listtab, addedittab) {
    // alert("entered"+url+" " +actionType+" "+id);

    var list_tab_id, addedit_tab_id;
    if (typeof listtab !== 'undefined') {
        list_tab_id = listtab;
    }
    else {
        list_tab_id = "list";
    }

    if (typeof addedittab !== 'undefined')
        addedit_tab_id = addedittab;
    else
        addedit_tab_id = "addedit";

    if (actionType == "edit") {

        alert("test");
        $.ajax({
            type: 'GET',
            url: url,
            data: { "id": id },
            success: function (response) {
                $("#" + addedit_tab_id + "").html(response);
                

                $('ul#templatemo-tabs a:eq(1)').html('Update');
                $('ul#templatemo-tabs a:eq(0)').removeClass(' active show');
                $('ul#templatemo-tabs a:eq(1)').addClass(' active show');

                //$('ul.nav.nav-tabs a:eq(1)').html('Update');
                //$('ul.nav.nav-tabs a:eq(0)').removeClass(' active show');
                //$('ul.nav.nav-tabs a:eq(1)').addClass(' active show');
                $("#" + list_tab_id + "").removeClass(' active show');
                $("#" + addedit_tab_id + "").addClass(' active show');

            }
        })
    }
    else if (actionType == "delete") {

        bootbox.confirm({
            //size: "small",
            //  title: title,
            message: " Are you sure to delete?",
            buttons: {
                'confirm': {
                    label: 'Yes',
                    className: 'btn-danger'
                },
                'cancel': {
                    label: 'Cancel',
                    className: 'btn-default'
                }
            },
            callback: function (result) {
                if (result == true) {
                    $.ajax({
                        type: "POST",
                        url: url,
                        data: { "id": id },
                        dataType: "json",
                        success: function (data) {

                            if (data.ErrorCode == 0) //refresh grid
                            {
                                bindView(gridUrl, list_tab_id);
                            }
                            GlobalFunctions.GetMessage(data.Message, null, data.ErrorCode, 0, null, null);
                            return;
                        },
                        error: function () {
                            GlobalFunctions.GetMessage("error occurred", null, "1", 0, null, null);
                            return;
                        }
                    });
                }
            }
        })


        return;
    }

        //Delete With Textbox
   

    else if (actionType == "view") {

    }
}

function CancelUpdate(url, gridurl) {

    var list_tab_id = "list";
    var addedit_tab_id = "addedit";

    $.ajax({
        type: 'GET',
        url: url,
        success: function (response) {
            $("#" + addedit_tab_id + "").html(response);
            $('ul.nav.nav-tabs a:eq(1)').html('Add');
            $('ul.nav.nav-tabs a:eq(0)').addClass(' active show');
            $('ul.nav.nav-tabs a:eq(1)').removeClass(' active show');
            $("#" + list_tab_id + "").addClass(' active show');
            $("#" + addedit_tab_id + "").removeClass(' active show');
            bindView(gridUrl, list_tab_id);
        }
    });
    return;
}


//When click on Cancel button on Edit Page
function CancelUpdate(url, gridurl, listtab, addedittab) {
    var list_tab_id, addedit_tab_id;
    if (listtab.length > 0)
        list_tab_id = listtab;
    else
        list_tab_id = "list";

    if (addedittab.length > 0)
        addedit_tab_id = addedittab;
    else
        addedit_tab_id = "addedit";

    $.ajax({
        type: 'GET',
        url: url,
        success: function (response) {
            $("#" + addedit_tab_id + "").html(response);
            $('ul.nav.nav-tabs a:eq(1)').html('Add');
            $('ul.nav.nav-tabs a:eq(0)').addClass(' active show');
            $('ul.nav.nav-tabs a:eq(1)').removeClass(' active show');
            $("#" + list_tab_id + "").addClass(' active show');
            $("#" + addedit_tab_id + "").removeClass(' active show');
            bindView(gridUrl, list_tab_id);
        }
    });
    return;
}

//When click on Cancel button on Edit Page
function AddNew(url) {
    $.ajax({
        type: 'GET',
        url: url,
        success: function (response) {
            $("#addedit").html(response);
            $('ul.nav.nav-tabs a:eq(1)').html('Add');
            $('ul.nav.nav-tabs a:eq(0)').removeClass(' active show');
            $('ul.nav.nav-tabs a:eq(1)').addClass(' active show');
            $("#list").removeClass(' active show');
            $("#addedit").addClass(' active show');
        }
    });
    return;
}

function bindView(url, id) {
    console.log("Url=" + url);
    $.ajax({
        type: "GET",
        url: url,
        async: true
    }).done(function (response) {
        console.log("id-afTER=" + id);
        $("#" + id + "").html(response);
            if (id != "PurchaseOrder") {
                $('#dataTable').DataTable();
            }
        })
    .fail(function (response) {
        GlobalFunctions.GetMessage("error occurred", null, "1", 0, null, null);
    });
}

function BindCascadeDropdown(action, input, output) {
   debugger
    var stateDropdown = $('[name="' + output + '"]');
    stateDropdown.prop('disabled', 'disabled');
    $('[name="' + input + '"]').on('change', function () {
        //disable state drop down
        //clear drop down of old states  
        
        stateDropdown.empty();
        //retrieve selected country
        var data = $(this).val();
        if (input.length > 0) {
            // retrieve data using a Url.Action() to construct url
         

            $.getJSON(action, {
                id: data
            })

                .done(function (data) {
                     
                    console.log("Data=" + data)
                    //re-enable state drop down
                    stateDropdown.prop('disabled', false);
                    stateDropdown.html('<option value="">Select</option>');
                    //for each returned state
                    $.each(data, function (i, state) {
                        if (state.value == null) {
                            state.value = state.Text;
                            state.text = state.Text;
                        }


                        //Create new option
                        //var option = $('<option value="' + state.id+ '" />').html(state.Text);
                        var option = $("<option     />").val(state.value).text(state.text);
                        //append state states drop down
                        stateDropdown.append(option);
                    });
                })
            .fail(function (jqxhr, textStatus, error) {
                stateDropdown.prop('disabled', 'disabled');
                var err = textStatus + ", " + error;
                console.log("Request Failed: " + err);
            });
        }
    });
}


function BindCascadeDropdownEdit(action, input, output) {
    var stateDropdown = $('[name="' + output + '"]');
    //stateDropdown.prop('disabled', 'disabled');
    $('[name="' + input + '"]').on('change', function () {
        //disable state drop down
        //clear drop down of old states
        stateDropdown.empty();
        //retrieve selected country
        var data = $(this).val();
        if (input.length > 0) {
            // retrieve data using a Url.Action() to construct url
            $.getJSON(action, {
                id: data
            })
                .done(function (data) {
                    //re-enable state drop down
                    stateDropdown.prop('disabled', false);
                    stateDropdown.html('<option value="">Select</option>');
                    //for each returned state
                    $.each(data, function (i, state) {
                        //Create new option
                        var option = $('<option />').val(state.value).text(state.text);
                        //append state states drop down
                        stateDropdown.append(option);
                    });
                })
                .fail(function (jqxhr, textStatus, error) {
                    stateDropdown.prop('disabled', 'disabled');
                    var err = textStatus + ", " + error;
                    console.log("Request Failed: " + err);
                });
        }
    });
}