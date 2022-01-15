<g:hiddenField name="nhanId_ImportExcel" id="${null}" value="-1"/>
<g:hiddenField name="editOrView_ImportExcel" id="${null}" value="${params?.thaoTac}"/>

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
            <g:select name="nhans_ImportExcel"
                      from="${com.qm.QmNhan.findAll()}"
                      class="form-control input-sm"
                      optionKey="maNhan"
                      optionValue="tenNhan"
                      multiple="true"
                      noSelection="['': '']"/>
        </div>
    </div>
</div>

<div style="clear: both"></div>
<script>

    $('[name=nhans_ImportExcel]').select2({
        placeholder: "-Chọn nhãn-",
        allowClear: true
    });

    function luuThongTinNhan_ImportExcel(objCH_TL) {
        var form1 = $('form#thongTinNhan_ImportExcel')
        objCH_TL.editOrView = form1.find('[name="editOrView_ImportExcel"]').val()
        objCH_TL.nhans = form1.find('[name="nhans_ImportExcel"]').val() == null ? null : form1.find('[name="nhans_ImportExcel"]').val().join(',');
        return objCH_TL
    }

    function loadHienThiNhan_ImportExcel(nhans) {
        var form1 = $('form#thongTinNhan_ImportExcel')
        form1.find('[name="nhans_ImportExcel"]').val(nhans.split(",")).trigger('change');
    }


</script>
