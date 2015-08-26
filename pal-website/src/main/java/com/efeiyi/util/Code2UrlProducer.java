package com.efeiyi.util;

import org.apache.commons.lang.RandomStringUtils;

/**
 * Created by Administrator on 2015/8/20.
 */
public class Code2UrlProducer implements Runnable {

    static transient int count = 0;

    public void run() {
        while (true) {
            String code = RandomStringUtils.randomNumeric(18);
            code = Long.toString(Long.parseLong(code), 36);
            if (code.length() == 12) {
                Code2UrlConsumer.codeList.add(code);
                ++count;
            }
            if (count == 100000) {
                synchronized (Code2UrlConsumer.codeList) {
                    Code2UrlConsumer.codeList.notifyAll();
                }
                break;
            }
        }
        System.out.println("生成codeList：" + Code2UrlConsumer.codeList.size());
    }
}
