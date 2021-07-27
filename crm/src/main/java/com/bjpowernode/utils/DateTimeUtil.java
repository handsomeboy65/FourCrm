package com.bjpowernode.utils;


import com.bjpowernode.exception.UserException;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTimeUtil {
   public static SimpleDateFormat simpleDateFormat10 = new SimpleDateFormat("yyyy-MM-dd");
   public static SimpleDateFormat simpleDateFormat19 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    public static long longTimeOne(String time1){
        Date parse = null;
        try {
            parse = simpleDateFormat10.parse(time1);
        } catch (ParseException e) {
            throw new UserException("账号已到期");
        }
        long time = parse.getTime();
      return time;
    }
    public static long longTimeTow(String time2){
        Date parse = null;
        try {
            parse = simpleDateFormat19.parse(time2);
        } catch (ParseException e) {
            throw new UserException("账号已到期");
        }
        long time = parse.getTime();
        return time;
    }

    public static String stringNewTime(Date time){
        String  strTime = simpleDateFormat19.format(time);
        return strTime;
    }
}
