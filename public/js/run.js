/**
 * Created by p_jdyghua on 14-9-5.
 */
var ppGame = (function($){
    var popUp = function(){
        var $pop = $('#J_popup'),
            $mask = $('#J_mask');
        $('#J_view').on('click',function(){
            $mask.add($pop).show();
        });

        $pop.find('.J_close').on('click',function(){
            $mask.add($pop).hide();
        })
    };


    var thisMovie = function(movieName) {
        if (window.document[movieName]) {
            return window.document[movieName];
        }
        if (document.getElementById(movieName)) {
            return document.getElementById(movieName);
        }
        return null;
    };

    /**
     * 显示结果
     */
    var showResult = function(data){
        console.log(data);

        $('#J_result').show();
    };

    /**
     * 关闭结果浮层
     */
    var closeResult = function(){
        $('#J_result').hide();
    };


    (function(){
        popUp();
    })();

    return {
        showResult:showResult,
        closeResult:closeResult
    }


})(jQuery);