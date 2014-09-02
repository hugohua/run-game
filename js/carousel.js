/*
 占卜师活动脚本
 */






Pui.add('carousel',function(exports,P){

    var $result = $('#J_result'),
        $loading = $('#J_loading'),
        $user = $('#J_user'),           //用户名
        $conste = $('#J_conste'),       //星座
        $analy = $('#J_analy'),         //性格
        $style = $('#J_style'),         //风格
        $blood = $('#J_blood');         //血型

    var timer,
        cacheData;

    /**
     * 获取flash
     * @param movieName
     * @returns {*}
     */
    var thisMovie = function(movieName) {
        if (window.document[movieName]) {
            return window.document[movieName];
        }
        if (document.getElementById(movieName)) {
            return document.getElementById(movieName);
        }

    };

    var Event = {
        replay:function(){
            $('#J_replay').on('click',function(){
                exports.hideResult(function(){
                    thisMovie('J_game').replayGame();
                });
                return false;
            })
        },

        star:function(){

        }
    };

    var showLoading = function(){
        var i = 0;
        $loading.show().addClass('loading2').removeClass('loading1');
        timer = setInterval(function(){
            i++;
            if(i%2){
                $loading.addClass('loading1').removeClass('loading2');
            }else{
                $loading.addClass('loading2').removeClass('loading1');
            }
        },500);
    };

    var hideLoading = function(){
        $loading.hide();
        clearInterval(timer);
    };

    var getConstellation = function(constellation){
        //返回数据 btnConstellation8
        return constellation.replace('btnConstellation','');
    };

    var getBlood = function(blood){
        var xx;
        if(blood == 'btnConstellation1'){
            xx = 'a';
        }else if(blood == 'btnConstellation2'){
            xx = 'b';
        }else if(blood == 'btnConstellation3'){
            xx = 'ab';
        }else if(blood == 'btnConstellation4'){
            xx = 'o';
        }else if(blood == 'btnConstellation0'){
            xx = 'u';
        }
        return xx;
    };

    /**
     * 获取数据
     * @returns {*}
     */
    var getData = function(){
        var defer = $.Deferred(),
            def;
        if(!cacheData){
            def = $.ajax({
                url : 'http://static.paipaiimg.com/fd/paipai/act/20140730_carousel/js/data.json?callback=?',
                dataType:'jsonp',
//                jsonp:"jsonCallback",
                jsonpCallback: 'jsonCallback',
                contentType: "application/json",
                success:function(data){
                    if(data) cacheData = data;
                }
            })
        }else{
            defer.resolve(cacheData);
            def = $.when(defer.promise());
        }
        return def;
    };



    /**
     * 显示结果
     */
    exports.showResult = function(callback){
        callback = callback || $.noop;
        $result.fadeIn("slow",callback);
    };

    exports.hideResult = function(callback){
        callback = callback || $.noop;
        $result.fadeOut("slow",callback);
    };

    //flash调用
    exports.gameComplete = function(result){
        exports.showResult(function(){
            hideLoading();
        });
        P.$doc.trigger('ok',result);
    };

    /**
     * 开始出结果前执行操作
     */
    exports.gameStart = function(result){
        hideLoading();
        //先预处理数据
        getData().done(function(data){
//            console.log(data,'getData');
            data = data.data || exports.data.a01;
            //组装html
            var key = getBlood(result.blood) + getConstellation(result.constellation),
                item = data[key],
                style = (result.gender === "btnConstellation0") ? item.female : item.man,
                styleArr = style.split(' '),
                linkStr = '';
            $user.text($getname());
            $conste.text(item.conste);
            $blood.text(item.blood);
            $analy.text(item.character);
            for(var i = 0,len= styleArr.length;i<len;i++){
                var tag = $.trim(styleArr[i])
                if(tag){
                    linkStr += '<span>'+ styleArr[i] +'</span>'
                }
            }
            $style.html(linkStr);
        });
    };

    /**
     * flash调用前执行
     */
    exports.gameCompleteBefore = function(){
        showLoading();
    };


    exports.data = {
        data:{
            a01:{
                conste:"摩羯座",
                blood : "A型血",
                character:"你表现出魔羯座最本质最稳定的一面，你安静、内敛，往往穿着朴素，不喜浮华，低调而从容。",
                female:"女神驾到 OL通勤 我爱办公室 辣妈萌宝 享受小资 我爱轻奢品",
                man:"暖男欧巴 运动牛人 我爱我车 数码大咖 我要去旅行 不想长大"
            }
        }
    };

    exports.lazyInit = function(){
        Event.replay();
        getData();
    }


});
