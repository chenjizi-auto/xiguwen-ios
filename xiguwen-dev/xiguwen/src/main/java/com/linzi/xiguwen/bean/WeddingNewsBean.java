package com.linzi.xiguwen.bean;

/**
 * Created by PC on 2018-04-09.
 */

public class WeddingNewsBean {
    /**
     * {
     * "columnid": 30,
     * "content": "<p>泰国这个优雅而有韵味的国度，吸引很多人驻足。现在旅行结婚成为小年轻们的喜欢的结婚形式，有很多小情侣们都跑到泰国旅行结婚。那到喜啦为你介绍泰国旅行结婚攻略：</p><p>泰国旅行结婚攻略1：清迈</p><p>清迈大学很漂亮，还有孔子学院，在校区内的其中一个景色更是迷人，相机是拍不出来，各种热带树木在其中，藤条、树干交织在一起。过了清迈大学上素贴山就是双龙寺了。清迈的物价非常便宜，比曼谷便宜好多，美食也很多，尤其是清迈的粉儿，非常棒。</p>",
     * "createtime": 1515504903,
     * "is_show": 1,
     * "isnew": 0,
     * "pv": 0,
     * "title": "泰国旅行结婚攻略",
     * "typeid": 19,
     * "typename": "新闻",
     * "updatetime": 1515504903,
     * "weigh": 1
     * }
     */
    //公告
    public static final int TYPE_NOTIC = 1;
    //新闻
    public static final int TYPE_NEWS = 2;


    private long columnid;
    private String title;       // 标题
    private int typeid;
    private String typename;    // 类型名称
    private int weigh;
    private int is_show;
    private int isnew;
    private String content;     // 内容url
    private long createtime;    // 创建时间戳
    private long updatetime;    // 更新时间戳
    private int pv;
    private String img; //封面图片
    private String src;
    private String descr;//描述

    public String getDescr() {
        return descr;
    }

    public void setDescr(String descr) {
        this.descr = descr;
    }

    public long getColumnid() {
        return columnid;
    }

    public void setColumnid(long columnid) {
        this.columnid = columnid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public long getCreatetime() {
        return createtime;
    }

    public void setCreatetime(long createtime) {
        this.createtime = createtime;
    }

    public int getIs_show() {
        return is_show;
    }

    public void setIs_show(int is_show) {
        this.is_show = is_show;
    }

    public int getIsnew() {
        return isnew;
    }

    public void setIsnew(int isnew) {
        this.isnew = isnew;
    }

    public int getPv() {
        return pv;
    }

    public void setPv(int pv) {
        this.pv = pv;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getTypeid() {
        return typeid;
    }

    public void setTypeid(int typeid) {
        this.typeid = typeid;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename;
    }

    public long getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(long updatetime) {
        this.updatetime = updatetime;
    }

    public int getWeigh() {
        return weigh;
    }

    public void setWeigh(int weigh) {
        this.weigh = weigh;
    }

    public String getImg() {
        return img;
    }

    public void setImg(String img) {
        this.img = img;
    }

    public String getSrc() {
        return src;
    }

    public void setSrc(String src) {
        this.src = src;
    }
}
