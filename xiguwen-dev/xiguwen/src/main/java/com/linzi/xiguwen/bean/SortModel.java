package com.linzi.xiguwen.bean;

import android.graphics.Bitmap;

public class SortModel {

	/**
	 * 地区选择
	 */

	private String city_name;
	private String city_code;
	private String pinyin;

	public String getPinyin() {
		return pinyin;
	}

	public void setPinyin(String pinyin) {
		this.pinyin = pinyin;
	}

	public String getCity_code() {
		return city_code;
	}

	public void setCity_code(String city_code) {
		this.city_code = city_code;
	}

	public String getCity_name() {
		return city_name;
	}

	public void setCity_name(String city_name) {
		this.city_name = city_name;
	}

	/**
	 * 联系人
	 */
	String id;
	String phone;
	String name;
	Bitmap head;
	String head_url;

	public String getHead_url() {
		return head_url;
	}

	public void setHead_url(String head_url) {
		this.head_url = head_url;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Bitmap getHead() {
		return head;
	}

	public void setHead(Bitmap head) {
		this.head = head;
	}
}
