package com.linzi.xiguwen.bean;

import android.graphics.Rect;
import android.os.Parcel;
import android.os.Parcelable;
import androidx.annotation.Nullable;

import com.previewlibrary.enitity.IThumbViewInfo;

import java.util.List;

/**
 * Created by pc on 2018/3/23.
 */

public class ShopUserDetailsBean {

    /**
     * user : {"userid":16,"usertype":2,"pid":0,"occupationid":24,"username":"18581882801","im_token":"6ebb189bd507a7990e82af789ce6ca69","register":null,"authentication":1,"money":"6462.02","vouchers":"0.00","payvouchers":"0.00","pvouchers":"0.00","nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","mobile":"18581882801","sex":"0","birthday":650505600,"provinceid":24,"cityid":273,"countyid":2636,"wachat_openid":"","weibo_openid":"","qq_openid":"","logintime":1521787331,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":7,"evaluate":0,"payword":"c4ca4238a0b923820dcc509a6f75849b","site":"云华路333号7栋307","pv":5554,"price":"0.03","num":0,"goodscore":100,"sslmid":"100008","sslmpid":"100010,100011,100012,100030,100031,100042,100043,100044,100045,100046,100047,100048,100049,100050,100130,100131,100132,100133,100134,100135,100136,100137,100138,100139,100140,100141,100142,100143,100153,100154","isuserivip":1,"userivipstat":0,"userivipendt":0,"sign":1,"height":0,"weight":0,"age":0,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":1,"xinyu":{"a":"q","b":"5"}}
     * userinfo : {"id":16,"userid":16,"team":1,"groupid":0,"isshopvip":0,"shopivipstat":0,"shopivipendt":0,"company":null,"sincerity":0,"platform":1,"college":0,"team2":0,"recommend":null,"shopimg":"a:4:{i:0;s:54:\"/uploads/20180123/28f089678984faf77a4019aa0271566d.jpg\";i:1;s:54:\"/uploads/20180123/f8a5e62caecd608e41fc4341a5f1f315.jpg\";i:2;s:54:\"/uploads/20180123/ae744290e913fd449d5e40590c0a64e2.jpg\";i:3;s:54:\"/uploads/20180123/796add39283df50e500e7fe6d2abd51a.jpg\";}","content":"2009年6月，古今缘传统婚礼策划公司成立于四川成都，发展至今古今缘（中国）传统婚礼文化、成都古今缘婚庆礼仪有限公司，已成为中国知名传统中、汉式婚礼连锁品牌服务机构，亦是中国很早专业从事中、汉式婚礼研发与推广的研发型策划公司。","background":"http://www.boyihunjia.com/uploads/20180123/19b5db9625de416ece576232bd494b77.jpg","qualifications":"    他怀着国破家亡的痛苦心情，借花鸟、木竹、山水来抒发对满洲贵族统治者的不满和愤慨，表现他那倔强傲岸的性格。因此他画的是鼓腹的鸟、瞪眼的鱼;或是残山剩水、老树枯枝;或是昂首挺胸的兽类，振翅即飞的孤鸟;或是干枯的池塘、挺立的残荷，而其中又有活泼的游鱼、生动的花朵。\n    八大山人的画作，达到了笔简形具，形神兼备的境界，充分运用了中国绘画艺术的特有传统手法。八大花鸟画最突出特点是\u201c少\u201d，用他的话说是\u201c廉\u201d，有时满幅大纸只画一鸟或一石，寥寥数笔，却神情毕具。\n    也许能有人作到，但是少而不薄，少而不贫，少而不单调，少而有味，少而有趣，透过少而给读者一个无限的思想空间，这是难有人作到的。","isshopviptoken":"","shiming":1,"xueyuan":0,"xueyuanname":"","association":"","dizhi":"四川省-成都市-锦江区"}
     * baojia : {"baojia":[{"quotationid":68,"userid":16,"uname":"18581882801","name":"玫瑰恋人1（测试）","price":"0.10","deposit":"0.00","company":"","deductible":"0.01","weigh":2,"imglist":"http://www.boyihunjia.com/uploads/20180208/3e27fa7718e4a04bacd19e2a54bea158.png","content":"   <p>我爱你，时光无阻，所以如果你爱我，一定要风雨无阻。借我一生，与你看尽人间山水。<\/p><p><img src=\"/uploads/20180208/002bd874b3032631432bc880735640af.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/6fe424b90b3ffada1fe9db5ffb048254.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/3a7d3ebd400b53720f42d692e94f665a.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/69508f3878888f017e45da4cef25d1e0.png\" alt=\"undefined\"><br><\/p><p><br><\/p>   ","rule1key":"30","rule2key":"15","rule3key":"7","state":2,"statecontent":"审核通过","status":1,"createtime":1521766703,"statetime":1521766732,"number":0,"temporarypay":"0.02","rule1val":"100","rule2val":"50","rule3val":"","num":0,"pv":182,"haopin":100},{"quotationid":72,"userid":16,"uname":"18581882801","name":"森系婚礼策划（测试）","price":"0.10","deposit":"0.00","company":"","deductible":"0.01","weigh":6,"imglist":"http://www.boyihunjia.com/uploads/20180208/38d37c3537db806fdb17435b91b5505c.jpg","content":" <p><span>给爱一张不老的容颜，让相爱过都终身不变；给爱一个不悔的誓言，让相爱过都彼此思念；给爱一片辽阔的蓝天，让那真爱充满人间。嫁给我吧！<\/span><\/p><p><span><img src=\"/uploads/20180208/26d79a4bdd3f68d48d0769885ed7b805.jpg\" alt=\"undefined\"><br><\/span><\/p><p><span><img src=\"/uploads/20180208/3276d35eb21696f23f5407e0b0ab1c87.jpg\" alt=\"undefined\"><br><\/span><\/p><p><span><img src=\"/uploads/20180208/7945d031cd5dea14bcd945bc8f938992.jpg\" alt=\"undefined\"><br><\/span><\/p><p><span><img src=\"/uploads/20180208/8c7e3fb668783ecb6b1afcfda1cdfdbf.jpg\" alt=\"undefined\"><br><\/span><\/p> ","rule1key":"30","rule2key":"15","rule3key":"7","state":2,"statecontent":"审核通过","status":1,"createtime":1521766715,"statetime":1521766731,"number":0,"temporarypay":"0.05","rule1val":"100","rule2val":"50","rule3val":"","num":0,"pv":113,"haopin":100},{"quotationid":73,"userid":16,"uname":"18581882801","name":"三生三世，十里桃花（测试）","price":"0.03","deposit":"0.00","company":"","deductible":"0.01","weigh":7,"imglist":"http://www.boyihunjia.com/uploads/20180208/bfa8d2431c209afb649864b74ff35a3b.png","content":"   <p>累世情缘，谁捡起，谁抛下，谁忘前尘，谁总牵挂。忆当时年华，谁点相思，谁种桃花。<\/p><p><img src=\"/uploads/20180208/c8fbba947e192ac1412f052b0b9028cf.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/931415cd38e389056d1d2b898232ce82.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/96bea4ab24ad85d3d5d645a607c8da72.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/166594e6dbfa1c3742a7f5fd5bf6f532.png\" alt=\"undefined\"><br><\/p>   ","rule1key":"30","rule2key":"15","rule3key":"7","state":2,"statecontent":"审核通过","status":1,"createtime":1521766724,"statetime":1521766730,"number":0,"temporarypay":"0.01","rule1val":"100","rule2val":"50","rule3val":"10","num":0,"pv":29,"haopin":100}],"zongshu":3}
     * zuoping : {"zuopin":[{"id":56,"title":"测试视频","weigh":1,"video_url":"http://player.youku.com/player.php/sid/XMzQ2MTQ1OTM3Ng==/v.swf","cover":"http://imgcache.boyihunjia.com/e1ea9201803161654098114.jpg","status":2,"putaway":1,"userid":16,"username":"18581882801","create_ti":1521190453,"update_ti":null,"statecontent":"审核通过","examinetime":1521190466,"clicked":1,"followed":0,"type":"sp"},{"id":18,"name":"三机位","weight":2,"cover":"http://www.boyihunjia.com/uploads/20180124/87f673b7c577ff1d49db630835460fd3.jpg","status":2,"putaway":1,"userid":16,"username":"18581882801","create_ti":1516725752,"update_ti":1521286258,"statecontent":"审核通过","examinetime":1521423223,"synopsis":"撒旦法是否所发生的说的发","clicked":1,"followed":0,"type":"tc","photou":[{"id":41,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/0d3bb87b027b99b43393e13ed3d815bb.jpg"},{"id":42,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/3d777c9e66eef1a90332220485d0b0c6.jpg"},{"id":43,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/a963d95f4f4f9a0dae03c4d3649f1fb0.jpg"},{"id":44,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/f08182ba560f5e8c2e2f80251880a544.jpg"}]},{"id":10,"title":"12312fgdsfg dfg ","weigh":3,"video_url":"http://www.boyihunjia.com/Index/admin/video/20180113/b590a2037ed13c46bf554be2e9b037ed.mp4","cover":"http://www.boyihunjia.com/uploads/20180113/c00331e1a48cc3cbdeac94a962c0aeee.jpg","status":2,"putaway":1,"userid":16,"username":"18581882801","create_ti":1515849359,"update_ti":1520849229,"statecontent":"审核通过","examinetime":1520849240,"clicked":1,"followed":0,"type":"sp"},{"id":15,"userid":16,"username":"18581882801","title":"童话里的我们","weddingtime":"2017-12-31","weddingplace":"成都千禧大酒店","weddingexpenses":68000,"weddingtypeid":1,"weddingenvironmentid":4,"weigh":6,"weddingcover":"http://www.boyihunjia.com/uploads/20180124/d2174b0b7709ccab54243e43ce856eca.jpg","weddingdescribe":"星空闪烁，仿佛遥远的召唤：\u201c愿深情一眼挚爱万年，几度轮回恋恋不灭！\u201d","status":2,"putaway":1,"create_ti":1514693451,"update_ti":1516724767,"statecontent":"审核通过","examinetime":1516757258,"clicked":120,"followed":2,"commented":0,"pv":120,"num":0,"evnum":0,"goodscore":0,"tuijian":1,"type":"al"},{"id":14,"userid":16,"username":"18581882801","title":"三生三世","weddingtime":"2017-12-31","weddingplace":"成都千禧大酒店","weddingexpenses":12800,"weddingtypeid":1,"weddingenvironmentid":1,"weigh":5,"weddingcover":"http://www.boyihunjia.com/uploads/20180124/1a18e89dd3fb78e90e483b6a1e73aee9.png","weddingdescribe":"星空闪烁，仿佛遥远的召唤：\u201c愿深情一眼挚爱万年，几度轮回恋恋不灭！\u201d","status":2,"putaway":1,"create_ti":1514693384,"update_ti":1516724758,"statecontent":"审核通过","examinetime":1516757259,"clicked":199,"followed":2,"commented":0,"pv":199,"num":0,"evnum":0,"goodscore":0,"tuijian":2,"type":"al"}],"zongshu":5}
     * pinglun : [{"comment_id":14,"user_id":541,"seller_id":16,"order_id":301,"goods_id":null,"rec_id":null,"content":"杜老师特别优秀！不错","created_at":"2018-03-23 10:21:32","updated_at":null,"parent_id":null,"pictures":[],"order_score":5,"replay_user_id":null,"replay_content":null,"replay_time":"1970-01-01 08:00:00","anonymous":1,"pid":0,"userid":541,"usertype":2,"occupationid":1,"username":"13880700685","register":null,"authentication":1,"name":"廖斌","identitynum":"513322198304170038","vouchers":"100.00","payvouchers":"0.00","pvouchers":"100.00","nickname":"墨修成","head":"http://www.boyihunjia.com/Index/admin/image/180222/d4Md0279000001519271679.png","mobile":"13880700685","sex":"0","birthday":419356800,"provinceid":24,"cityid":273,"countyid":2637,"logintime":1521785623,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":0,"evaluate":0,"site":"财富领地3栋12楼","pv":444,"price":"600.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":null,"height":0,"weight":0,"age":0,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":2},{"comment_id":12,"user_id":67,"seller_id":16,"order_id":119,"goods_id":null,"rec_id":null,"content":"dfgbcfgbdfgds","created_at":"2018-03-05 14:47:03","updated_at":null,"parent_id":null,"pictures":[],"order_score":5,"replay_user_id":null,"replay_content":null,"replay_time":"1970-01-01 08:00:00","anonymous":1,"pid":0,"userid":67,"usertype":1,"occupationid":0,"username":"13551862869","register":null,"authentication":1,"name":"测试","identitynum":"1231431","vouchers":"100100.00","payvouchers":"100000.00","pvouchers":"100100.00","nickname":"博艺婚嫁自营店","head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","mobile":"13551862869","sex":"1","birthday":649987200,"provinceid":24,"cityid":273,"countyid":2636,"logintime":1521786659,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":2,"evaluate":0,"site":"武侯区环球东路","pv":370,"price":"0.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":2,"height":0,"weight":0,"age":111,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":3},{"comment_id":11,"user_id":67,"seller_id":16,"order_id":76,"goods_id":null,"rec_id":null,"content":"服务好，非常不错","created_at":"2018-03-02 10:08:57","updated_at":null,"parent_id":null,"pictures":["http://www.boyihunjia.com/uploads/20180302/16bf400af6e8a3daa6a6e27f75e1c211.jpg","http://www.boyihunjia.com/uploads/20180302/5c10179aedfaaa19fcccf2f9be930681.jpg","http://www.boyihunjia.com/uploads/20180302/f83bbfde568cf9ea6275c687ed946a3b.jpg","http://www.boyihunjia.com/uploads/20180302/dda0e4559d86ac9283b91badca7f7079.jpg"],"order_score":5,"replay_user_id":null,"replay_content":null,"replay_time":"1970-01-01 08:00:00","anonymous":1,"pid":0,"userid":67,"usertype":1,"occupationid":0,"username":"13551862869","register":null,"authentication":1,"name":"测试","identitynum":"1231431","vouchers":"100100.00","payvouchers":"100000.00","pvouchers":"100100.00","nickname":"博艺婚嫁自营店","head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","mobile":"13551862869","sex":"1","birthday":649987200,"provinceid":24,"cityid":273,"countyid":2636,"logintime":1521786659,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":2,"evaluate":0,"site":"武侯区环球东路","pv":370,"price":"0.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":2,"height":0,"weight":0,"age":111,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":3},{"comment_id":8,"user_id":961,"seller_id":16,"order_id":47,"goods_id":null,"rec_id":null,"content":"服务好，非常不错","created_at":"2018-02-25 12:22:16","updated_at":null,"parent_id":null,"pictures":["http://www.boyihunjia.com/uploads/20180302/16bf400af6e8a3daa6a6e27f75e1c211.jpg","http://www.boyihunjia.com/uploads/20180302/5c10179aedfaaa19fcccf2f9be930681.jpg","http://www.boyihunjia.com/uploads/20180302/f83bbfde568cf9ea6275c687ed946a3b.jpg","http://www.boyihunjia.com/uploads/20180302/dda0e4559d86ac9283b91badca7f7079.jpg"],"order_score":1,"replay_user_id":16,"replay_content":"你自己不知","replay_time":"2018-02-25 12:22:27","anonymous":1,"pid":16,"userid":961,"usertype":3,"occupationid":0,"username":"12544448888","register":null,"authentication":0,"name":null,"identitynum":null,"vouchers":"17.50","payvouchers":"0.00","pvouchers":"17.50","nickname":"用户12544448888","head":"http://imgcache.boyitongcheng.com/62720201803061521234360.ico","mobile":"12544448888","sex":"1","birthday":650073600,"provinceid":24,"cityid":289,"countyid":2778,"logintime":1520489280,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":0,"evaluate":0,"site":null,"pv":6,"price":"0.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":1,"height":0,"weight":0,"age":0,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"18581882801","sort":0},{"comment_id":7,"user_id":961,"seller_id":16,"order_id":46,"goods_id":null,"rec_id":null,"content":"服务好，非常不错","created_at":"2018-02-25 10:06:34","updated_at":null,"parent_id":null,"pictures":[],"order_score":1,"replay_user_id":16,"replay_content":"呵呵呵呵","replay_time":"2018-02-25 10:07:24","anonymous":1,"pid":16,"userid":961,"usertype":3,"occupationid":0,"username":"12544448888","register":null,"authentication":0,"name":null,"identitynum":null,"vouchers":"17.50","payvouchers":"0.00","pvouchers":"17.50","nickname":"用户12544448888","head":"http://imgcache.boyitongcheng.com/62720201803061521234360.ico","mobile":"12544448888","sex":"1","birthday":650073600,"provinceid":24,"cityid":289,"countyid":2778,"logintime":1520489280,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":0,"evaluate":0,"site":null,"pv":6,"price":"0.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":1,"height":0,"weight":0,"age":0,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"18581882801","sort":0},{"comment_id":6,"user_id":67,"seller_id":16,"order_id":30,"goods_id":null,"rec_id":null,"content":"21312","created_at":"2018-02-10 10:47:11","updated_at":null,"parent_id":null,"pictures":["http://www.boyihunjia.com/uploads/20180302/16bf400af6e8a3daa6a6e27f75e1c211.jpg","http://www.boyihunjia.com/uploads/20180302/5c10179aedfaaa19fcccf2f9be930681.jpg","http://www.boyihunjia.com/uploads/20180302/f83bbfde568cf9ea6275c687ed946a3b.jpg","http://www.boyihunjia.com/uploads/20180302/dda0e4559d86ac9283b91badca7f7079.jpg"],"order_score":5,"replay_user_id":null,"replay_content":null,"replay_time":"1970-01-01 08:00:00","anonymous":1,"pid":0,"userid":67,"usertype":1,"occupationid":0,"username":"13551862869","register":null,"authentication":1,"name":"测试","identitynum":"1231431","vouchers":"100100.00","payvouchers":"100000.00","pvouchers":"100100.00","nickname":"博艺婚嫁自营店","head":"http://imgcache.boyihunjia.com/9769c201803120905146801.png","mobile":"13551862869","sex":"1","birthday":649987200,"provinceid":24,"cityid":273,"countyid":2636,"logintime":1521786659,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":2,"evaluate":0,"site":"武侯区环球东路","pv":370,"price":"0.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":2,"height":0,"weight":0,"age":111,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":3},{"comment_id":2,"user_id":50,"seller_id":16,"order_id":2,"goods_id":null,"rec_id":null,"content":"任务萨手动阀手动阀","created_at":"2018-02-03 18:56:26","updated_at":null,"parent_id":null,"pictures":[],"order_score":4,"replay_user_id":16,"replay_content":"服务好，非常不错","replay_time":"2018-02-12 12:14:24","anonymous":1,"pid":0,"userid":50,"usertype":1,"occupationid":0,"username":"13183881987","register":null,"authentication":0,"name":null,"identitynum":null,"vouchers":"0.00","payvouchers":"0.00","pvouchers":"0.00","nickname":"13183881987","head":"http://www.boyihunjia.com/Index/admin/image/180223/kM000676461001519347234.png","mobile":"13183881987","sex":"1","birthday":650073600,"provinceid":24,"cityid":273,"countyid":2636,"logintime":1521270953,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":0,"evaluate":0,"site":null,"pv":0,"price":"0.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":1,"height":0,"weight":0,"age":0,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":1},{"comment_id":1,"user_id":50,"seller_id":16,"order_id":2,"goods_id":null,"rec_id":null,"content":"二维若翁","created_at":"2018-02-03 18:55:56","updated_at":null,"parent_id":null,"pictures":[],"order_score":4,"replay_user_id":16,"replay_content":"谢谢夸奖~你们的表现也很好。比彩排的时候更加自然、感动、希望有机会再合作哦~","replay_time":"2018-02-03 18:55:56","anonymous":1,"pid":0,"userid":50,"usertype":1,"occupationid":0,"username":"13183881987","register":null,"authentication":0,"name":null,"identitynum":null,"vouchers":"0.00","payvouchers":"0.00","pvouchers":"0.00","nickname":"13183881987","head":"http://www.boyihunjia.com/Index/admin/image/180223/kM000676461001519347234.png","mobile":"13183881987","sex":"1","birthday":650073600,"provinceid":24,"cityid":273,"countyid":2636,"logintime":1521270953,"state":1,"weixin":null,"createtime":1520310601,"score":100,"fans":0,"evaluate":0,"site":null,"pv":0,"price":"0.00","num":0,"goodscore":100,"isuserivip":0,"userivipstat":0,"userivipendt":0,"sign":1,"height":0,"weight":0,"age":0,"email":"","isuseriviptoken":"","onlinestatus":1,"inviter":"","sort":1}]
     * tuijiantd : [{"userid":921,"usertype":2,"num":0,"pv":26,"score":100,"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"Monster","occupationid":0,"occupation":null,"zuidijia":0,"shopcode":"921"},{"userid":16,"usertype":2,"num":0,"pv":5556,"score":100,"head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","nickname":"杜卡基老师","occupationid":24,"occupation":"花艺师","zuidijia":"0.03","shopcode":"16"},{"userid":926,"usertype":2,"num":0,"pv":30,"score":100,"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"龙凤缘鲜花庆典","occupationid":0,"occupation":null,"zuidijia":0,"shopcode":"926"},{"userid":939,"usertype":2,"num":0,"pv":34,"score":100,"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"金尚婚礼","occupationid":1,"occupation":"策划师","zuidijia":0,"shopcode":"939"},{"userid":936,"usertype":2,"num":0,"pv":46,"score":100,"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"神图","occupationid":0,"occupation":null,"zuidijia":0,"shopcode":"936"},{"userid":935,"usertype":2,"num":0,"pv":34,"score":100,"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"婚礼跟拍一吕","occupationid":4,"occupation":"摄影师","zuidijia":0,"shopcode":"935"},{"userid":933,"usertype":2,"num":0,"pv":30,"score":100,"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"佳丽影视","occupationid":4,"occupation":"摄影师","zuidijia":0,"shopcode":"933"},{"userid":931,"usertype":2,"num":0,"pv":20,"score":100,"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"峰峰","occupationid":0,"occupation":null,"zuidijia":0,"shopcode":"931"},{"userid":930,"usertype":2,"num":0,"pv":14,"score":100,"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"天赐良缘婚庆婚纱","occupationid":0,"occupation":null,"zuidijia":0,"shopcode":"930"}]
     * userf : 0
     */

    private UserBean user;
    private UserinfoBean userinfo;
    private BaojiaBeanX baojia;
    private ZuopingBean zuoping;
    private int userf;
    private List<PinglunBean> pinglun;
    private List<TuijiantdBean> tuijiantd;

    public UserBean getUser() {
        return user;
    }

    public void setUser(UserBean user) {
        this.user = user;
    }

    public UserinfoBean getUserinfo() {
        return userinfo;
    }

    public void setUserinfo(UserinfoBean userinfo) {
        this.userinfo = userinfo;
    }

    public BaojiaBeanX getBaojia() {
        return baojia;
    }

    public void setBaojia(BaojiaBeanX baojia) {
        this.baojia = baojia;
    }

    public ZuopingBean getZuoping() {
        return zuoping;
    }

    public void setZuoping(ZuopingBean zuoping) {
        this.zuoping = zuoping;
    }

    public int getUserf() {
        return userf;
    }

    public void setUserf(int userf) {
        this.userf = userf;
    }

    public List<PinglunBean> getPinglun() {
        return pinglun;
    }

    public void setPinglun(List<PinglunBean> pinglun) {
        this.pinglun = pinglun;
    }

    public List<TuijiantdBean> getTuijiantd() {
        return tuijiantd;
    }

    public void setTuijiantd(List<TuijiantdBean> tuijiantd) {
        this.tuijiantd = tuijiantd;
    }

    public static class UserBean {
        /**
         * userid : 16
         * usertype : 2
         * pid : 0
         * occupationid : 24
         * username : 18581882801
         * im_token : 6ebb189bd507a7990e82af789ce6ca69
         * register : null
         * authentication : 1
         * money : 6462.02
         * vouchers : 0.00
         * payvouchers : 0.00
         * pvouchers : 0.00
         * nickname : 杜卡基老师
         * head : http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg
         * mobile : 18581882801
         * sex : 0
         * birthday : 650505600
         * provinceid : 24
         * cityid : 273
         * countyid : 2636
         * wachat_openid :
         * weibo_openid :
         * qq_openid :
         * logintime : 1521787331
         * state : 1
         * weixin : null
         * createtime : 1520310601
         * score : 100
         * fans : 7
         * evaluate : 0
         * payword : c4ca4238a0b923820dcc509a6f75849b
         * site : 云华路333号7栋307
         * pv : 5554
         * price : 0.03
         * num : 0
         * goodscore : 100
         * sslmid : 100008
         * sslmpid : 100010,100011,100012,100030,100031,100042,100043,100044,100045,100046,100047,100048,100049,100050,100130,100131,100132,100133,100134,100135,100136,100137,100138,100139,100140,100141,100142,100143,100153,100154
         * isuserivip : 1
         * userivipstat : 0
         * userivipendt : 0
         * sign : 1
         * height : 0
         * weight : 0
         * age : 0
         * email :
         * isuseriviptoken :
         * onlinestatus : 1
         * inviter :
         * sort : 1
         * xinyu : {"a":"q","b":"5"}
         */

        private int userid;
        private int occupationid;
        private String nickname;
        private String head;
        private String mobile;
        private int cityid;
        private int state;
        private int createtime;
        private String site;
        private int pv;
        private String price;
        private int num;
        private int goodscore;
        private int height;
        private XinyuBean xinyu;
        private String fans;

        public String getFans() {
            return fans;
        }

        public void setFans(String fans) {
            this.fans = fans;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }


        public int getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(int occupationid) {
            this.occupationid = occupationid;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }

        public int getCityid() {
            return cityid;
        }

        public void setCityid(int cityid) {
            this.cityid = cityid;
        }

        public int getState() {
            return state;
        }

        public void setState(int state) {
            this.state = state;
        }

        public int getCreatetime() {
            return createtime;
        }

        public void setCreatetime(int createtime) {
            this.createtime = createtime;
        }

        public String getSite() {
            return site;
        }

        public void setSite(String site) {
            this.site = site;
        }

        public int getPv() {
            return pv;
        }

        public void setPv(int pv) {
            this.pv = pv;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public int getNum() {
            return num;
        }

        public void setNum(int num) {
            this.num = num;
        }

        public int getGoodscore() {
            return goodscore;
        }

        public void setGoodscore(int goodscore) {
            this.goodscore = goodscore;
        }

        public int getHeight() {
            return height;
        }

        public void setHeight(int height) {
            this.height = height;
        }

        public XinyuBean getXinyu() {
            return xinyu;
        }

        public void setXinyu(XinyuBean xinyu) {
            this.xinyu = xinyu;
        }

        public static class XinyuBean {
            /**
             * a : q
             * b : 5
             */

            private String a;
            private String b;

            public String getA() {
                return a;
            }

            public void setA(String a) {
                this.a = a;
            }

            public String getB() {
                return b;
            }

            public void setB(String b) {
                this.b = b;
            }
        }
    }

    public static class UserinfoBean {
        /**
         * id : 16
         * userid : 16
         * team : 1
         * groupid : 0
         * isshopvip : 0
         * shopivipstat : 0
         * shopivipendt : 0
         * company : null
         * sincerity : 0
         * platform : 1
         * college : 0
         * team2 : 0
         * recommend : null
         * shopimg : a:4:{i:0;s:54:"/uploads/20180123/28f089678984faf77a4019aa0271566d.jpg";i:1;s:54:"/uploads/20180123/f8a5e62caecd608e41fc4341a5f1f315.jpg";i:2;s:54:"/uploads/20180123/ae744290e913fd449d5e40590c0a64e2.jpg";i:3;s:54:"/uploads/20180123/796add39283df50e500e7fe6d2abd51a.jpg";}
         * content : 2009年6月，古今缘传统婚礼策划公司成立于四川成都，发展至今古今缘（中国）传统婚礼文化、成都古今缘婚庆礼仪有限公司，已成为中国知名传统中、汉式婚礼连锁品牌服务机构，亦是中国很早专业从事中、汉式婚礼研发与推广的研发型策划公司。
         * background : http://www.boyihunjia.com/uploads/20180123/19b5db9625de416ece576232bd494b77.jpg
         * qualifications :     他怀着国破家亡的痛苦心情，借花鸟、木竹、山水来抒发对满洲贵族统治者的不满和愤慨，表现他那倔强傲岸的性格。因此他画的是鼓腹的鸟、瞪眼的鱼;或是残山剩水、老树枯枝;或是昂首挺胸的兽类，振翅即飞的孤鸟;或是干枯的池塘、挺立的残荷，而其中又有活泼的游鱼、生动的花朵。
         * 八大山人的画作，达到了笔简形具，形神兼备的境界，充分运用了中国绘画艺术的特有传统手法。八大花鸟画最突出特点是“少”，用他的话说是“廉”，有时满幅大纸只画一鸟或一石，寥寥数笔，却神情毕具。
         * 也许能有人作到，但是少而不薄，少而不贫，少而不单调，少而有味，少而有趣，透过少而给读者一个无限的思想空间，这是难有人作到的。
         * isshopviptoken :
         * shiming : 1
         * xueyuan : 0
         * xueyuanname :
         * association :
         * dizhi : 四川省-成都市-锦江区
         */

        private int id;
        private int userid;
        private String company;
        private int sincerity;
        private int platform;
        private int college;
        private String content;
        private String background;
        private String association;
        private String dizhi;
        private int xueyuan;
        private int shiming;

        public int getShiming() {
            return shiming;
        }

        public void setShiming(int shiming) {
            this.shiming = shiming;
        }

        public int getXueyuan() {
            return xueyuan;
        }

        public void setXueyuan(int xueyuan) {
            this.xueyuan = xueyuan;
        }

        public String getDizhi() {
            return dizhi;
        }

        public void setDizhi(String dizhi) {
            this.dizhi = dizhi;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public String getCompany() {
            return company;
        }

        public void setCompany(String company) {
            this.company = company;
        }

        public int getSincerity() {
            return sincerity;
        }

        public void setSincerity(int sincerity) {
            this.sincerity = sincerity;
        }

        public int getPlatform() {
            return platform;
        }

        public void setPlatform(int platform) {
            this.platform = platform;
        }

        public int getCollege() {
            return college;
        }

        public void setCollege(int college) {
            this.college = college;
        }

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }

        public String getBackground() {
            return background;
        }

        public void setBackground(String background) {
            this.background = background;
        }

        public String getAssociation() {
            return association;
        }

        public void setAssociation(String association) {
            this.association = association;
        }

    }

    public static class BaojiaBeanX {

        /**
         * baojia : [{"quotationid":68,"userid":16,"uname":"18581882801","name":"玫瑰恋人1（测试）","price":"0.10","deposit":"0.00","company":"","deductible":"0.01","weigh":2,"imglist":"http://www.boyihunjia.com/uploads/20180208/3e27fa7718e4a04bacd19e2a54bea158.png","content":"   <p>我爱你，时光无阻，所以如果你爱我，一定要风雨无阻。借我一生，与你看尽人间山水。<\/p><p><img src=\"/uploads/20180208/002bd874b3032631432bc880735640af.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/6fe424b90b3ffada1fe9db5ffb048254.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/3a7d3ebd400b53720f42d692e94f665a.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/69508f3878888f017e45da4cef25d1e0.png\" alt=\"undefined\"><br><\/p><p><br><\/p>   ","rule1key":"30","rule2key":"15","rule3key":"7","state":2,"statecontent":"审核通过","status":1,"createtime":1521766703,"statetime":1521766732,"number":0,"temporarypay":"0.02","rule1val":"100","rule2val":"50","rule3val":"","num":0,"pv":184,"haopin":100},{"quotationid":72,"userid":16,"uname":"18581882801","name":"森系婚礼策划（测试）","price":"0.10","deposit":"0.00","company":"","deductible":"0.01","weigh":6,"imglist":"http://www.boyihunjia.com/uploads/20180208/38d37c3537db806fdb17435b91b5505c.jpg","content":" <p><span>给爱一张不老的容颜，让相爱过都终身不变；给爱一个不悔的誓言，让相爱过都彼此思念；给爱一片辽阔的蓝天，让那真爱充满人间。嫁给我吧！<\/span><\/p><p><span><img src=\"/uploads/20180208/26d79a4bdd3f68d48d0769885ed7b805.jpg\" alt=\"undefined\"><br><\/span><\/p><p><span><img src=\"/uploads/20180208/3276d35eb21696f23f5407e0b0ab1c87.jpg\" alt=\"undefined\"><br><\/span><\/p><p><span><img src=\"/uploads/20180208/7945d031cd5dea14bcd945bc8f938992.jpg\" alt=\"undefined\"><br><\/span><\/p><p><span><img src=\"/uploads/20180208/8c7e3fb668783ecb6b1afcfda1cdfdbf.jpg\" alt=\"undefined\"><br><\/span><\/p> ","rule1key":"30","rule2key":"15","rule3key":"7","state":2,"statecontent":"审核通过","status":1,"createtime":1521766715,"statetime":1521766731,"number":0,"temporarypay":"0.05","rule1val":"100","rule2val":"50","rule3val":"","num":0,"pv":115,"haopin":100},{"quotationid":73,"userid":16,"uname":"18581882801","name":"三生三世，十里桃花（测试）","price":"0.03","deposit":"0.00","company":"","deductible":"0.01","weigh":7,"imglist":"http://www.boyihunjia.com/uploads/20180208/bfa8d2431c209afb649864b74ff35a3b.png","content":"   <p>累世情缘，谁捡起，谁抛下，谁忘前尘，谁总牵挂。忆当时年华，谁点相思，谁种桃花。<\/p><p><img src=\"/uploads/20180208/c8fbba947e192ac1412f052b0b9028cf.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/931415cd38e389056d1d2b898232ce82.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/96bea4ab24ad85d3d5d645a607c8da72.png\" alt=\"undefined\"><br><\/p><p><img src=\"/uploads/20180208/166594e6dbfa1c3742a7f5fd5bf6f532.png\" alt=\"undefined\"><br><\/p>   ","rule1key":"30","rule2key":"15","rule3key":"7","state":2,"statecontent":"审核通过","status":1,"createtime":1521766724,"statetime":1521766730,"number":0,"temporarypay":"0.01","rule1val":"100","rule2val":"50","rule3val":"10","num":0,"pv":45,"haopin":100}]
         * zongshu : 3
         */

        private int zongshu;
        private List<BaojiaBean> baojia;

        public int getZongshu() {
            return zongshu;
        }

        public void setZongshu(int zongshu) {
            this.zongshu = zongshu;
        }

        public List<BaojiaBean> getBaojia() {
            return baojia;
        }

        public void setBaojia(List<BaojiaBean> baojia) {
            this.baojia = baojia;
        }

        public static class BaojiaBean {
            /**
             * quotationid : 68
             * userid : 16
             * uname : 18581882801
             * name : 玫瑰恋人1（测试）
             * price : 0.10
             * deposit : 0.00
             * company :
             * deductible : 0.01
             * weigh : 2
             * imglist : http://www.boyihunjia.com/uploads/20180208/3e27fa7718e4a04bacd19e2a54bea158.png
             * content :    <p>我爱你，时光无阻，所以如果你爱我，一定要风雨无阻。借我一生，与你看尽人间山水。</p><p><img src="/uploads/20180208/002bd874b3032631432bc880735640af.png" alt="undefined"><br></p><p><img src="/uploads/20180208/6fe424b90b3ffada1fe9db5ffb048254.png" alt="undefined"><br></p><p><img src="/uploads/20180208/3a7d3ebd400b53720f42d692e94f665a.png" alt="undefined"><br></p><p><img src="/uploads/20180208/69508f3878888f017e45da4cef25d1e0.png" alt="undefined"><br></p><p><br></p>
             * rule1key : 30
             * rule2key : 15
             * rule3key : 7
             * state : 2
             * statecontent : 审核通过
             * status : 1
             * createtime : 1521766703
             * statetime : 1521766732
             * number : 0
             * temporarypay : 0.02
             * rule1val : 100
             * rule2val : 50
             * rule3val :
             * num : 0
             * pv : 184
             * haopin : 100
             */
            private int quotationid;
            private String name;
            private String price;
            private String imglist;
            private int num;

            public int getQuotationid() {
                return quotationid;
            }

            public void setQuotationid(int quotationid) {
                this.quotationid = quotationid;
            }

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }

            public String getPrice() {
                return price;
            }

            public void setPrice(String price) {
                this.price = price;
            }

            public String getImglist() {
                return imglist;
            }

            public void setImglist(String imglist) {
                this.imglist = imglist;
            }

            public int getNum() {
                return num;
            }

            public void setNum(int num) {
                this.num = num;
            }
        }
    }

    public static class ZuopingBean {
        /**
         * zuopin : [{"id":56,"title":"测试视频","weigh":1,"video_url":"http://player.youku.com/player.php/sid/XMzQ2MTQ1OTM3Ng==/v.swf","cover":"http://imgcache.boyihunjia.com/e1ea9201803161654098114.jpg","status":2,"putaway":1,"userid":16,"username":"18581882801","create_ti":1521190453,"update_ti":null,"statecontent":"审核通过","examinetime":1521190466,"clicked":1,"followed":0,"type":"sp"},{"id":18,"name":"三机位","weight":2,"cover":"http://www.boyihunjia.com/uploads/20180124/87f673b7c577ff1d49db630835460fd3.jpg","status":2,"putaway":1,"userid":16,"username":"18581882801","create_ti":1516725752,"update_ti":1521286258,"statecontent":"审核通过","examinetime":1521423223,"synopsis":"撒旦法是否所发生的说的发","clicked":1,"followed":0,"type":"tc","photou":[{"id":41,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/0d3bb87b027b99b43393e13ed3d815bb.jpg"},{"id":42,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/3d777c9e66eef1a90332220485d0b0c6.jpg"},{"id":43,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/a963d95f4f4f9a0dae03c4d3649f1fb0.jpg"},{"id":44,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/f08182ba560f5e8c2e2f80251880a544.jpg"}]},{"id":10,"title":"12312fgdsfg dfg ","weigh":3,"video_url":"http://www.boyihunjia.com/Index/admin/video/20180113/b590a2037ed13c46bf554be2e9b037ed.mp4","cover":"http://www.boyihunjia.com/uploads/20180113/c00331e1a48cc3cbdeac94a962c0aeee.jpg","status":2,"putaway":1,"userid":16,"username":"18581882801","create_ti":1515849359,"update_ti":1520849229,"statecontent":"审核通过","examinetime":1520849240,"clicked":1,"followed":0,"type":"sp"},{"id":15,"userid":16,"username":"18581882801","title":"童话里的我们","weddingtime":"2017-12-31","weddingplace":"成都千禧大酒店","weddingexpenses":68000,"weddingtypeid":1,"weddingenvironmentid":4,"weigh":6,"weddingcover":"http://www.boyihunjia.com/uploads/20180124/d2174b0b7709ccab54243e43ce856eca.jpg","weddingdescribe":"星空闪烁，仿佛遥远的召唤：\u201c愿深情一眼挚爱万年，几度轮回恋恋不灭！\u201d","status":2,"putaway":1,"create_ti":1514693451,"update_ti":1516724767,"statecontent":"审核通过","examinetime":1516757258,"clicked":120,"followed":2,"commented":0,"pv":120,"num":0,"evnum":0,"goodscore":0,"tuijian":1,"type":"al"},{"id":14,"userid":16,"username":"18581882801","title":"三生三世","weddingtime":"2017-12-31","weddingplace":"成都千禧大酒店","weddingexpenses":12800,"weddingtypeid":1,"weddingenvironmentid":1,"weigh":5,"weddingcover":"http://www.boyihunjia.com/uploads/20180124/1a18e89dd3fb78e90e483b6a1e73aee9.png","weddingdescribe":"星空闪烁，仿佛遥远的召唤：\u201c愿深情一眼挚爱万年，几度轮回恋恋不灭！\u201d","status":2,"putaway":1,"create_ti":1514693384,"update_ti":1516724758,"statecontent":"审核通过","examinetime":1516757259,"clicked":199,"followed":2,"commented":0,"pv":199,"num":0,"evnum":0,"goodscore":0,"tuijian":2,"type":"al"}]
         * zongshu : 5
         */

        private int zongshu;
        private List<ZuopinBean> zuopin;

        public int getZongshu() {
            return zongshu;
        }

        public void setZongshu(int zongshu) {
            this.zongshu = zongshu;
        }

        public List<ZuopinBean> getZuopin() {
            return zuopin;
        }

        public void setZuopin(List<ZuopinBean> zuopin) {
            this.zuopin = zuopin;
        }

        public static class ZuopinBean {
            /**
             * id : 56
             * title : 测试视频
             * weigh : 1
             * video_url : http://player.youku.com/player.php/sid/XMzQ2MTQ1OTM3Ng==/v.swf
             * cover : http://imgcache.boyihunjia.com/e1ea9201803161654098114.jpg
             * status : 2
             * putaway : 1
             * userid : 16
             * username : 18581882801
             * create_ti : 1521190453
             * update_ti : null
             * statecontent : 审核通过
             * examinetime : 1521190466
             * clicked : 1
             * followed : 0
             * type : sp
             * name : 三机位
             * weight : 2
             * synopsis : 撒旦法是否所发生的说的发
             * photou : [{"id":41,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/0d3bb87b027b99b43393e13ed3d815bb.jpg"},{"id":42,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/3d777c9e66eef1a90332220485d0b0c6.jpg"},{"id":43,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/a963d95f4f4f9a0dae03c4d3649f1fb0.jpg"},{"id":44,"atlas_id":18,"photo":"http://www.boyihunjia.com/uploads/20180124/f08182ba560f5e8c2e2f80251880a544.jpg"}]
             * weddingtime : 2017-12-31
             * weddingplace : 成都千禧大酒店
             * weddingexpenses : 68000
             * weddingtypeid : 1
             * weddingenvironmentid : 4
             * weddingcover : http://www.boyihunjia.com/uploads/20180124/d2174b0b7709ccab54243e43ce856eca.jpg
             * weddingdescribe : 星空闪烁，仿佛遥远的召唤：“愿深情一眼挚爱万年，几度轮回恋恋不灭！”
             * commented : 0
             * pv : 120
             * num : 0
             * evnum : 0
             * goodscore : 0
             * tuijian : 1
             */

            private int id;
            private String title;
            private int userid;
            private int clicked;
            private String type;
            private String name;
            private int weddingexpenses;
            private String weddingcover;
            private String weddingdescribe;
            private int num;

            public int getId() {
                return id;
            }

            public void setId(int id) {
                this.id = id;
            }

            public String getTitle() {
                return title;
            }

            public void setTitle(String title) {
                this.title = title;
            }

            public int getUserid() {
                return userid;
            }

            public void setUserid(int userid) {
                this.userid = userid;
            }

            public int getClicked() {
                return clicked;
            }

            public void setClicked(int clicked) {
                this.clicked = clicked;
            }

            public String getType() {
                return type;
            }

            public void setType(String type) {
                this.type = type;
            }

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }

            public int getWeddingexpenses() {
                return weddingexpenses;
            }

            public void setWeddingexpenses(int weddingexpenses) {
                this.weddingexpenses = weddingexpenses;
            }

            public String getWeddingcover() {
                return weddingcover;
            }

            public void setWeddingcover(String weddingcover) {
                this.weddingcover = weddingcover;
            }

            public String getWeddingdescribe() {
                return weddingdescribe;
            }

            public void setWeddingdescribe(String weddingdescribe) {
                this.weddingdescribe = weddingdescribe;
            }

            public int getNum() {
                return num;
            }

            public void setNum(int num) {
                this.num = num;
            }

            public static class PhotouBean {
                /**
                 * id : 41
                 * atlas_id : 18
                 * photo : http://www.boyihunjia.com/uploads/20180124/0d3bb87b027b99b43393e13ed3d815bb.jpg
                 */

                private int id;
                private int atlas_id;
                private String photo;

                public int getId() {
                    return id;
                }

                public void setId(int id) {
                    this.id = id;
                }
            }
        }
    }

    public static class PinglunBean implements Parcelable {
        /**
         * comment_id : 14
         * user_id : 541
         * seller_id : 16
         * order_id : 301
         * goods_id : null
         * rec_id : null
         * content : 杜老师特别优秀！不错
         * created_at : 2018-03-23 10:21:32
         * updated_at : null
         * parent_id : null
         * pictures : []
         * order_score : 5
         * replay_user_id : null
         * replay_content : null
         * replay_time : 1970-01-01 08:00:00
         * anonymous : 1
         * pid : 0
         * userid : 541
         * usertype : 2
         * occupationid : 1
         * username : 13880700685
         * register : null
         * authentication : 1
         * name : 廖斌
         * identitynum : 513322198304170038
         * vouchers : 100.00
         * payvouchers : 0.00
         * pvouchers : 100.00
         * nickname : 墨修成
         * head : http://www.boyihunjia.com/Index/admin/image/180222/d4Md0279000001519271679.png
         * mobile : 13880700685
         * sex : 0
         * birthday : 419356800
         * provinceid : 24
         * cityid : 273
         * countyid : 2637
         * logintime : 1521785623
         * state : 1
         * weixin : null
         * createtime : 1520310601
         * score : 100
         * fans : 0
         * evaluate : 0
         * site : 财富领地3栋12楼
         * pv : 444
         * price : 600.00
         * num : 0
         * goodscore : 100
         * isuserivip : 0
         * userivipstat : 0
         * userivipendt : 0
         * sign : null
         * height : 0
         * weight : 0
         * age : 0
         * email :
         * isuseriviptoken :
         * onlinestatus : 1
         * inviter :
         * sort : 2
         */
        private String content;
        private String created_at;
        private int order_score;
        private int userid;
        private int occupationid;
        private String name;
        private String nickname;
        private String head;
        private int cityid;
        private int state;
        private int createtime;
        private String price;
        private int num;
        private int height;
        private List<String> pictures;
        private List<PicsBean> pics;

        public List<PicsBean> getPics() {
            return pics;
        }

        public void setPics(List<PicsBean> pics) {
            this.pics = pics;
        }

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }

        public String getCreated_at() {
            return created_at;
        }

        public void setCreated_at(String created_at) {
            this.created_at = created_at;
        }

        public int getOrder_score() {
            return order_score;
        }

        public void setOrder_score(int order_score) {
            this.order_score = order_score;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public int getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(int occupationid) {
            this.occupationid = occupationid;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public int getCityid() {
            return cityid;
        }

        public void setCityid(int cityid) {
            this.cityid = cityid;
        }

        public int getState() {
            return state;
        }

        public void setState(int state) {
            this.state = state;
        }

        public int getCreatetime() {
            return createtime;
        }

        public void setCreatetime(int createtime) {
            this.createtime = createtime;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public int getNum() {
            return num;
        }

        public void setNum(int num) {
            this.num = num;
        }

        public int getHeight() {
            return height;
        }

        public void setHeight(int height) {
            this.height = height;
        }

        public List<String> getPictures() {
            return pictures;
        }

        public void setPictures(List<String> pictures) {
            this.pictures = pictures;
        }

        public static class PicsBean implements IThumbViewInfo {

            @Override
            public String toString() {
                return "PicsBean{" +
                        "photourl='" + photourl + '\'' +
                        ", bounds=" + bounds +
                        '}';
            }

            private String photourl;

            public String getPhotourl() {
                return photourl;
            }

            public void setPhotourl(String photourl) {
                this.photourl = photourl;
            }

            public PicsBean() {
            }


            public void setUrl(String url) {
                photourl = url;
            }

            private Rect bounds;

            @Override
            public String getUrl() {
                return photourl;
            }

            public void setBounds(Rect bounds) {
                this.bounds = bounds;
            }

            @Override
            public Rect getBounds() {
                return bounds;
            }

            @Nullable
            @Override
            public String getVideoUrl() {
                return null;
            }

            @Override
            public int describeContents() {
                return 0;
            }

            @Override
            public void writeToParcel(Parcel dest, int flags) {
                dest.writeString(this.photourl);
                dest.writeParcelable(this.bounds, flags);
            }

            protected PicsBean(Parcel in) {
                this.photourl = in.readString();
                this.bounds = in.readParcelable(Rect.class.getClassLoader());
            }

            public static final Creator<PicsBean> CREATOR = new Creator<PicsBean>() {
                @Override
                public PicsBean createFromParcel(Parcel source) {
                    return new PicsBean(source);
                }

                @Override
                public PicsBean[] newArray(int size) {
                    return new PicsBean[size];
                }
            };
        }

        public PinglunBean() {
        }

        @Override
        public int describeContents() {
            return 0;
        }

        @Override
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeTypedList(this.pics);
        }

        protected PinglunBean(Parcel in) {
            this.pics = in.createTypedArrayList(PicsBean.CREATOR);
        }

        public static final Creator<PinglunBean> CREATOR = new Creator<PinglunBean>() {
            @Override
            public PinglunBean createFromParcel(Parcel source) {
                return new PinglunBean(source);
            }

            @Override
            public PinglunBean[] newArray(int size) {
                return new PinglunBean[size];
            }
        };
    }

    public static class TuijiantdBean {
        /**
         * userid : 921
         * usertype : 2
         * num : 0
         * pv : 26
         * score : 100
         * head : http://www.boyihunjia.com/home/default/imghead.png
         * nickname : Monster
         * occupationid : 0
         * occupation : null
         * zuidijia : 0
         * shopcode : 921
         */

        private int userid;
        private int usertype;
        private int num;
        private int pv;
        private int score;
        private String head;
        private String nickname;
        private String occupationid;
        private Object occupation;
        private String zuidijia;
        private String shopcode;

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public int getNum() {
            return num;
        }

        public void setNum(int num) {
            this.num = num;
        }

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public String getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(String occupationid) {
            this.occupationid = occupationid;
        }


        public String getZuidijia() {
            return zuidijia;
        }

        public void setZuidijia(String zuidijia) {
            this.zuidijia = zuidijia;
        }

    }
}
