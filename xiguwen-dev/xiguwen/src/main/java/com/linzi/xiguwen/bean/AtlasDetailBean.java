package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by PC on 2018-03-29.
 */

public class AtlasDetailBean extends AtlasBean{
    /**
     * {
     "clicked": 1,
     "cover": "http://boyiapi.xxwlb.com/uploads/20180113/da3083cdbdb2d86a12bf393b09740f18.jpg",
     "create_ti": 1515850774,
     "examinetime": 1515851172,
     "followed": 0,
     "id": 16,
     "name": "31",
     "photourl": [
     {
     "atlas_id": 16,
     "id": 34,
     "photo": "http://boyiapi.xxwlb.com/uploads/20180113/b771e4e8af686b643b7ee411a7835829.jpg"
     }
     ],
     "putaway": 0,
     "statecontent": "vsdfvsdf ",
     "status": 3,
     "synopsis": "123",
     "update_ti": 1515850904,
     "userid": 16,
     "username": "18581882801",
     "weight": 1
     },
     */

    private List<PhotoBean> photourl;

    public List<PhotoBean> getPhotourl() {
        return photourl;
    }

    public void setPhotourl(List<PhotoBean> photourl) {
        this.photourl = photourl;
    }


    public static class PhotoBean implements Serializable{
        private int atlas_id;
        private int id;
        private String photo;

        public int getAtlas_id() {
            return atlas_id;
        }

        public void setAtlas_id(int atlas_id) {
            this.atlas_id = atlas_id;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getPhoto() {
            return photo;
        }

        public void setPhoto(String photo) {
            this.photo = photo;
        }
    }
}
