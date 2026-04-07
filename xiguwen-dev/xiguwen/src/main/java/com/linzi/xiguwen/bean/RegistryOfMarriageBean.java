package com.linzi.xiguwen.bean;

/**
 * Created by PC on 2018-04-13.
 * 婚姻登记处实体
 */

public class RegistryOfMarriageBean {
    /**
     *  {
     "area": 1,
     "address": "下东大街166号-2楼",
     "city": 273,
     "id": 4012,
     "phone": "028-86651671",
     "province": 24,
     "title": "成都市锦江区民政局婚姻登记处"
     }
     */
    private int area;
    private String address;
    private int city;
    private int id;
    private String phone;
    private int province;
    private String title;

    public int getArea() {
        return area;
    }

    public void setArea(int area) {
        this.area = area;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getCity() {
        return city;
    }

    public void setCity(int city) {
        this.city = city;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getProvince() {
        return province;
    }

    public void setProvince(int province) {
        this.province = province;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
