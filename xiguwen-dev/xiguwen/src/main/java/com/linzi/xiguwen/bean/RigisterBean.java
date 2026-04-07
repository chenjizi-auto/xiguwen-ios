package com.linzi.xiguwen.bean;

/**
 * Created by jiang on 2018/1/31.
 */

public class RigisterBean{

    /**
     * code : 0
     * data : {"token":{"login_time":"1000","token":"00000xx","type":"0","userid":"21213"}}
     * message : 错了
     */

    private String code;
    private DataBean data;
    private String message;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public DataBean getData() {
        return data;
    }

    public void setData(DataBean data) {
        this.data = data;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static class DataBean {
        /**
         * token : {"login_time":"1000","token":"00000xx","type":"0","userid":"21213"}
         */

        private TokenBean token;

        public TokenBean getToken() {
            return token;
        }

        public void setToken(TokenBean token) {
            this.token = token;
        }

        public static class TokenBean {
            /**
             * login_time : 1000
             * token : 00000xx
             * type : 0
             * userid : 21213
             */

            private String login_time;
            private String token;
            private String type;
            private String userid;

            public String getLogin_time() {
                return login_time;
            }

            public void setLogin_time(String login_time) {
                this.login_time = login_time;
            }

            public String getToken() {
                return token;
            }

            public void setToken(String token) {
                this.token = token;
            }

            public String getType() {
                return type;
            }

            public void setType(String type) {
                this.type = type;
            }

            public String getUserid() {
                return userid;
            }

            public void setUserid(String userid) {
                this.userid = userid;
            }
        }
    }
}
