package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by PC on 2018-03-30.
 */

public class MyExampleDetailBean extends MyExampleBean {
    /**ExampleBean
     * {
     　　　　　　"clicked":15,
     　　　　　　"commented":0,
     　　　　　　"create_ti":1514690716,
     　　　　　　"evnum":0,
     　　　　　　"examinetime":"2018-01-24 17:33:07",
     　　　　　　"followed":0,
     　　　　　　"goodscore":0,
     　　　　　　"id":8,
     　　　　　　"num":0,
     　　　　　　"putaway":1,
     　　　　　　"pv":15,
     　　　　　　"statecontent":"审核通过",
     　　　　　　"status":2,
     　　　　　　"title":"爱的伊甸园",
     　　　　　　"update_ti":1516786230,
     　　　　　　"userid":16,
     　　　　　　"username":"18581882801",
     　　　　　　"weddingcover":"http://boyiapi.xxwlb.com/uploads/20180124/a8d392dbf3ad02968e65de54751f0f50.png",
     　　　　　　"weddingdescribe":"小草柔软的手臂托起太阳 不同肤色的人走向你 汇成光芒，你像钟一样敲响 震落了山顶的积雪 皱纹深动颤抖的恐惧和忧伤 心灵不再躲到幕布后面 书打开窗户，让群鸟自由飞翔 老树不再打鼾，不再用枯藤 缠住孩子那灵活的小腿 少女们从沐浴中归来 摇曳着星星和辽阔的月光 每个人都有自己的名字 自己的声音，爱情和愿望 兀立在噩梦中的冰山 在早晨消融，从残留的夜色中 人们领走了各自的影子 让沉重的记忆在脚下 在行走中渐渐消失 手臂和手臂相连的地平线上 每个故事有了新的开始 那就开始吧！",
     　　　　　　"weddingenvironmentid":2,
     　　　　　　"weddingexpenses":168000,
     　　　　　　"weddingplace":"爱登堡酒店",
     　　　　　　"weddingtime":"2017-12-31",
     　　　　　　"weddingtypeid":1,
     　　　　　　"weigh":1
     　　　　}
     */

    /**
     * {
     -------"clicked": 82,
     -------"commented": 0,
     -------"create_ti": 1514692956,
     -------"evnum": 0,
     -------"examinetime": 1516786386,
     -------"followed": 1,
     -------"goodscore": 0,
     -------"id": 10,
     -------"num": 0,
     "phtupian": {
     "id": 11177,
     "mycase_id": 18624,
     "photourl": "测试内容8jw5"
     },
     --------"putaway": 1,
     --------"pv": 82,
     --------"statecontent": "审核通过",
     --------"status": 2,
     --------"title": "回忆",
     --------"update_ti": 1516786353,
     --------"userid": 16,
     --------"username": "18581882801",
     --------"weddingcover": "http://boyiapi.xxwlb.com/uploads/20180124/8837e88f062dd071ad7fa7020cb44e34.png",
     --------"weddingdescribe": "遥（姚）看琼楼登云海，也情也愿不相忘！鱼（余）游浅水戏乌篷，悦目清心归人家。衷心祝福最好的你们！",
     --------"weddingenvironmentid": 1,
     --------"weddingexpenses": 28000,
     --------"weddingplace": "成都世纪城洲际大酒店",
     --------"weddingtime": "2017-12-31",
     --------"weddingtypeid": 1,
     --------"weigh": 2
     }
     */

    private List<Photo> phtupian;

    public List<Photo> getPhtupian() {
        return phtupian;
    }

    public void setPhtupian(List<Photo> phtupian) {
        this.phtupian = phtupian;
    }

    public static class Photo implements Serializable{
        private int id;
        private int mycase_id;
        private String photourl;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getMycase_id() {
            return mycase_id;
        }

        public void setMycase_id(int mycase_id) {
            this.mycase_id = mycase_id;
        }

        public String getPhotourl() {
            return photourl;
        }

        public void setPhotourl(String photourl) {
            this.photourl = photourl;
        }
    }
}
