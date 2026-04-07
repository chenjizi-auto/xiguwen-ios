package com.linzi.xiguwen.utils;

import android.text.TextUtils;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.List;

/**
 * 价格计算
 *
 * @author tinyyoung
 */

public class NumberUtil {
    public static String subtransfer(String... number) {
        try {
            BigDecimal bigDecimal = new BigDecimal(number[0]);
            for (int i = 1; i < number.length; i++) {
                bigDecimal = bigDecimal.subtract(new BigDecimal(number[i]));
            }
            double result = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            DecimalFormat df = new DecimalFormat("0.00");
            return df.format(result);
        } catch (Exception e) {
            return "0.00";
        }
    }

    /**
     * 价格计算 加
     *
     * @param number
     * @return
     */
    public static String add(String... number) {
        try {
            if (number == null || number.length == 0) {
                return "0.00";
            }
            BigDecimal bigDecimal = new BigDecimal("0.00");
            for (String num : number) {
                bigDecimal = new BigDecimal(num).add(bigDecimal);
            }
            double result = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            DecimalFormat df = new DecimalFormat("0.00");
            return df.format(result);
        } catch (Exception e) {
            return "0.00";
        }
    }

    /**
     * 价格计算 加
     *
     * @param number
     * @return
     */
    public static String addForNum(String... number) {
        try {
            if (number == null || number.length == 0) {
                return "0.00";
            }
            BigDecimal bigDecimal = new BigDecimal("0.00");
            for (String num : number) {
                bigDecimal = new BigDecimal(num).add(bigDecimal);
            }
            double result = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            DecimalFormat df = new DecimalFormat("0");
            return df.format(result);
        } catch (Exception e) {
            return "0";
        }
    }

    /**
     * 价格计算 加
     *
     * @param numbers
     * @return
     */
    public static String add(List<String> numbers) {
        try {
            BigDecimal bigDecimal = new BigDecimal("0.00");
            for (String num : numbers) {
                bigDecimal = new BigDecimal(num).add(bigDecimal);
            }
            double result = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            DecimalFormat df = new DecimalFormat("0.00");
            return df.format(result);
        } catch (Exception e) {
            return "0.00";
        }
    }

    /**
     * 比较两个字符串大小
     *
     * @return num1==num1:0  num1<num1: <0  num1>num1: >0
     */
    public static long A_compare_B(String num1, String num2) {
        try {
            return new BigDecimal(num1).compareTo(new BigDecimal(num2));
        } catch (Exception e) {
            return -1;
        }
    }

    public static String format_moneybystr(String num1) {
        try {
            DecimalFormat df = new DecimalFormat("0.00");
            return df.format(new BigDecimal(num1));
        } catch (Exception e) {
            return "0.00";
        }
    }


    public static String format_moneybystr(float num1) {
        try {
            DecimalFormat df = new DecimalFormat("0.00");
            return df.format(new BigDecimal(num1));
        } catch (Exception e) {
            return "0.00";
        }
    }

    public static String format_moneybystr(double num1) {
        try {
            DecimalFormat df = new DecimalFormat("0.00");
            return df.format(new BigDecimal(num1));
        } catch (Exception e) {
            return "0.00";
        }
    }

    /**
     * 价格计算 乘法
     *
     * @param num1
     * @param num2
     * @return
     */
    public static String AmultiplyB(String num1, String num2) {
        if (null == num1 || null == num2) {
            return "0.00";
        }
        try {
            BigDecimal bigDecimal = new BigDecimal(num1);
            bigDecimal = bigDecimal.multiply(new BigDecimal(num2));
            double result = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            DecimalFormat df = new DecimalFormat("0.00");
            return df.format(result);
        } catch (Exception e) {
            return "0.00";
        }
    }

    /**
     * 减法
     *
     * @param num1
     * @param num2
     * @return
     */
    public static String AsubB(String num1, String num2) {

        if (TextUtils.isEmpty(num1) || TextUtils.isEmpty(num2)) {
            return "0.00";
        }
        try {
            BigDecimal bigDecimal = new BigDecimal(num1);
            bigDecimal = bigDecimal.subtract(new BigDecimal(num2));
            double result = bigDecimal.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
            DecimalFormat df = new DecimalFormat("0.00");
            return df.format(result);
        } catch (Exception e) {
            return "0.00";
        }
    }
}
