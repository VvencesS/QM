<g:hiddenField name="nhanId" id="${null}" value="-1"/>
<g:hiddenField name="editOrView" id="${null}" value="${params?.thaoTac}"/>

<style>
.no-padding {
    padding-left: 0px;
    padding-right: 0px;
}
</style>

<div class="row">
    <div class="form-group">
        <label class="col-md-3 control-label">Nhãn<span class="required">*</span></label>

        <div class="col-md-6">
            <g:select name="nhans" id="nhans"
                      from="${com.qm.QmNhan.findAll()}"
                      class="form-control input-sm"
                      optionKey="maNhan"
                      optionValue="tenNhan"
                      multiple="true"
                      noSelection="['': '']"/>
        </div>
    </div>
</div>

%{--<div class="form-group col-md-6 no-padding">--}%
%{--    <label class="control-label col-md-4">Mã Bộ hồ sơ</label>--}%

%{--    <div class="col-md-8">--}%
%{--        <g:textField class="form-control" maxlength="100"--}%
%{--                     type="text" name="maBoHoSo" id="${null}" disabled="disabled"/>--}%

%{--    </div>--}%
%{--</div>--}%

<div style="clear: both"></div>
<script>

    $('#nhans').select2({
        placeholder: "-Chọn nhãn-",
        allowClear: true
    });

    function luuThongTinNhan(objCH_TL) {
        var form1 = $('form#thongTinNhan')
        objCH_TL.editOrView = form1.find('[name="editOrView"]').val()
        objCH_TL.nhans = form1.find('[name="nhans"]').val() == null ? null : form1.find('[name="nhans"]').val().join(',');
        return objCH_TL
    }

    function loadHienThiNhan(nhans) {
        var form1 = $('form#thongTinNhan')
        form1.find('[name="nhans"]').val(nhans.split(",")).trigger('change');
    }


</script>
