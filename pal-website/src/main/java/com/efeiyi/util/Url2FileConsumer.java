package com.efeiyi.util;


import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Created by Administrator on 2015/8/24.
 */
public class Url2FileConsumer implements Runnable {

    static Map<String, String> codeUrlMap = new ConcurrentHashMap<>();
    static boolean theEnd = false;

    public void run() {
        try {
            BufferedWriter bw = new BufferedWriter(new FileWriter(new File("d:/abc.txt")));
            long start = System.currentTimeMillis();
            while (true) {

                if (codeUrlMap.size() < 100000) {
                    System.out.println("当前codeUrlMap：" + codeUrlMap.size());
                    System.out.println("当前codeList：" + Code2UrlConsumer.codeList.size());
                    synchronized (Code2UrlConsumer.codeList){
                        Code2UrlConsumer.codeList.notifyAll();
                    }
                    Thread.currentThread().sleep(3000);
                } else {
                    System.out.println("当前：" + codeUrlMap.size());
                    Url2FileConsumer.theEnd = true;
                    synchronized (Code2UrlConsumer.codeList) {
                        Code2UrlConsumer.codeList.notifyAll();
                    }
                    for (Map.Entry<String, String> entry : codeUrlMap.entrySet()) {
                        bw.write(entry.getKey() + ":" + entry.getValue() + "\n");
                    }
                    break;
                }
            }
            bw.flush();
            System.out.println("输出用时：" + (System.currentTimeMillis() - start));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
