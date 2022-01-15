function pasteColumn() {
    // $('td input').bind('paste', null, function(e) {
    // 	$input = $(this);
    // 	debugger
    // 	setTimeout(function() {
    // 		var values = $input.val().split(/\s+/),
    // 			row = $input.closest('tr'),
    // 			col = $input.closest('td').index();
    // 		console.log(col);
    // 		for (var i = 0; i < values.length; i++) {
    // 			// row.find('input').eq(col).val(values[i]);
    // 			var td = row.find('td').eq(col);
    // 			var inp = td.find('input')
    // 			inp.val("");
    // 			inp.val(values[i]);
    // 			row = row.next();
    // 		}
    // 	}, 0);
    // });

    $('.pasteColumn').bind('paste', null, function (e) {
        $input = $(this);
        // debugger
        setTimeout(function () {
            var values = $input.val().split(/\s+/),
                row = $input.closest('tr'),
                col = $input.closest('td').index();
            console.log(col);
            for (var i = 0; i < values.length; i++) {
                // row.find('input').eq(col).val(values[i]);
                var td = row.find('td').eq(col);
                var inp = td.find('input')
                inp.val("");
                inp.val(values[i]);
                row = row.next();
            }
        }, 0);
    });

    $('.copyWithDbClick').dblclick(function () {
        $input = $(this);
        // debugger
        setTimeout(function () {
            var values = $input.val(),
                row = $input.closest('tr'),
                rowLenght = row.closest('tbody')[0].rows.length
            col = $input.closest('td').index();
            console.log(col);
            for (var i = 0; i < rowLenght; i++) {
                // row.find('input').eq(col).val(values[i]);
                var td = row.find('td').eq(col);
                var inp = td.find('input')
                if(inp[0]){
                    if(!inp[0].readOnly){
                        inp.val("");
                        inp.val(values);
                    }
                }
                row = row.next();
            }
        }, 0);
    });
};
