/**
 * Created by p_jdyghua on 14-8-1.
 */

var $doc = $(document);

/**
 * 点击OK按钮调用的事件
 */
$doc.on('ok.click',function(e,result){
    console.log('ok',result);

    //显示结果
    Pui.carousel.gameShow();

});

$doc.on('ok',function(e,result){
    //点击OK后回执行这里的逻辑
    //result的结果是个对象 {gender: "btnConstellation1", blood: "btnConstellation4", constellation: "btnConstellation9"}
    console.log(result);
    //....逻辑...
})

