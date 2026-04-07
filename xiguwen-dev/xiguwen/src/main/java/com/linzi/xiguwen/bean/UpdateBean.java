package com.linzi.xiguwen.bean;

/**
 * Created by pc on 2018/5/7.
 */

public class UpdateBean {

    /**
     * id : 1
     * code : 7
     * aurl : http://www.boyihunjia.com/home/default/bytc_new-release.apk
     * message : 更新了一些bug
     * iurl : 11
     * fabushijian : 2018-05-07 11:27:12
     */

    private int id;
    private String code;
    private String aurl;
    private String message;
    private String iurl;
    private String fabushijian;
    private int forcedupdate;
    private String versionname ;

    public String getVersionname() {
        return versionname;
    }

    public void setVersionname(String versionname) {
        this.versionname = versionname;
    }

    public int getForcedupdate() {
        return forcedupdate;
    }

    public void setForcedupdate(int forcedupdate) {
        this.forcedupdate = forcedupdate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getAurl() {
        return aurl;
    }

    public void setAurl(String aurl) {
        this.aurl = aurl;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getIurl() {
        return iurl;
    }

    public void setIurl(String iurl) {
        this.iurl = iurl;
    }

    public String getFabushijian() {
        return fabushijian;
    }

    public void setFabushijian(String fabushijian) {
        this.fabushijian = fabushijian;
    }
}
