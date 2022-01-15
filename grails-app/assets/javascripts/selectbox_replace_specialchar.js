/**
 * Created by T420 on 11/5/2018.
 */
$("select option").each(function(i){
    this.text = $(this).html(this.text).text();
});