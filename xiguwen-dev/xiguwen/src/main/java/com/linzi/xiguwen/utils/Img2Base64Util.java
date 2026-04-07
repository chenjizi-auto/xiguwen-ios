package com.linzi.xiguwen.utils;

/**
 * Created by PC on 2018-03-27.
 */


import android.util.Base64;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

/**
 * 将图片转换为Base64<br>
 * 将base64编码字符串解码成img图片
 * @创建时间 2015-06-01 15:50
 *
 */
public class Img2Base64Util {


    /**
     * 将图片转换成Base64编码
     * @param imgFile 待处理图片
     * @return
     */
    public static String getImgStr(String imgFile){
        //将图片文件转化为字节数组字符串，并对其进行Base64编码处理


        InputStream in = null;
        byte[] data = null;
        //读取图片字节数组
        try
        {
            in = new FileInputStream(imgFile);
            data = new byte[in.available()];
            in.read(data);
            in.close();
        }
        catch (IOException e)
        {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        return new String(Base64.encode(data,Base64.DEFAULT));
    }

    /**
     * 对字节数组字符串进行Base64解码并生成图片
     * @param imgStr 图片数据
     * @param imgFilePath 保存图片全路径地址
     * @return
     */
    public static boolean generateImage(String imgStr,String imgFilePath){
        //
        if (imgStr == null) //图像数据为空
            return false;

        try
        {
            //Base64解码
            byte[] b = Base64.decode(imgStr,Base64.DEFAULT);
            for(int i=0;i<b.length;++i)
            {
                if(b[i]<0)
                {//调整异常数据
                    b[i]+=256;
                }
            }
            //生成jpeg图片

            OutputStream out = new FileOutputStream(imgFilePath);
            out.write(b);
            out.flush();
            out.close();
            return true;
        }
        catch (Exception e)
        {
            return false;
        }
    }

    public static String getMimeTypeHead(String file){
        String cache = file.toLowerCase();
        if(cache.endsWith("jpg") || cache.endsWith("jpeg")){
            return "data:image/jpg;base64,";
        }else if(cache.endsWith("png")){
            return "data:image/png;base64,";
        }else if(cache.endsWith("gif")){
            return "data:image/gif;base64,";
        }else if(cache.endsWith("bmp")){
            return "data:image/bmp;base64,";
        }
        return "data:image/jpg;base64,";
    }
}