<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header">
            <button class="close" aria-hidden="true" data-dismiss="modal"
                    type="button"></button>
            <h4 class="modal-title">Thông tin câu hỏi và trả lời</h4>
        </div>

        <div class="modal-body">
            <g:hiddenField name="cauHoiId_copy" id="${null}" value="-1"/>
            <g:hiddenField name="cauTraLoiId_copy" id="${null}" value="-1"/>
            <g:hiddenField name="newRow_copy" id="${null}" value="-1"/>
            <g:hiddenField name="updateRow_copy" id="${null}" value="-1"/>
            <g:hiddenField name="editOrView" id="${null}" value="view"/>

            <fieldset class="tam_fieldset" style="min-width: 0; background: white">
                <legend class="tam_legend">Nhập liệu câu hỏi và trả lời</legend>

                <form id="nhapLieuCH_TL" novalidate>

                    <style>
                    .no-padding {
                        padding-left: 0px;
                        padding-right: 0px;
                    }
                    </style>

                    <div class="form-group col-md-6 no-padding">
                        <label class="control-label col-md-4">Câu hỏi <span
                                class="required">*</span></label>

                        <div class="col-md-8">
                            <g:textArea class="form-control requiredz" rows="15"
                                        name="cauHoi" id="${null}"/>
                        </div>
                    </div>

                    <div class="form-group col-md-6 no-padding">
                        <label class="control-label col-md-4">Câu trả lời <span
                                class="required">*</span></label>

                        <div class="col-md-8">
                            <g:textArea class="form-control requiredz" rows="15"
                                        name="cauTraLoi" id="${null}"/>
                        </div>
                    </div>

                    <div style="clear: both"></div>
                </form>

            </fieldset>

            <div style="text-align: center; margin-bottom: 10px;">
                <button class="btn btn-save" name="form-button-save-CH_TL">
                    <i class="icon-ok"></i> Lưu tạm
                </button>
            </div>

        </div>
    </div>
</div>

<script>

    $(function () {
        melanin_validate.valid_form('form#nhapLieuCH_TL');
    });

    function luuThongTinForm(objCH_TL) {
        var form1 = $('div#modal_Update');

        objCH_TL.cauHoiId = form1.find('[name="cauHoiId_copy"]').val();
        objCH_TL.cauTraLoiId = form1.find('[name="cauTraLoiId_copy"]').val();
        objCH_TL.newRow = form1.find('[name="newRow_copy"]').val();
        objCH_TL.updateRow = parseInt(form1.find('[name="updateRow_copy"]').val());
        objCH_TL.cauHoi = form1.find('[name="cauHoi"]').val();
        objCH_TL.cauTraLoi = form1.find('[name="cauTraLoi"]').val().replaceAll("\n", "n-");

        return objCH_TL;
    }

    function loadHienThiForm(objCH_TL) {
        var form1 = $('div#modal_Update');
        form1.find('[name="cauHoi"]').val(objCH_TL.cauHoi);
        form1.find('[name="cauTraLoi"]').val(objCH_TL.cauTraLoi.replaceAll("n-", "\n"));

    }

    function clearForm() {
        var form1 = $('div#modal_Update')
        form1.find('[name="cauHoi"]').val('');
        form1.find('[name="cauTraLoi"]').val('');

    }

    $('#modal_Update button[name=form-button-save-CH_TL]').click(function (e) {
        e.preventDefault();

        if (!$('form#nhapLieuCH_TL').valid()) {
            return;
        }

        var cauHoiId = $("#modal_Update [name='cauHoiId_copy']").val();
        var newRow = $("#modal_Update [name='newRow_copy']").val();
        if (cauHoiId == -1 && newRow == 'newRow') {
            window.int_dmItem_newRow++;
            $("#modal_Update [name='newRow_copy']").val('newRow_' + window.int_dmItem_newRow);
            var objCH_TL = {}
            objCH_TL = window.luuThongTinForm(objCH_TL);
            window.dataDsCH_TL.push(objCH_TL);
        } else {
            $("#modal_Update [name='newRow_copy']").val(1);
            $("#modal_Update [name='updateRow_copy']").val(1);
            var objCH_TL = window.dataDsCH_TL.find(function (item) {
                return item.cauHoiId == cauHoiId;
            })
            window.luuThongTinForm(objCH_TL);
        }
        tableDmItem_1.clear().rows.add(window.dataDsCH_TL).draw();
        window.clearForm();
        $('#modal_Update').modal('hide');

    });

</script>

<style>
#modal_Update .modal-dialog {
    /*transform: translate(0, 5vh) !important;*/
    /*top: 0% !important;*/
    width: 95%;
    min-width: 350px;
}

.modal {
    overflow-x: hidden;
    overflow-y: auto;
    width: 100vw !important;
}

.modal-open {
    overflow: hidden;
}
</style>