package com.linzi.xiguwen.utils;

import android.content.ContentResolver;
import android.content.ContentUris;
import android.content.Context;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.provider.ContactsContract;
import android.text.TextUtils;


import com.linzi.xiguwen.R;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by linzi on 2017/7/11.
 */

public class GetContactsUtils {
    private static final String[] PHONES_PROJECTION = new String[] {
              ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME
            , ContactsContract.CommonDataKinds.Phone.NUMBER
            , ContactsContract.CommonDataKinds.Photo.PHOTO_ID
            , ContactsContract.CommonDataKinds.Phone.CONTACT_ID };
    /** 联系人显示名称 **/
    private static final int PHONES_DISPLAY_NAME_INDEX = 0;

    /** 电话号码 **/
    private static final int PHONES_NUMBER_INDEX = 1;

    /** 头像ID **/
    private static final int PHONES_PHOTO_ID_INDEX = 2;

    /** 联系人的ID **/
    private static final int PHONES_CONTACT_ID_INDEX = 3;
    static Context mContext;
    public static List<Contacts>mContacts=new ArrayList<>();
    static Contacts contact;

    public static List<Contacts> getContacts(Context context){
        mContext=context;
        mContacts.clear();
        //获取手机通讯录联系人
        ContentResolver resolver = mContext.getContentResolver();
        // 获取手机联系人
        Cursor phoneCursor = resolver.query(ContactsContract.CommonDataKinds.Phone.CONTENT_URI
                , PHONES_PROJECTION ,
                null, null, null);

        if (phoneCursor != null) {
            while (phoneCursor.moveToNext()) {
                //得到手机号码
                String phoneNumber = phoneCursor.getString(PHONES_NUMBER_INDEX);
                //当手机号码为空的或者为空字段 跳过当前循环
                if (TextUtils.isEmpty(phoneNumber))
                    continue;
                //得到联系人名称
                String contactName = phoneCursor.getString(PHONES_DISPLAY_NAME_INDEX);

                //得到联系人ID
                Long contactid = phoneCursor.getLong(PHONES_CONTACT_ID_INDEX);

                //得到联系人头像ID
                Long photoid = phoneCursor.getLong(PHONES_PHOTO_ID_INDEX);

                //得到联系人头像Bitamp
                Bitmap contactPhoto = null;

                //photoid 大于0 表示联系人有头像 如果没有给此人设置头像则给他一个默认的
                if (photoid > 0) {
                    Uri uri = ContentUris.withAppendedId(ContactsContract.Contacts.CONTENT_URI, contactid);
                    InputStream input = ContactsContract.Contacts.openContactPhotoInputStream(resolver, uri);
                    contactPhoto = BitmapFactory.decodeStream(input);
                } else {
                    contactPhoto = BitmapFactory.decodeResource(mContext.getResources(), R.mipmap.ic_launcher);
                }
                if(phoneNumber.contains("+86")){
                    phoneNumber=phoneNumber.replaceAll("\\+86","");
                }
                if(phoneNumber.length()>8){
                    if(phoneNumber.substring(0,2).contains("86")){
                        phoneNumber=phoneNumber.substring(2,phoneNumber.length()-1);
                    }
                }
                if(phoneNumber.contains(" ")){
                    phoneNumber=phoneNumber.replaceAll(" ","");
                }

                if(phoneNumber.length()>7&&phoneNumber.length()<17) {
                    contact = new Contacts();
                    contact.setPhone(phoneNumber);
                    contact.setName(contactName);
                    contact.setHead(contactPhoto);
                    mContacts.add(contact);
                }
            }
            phoneCursor.close();
        }


        // 获取Sims卡联系人
        try{
            Uri uri = Uri.parse("content://icc/adn");
            String[] projection = {"_id", "name", "number"};
            Cursor simCursor = resolver.query(uri, null, null, null,
                    null);
            com.linzi.xiguwen.utils.LogUtil.d("11111111111", "getContacts: ");
            if (simCursor != null) {
                com.linzi.xiguwen.utils.LogUtil.d("22222222222", "getContacts: ");
                while (simCursor.moveToNext()) {
                    // 得到手机号码
                    String phoneNumber = simCursor.getString(PHONES_NUMBER_INDEX);
                    // 当手机号码为空的或者为空字段 跳过当前循环
                    if (TextUtils.isEmpty(phoneNumber))
                        continue;
                    // 得到联系人名称
                    String contactName = simCursor
                            .getString(PHONES_DISPLAY_NAME_INDEX);

                    //Sim卡中没有联系人头像
                    Bitmap contactPhoto = BitmapFactory.decodeResource(mContext.getResources(), R.mipmap.ic_launcher);

                    contact =new Contacts();
                    contact.setPhone(phoneNumber);
                    contact.setName(contactName);
                    contact.setHead(contactPhoto);
                    mContacts.add(contact);
                }

                simCursor.close();
            }
        }catch (Exception e){
            com.linzi.xiguwen.utils.LogUtil.d("读取联系人异常", "getContacts: "+e.toString());
        }

        return removeDuplicate(mContacts);
    }

    private static List<Contacts> removeDuplicate(List<Contacts> list)
    {
        Set set = new LinkedHashSet<Contacts>();
        set.addAll(list);
        list.clear();
        list.addAll(set);
        return list;
    }

    public static class Contacts{
        String id;
        String phone;
        String name;
        Bitmap head;

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
}
