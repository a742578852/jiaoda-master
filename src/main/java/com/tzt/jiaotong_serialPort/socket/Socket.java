package com.tzt.jiaotong_serialPort.socket;

import com.alibaba.fastjson.JSON;
import com.tzt.jiaotong_serialPort.config.EumConfig;
import com.tzt.jiaotong_serialPort.model.SetData;
import com.tzt.jiaotong_serialPort.util.SerialPortUtil;
import gnu.io.*;
import org.apache.commons.codec.binary.Hex;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import org.springframework.util.StringUtils;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;


import java.util.List;
import java.util.TooManyListenersException;
import java.util.concurrent.atomic.AtomicInteger;

@Component
@ServerEndpoint(value = "/web/socket")
public class Socket {


    /**
     * 记录当前在线连接数
     */
    private static AtomicInteger onlineCount = new AtomicInteger(0);

    SerialPort serialPort;
//    private static ApplicationContext applicationContext;
//
//    public static void setApplicationContext(ApplicationContext applicationContext) {
//        Socket.applicationContext = applicationContext;
//    }



    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session) throws NoSuchPortException, UnsupportedCommOperationException {

//        Thread.sleep(4000);
        onlineCount.incrementAndGet(); // 在线数加1
        if (onlineCount.get() > 1) {
            return;
        }
        //传输数据
        //获取串口信息
        List<String> portList = SerialPortUtil.getSerialPortList();
        System.out.println(portList);
        if (portList == null || portList.size() == 0) {
            //没有串口
            sendMessage("300", session);
        } else {
            try {

                serialPort = SerialPortUtil.openSerialPort(EumConfig.com, 115200);

                //设置串口的listener
                SerialPortUtil.setListenerToSerialPort(serialPort, event -> {
                    try {
                        Thread.sleep(20);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    //数据通知
                    if (event.getEventType() == SerialPortEvent.DATA_AVAILABLE) {
                        byte[] bytes = SerialPortUtil.readData(serialPort);
//                        System.out.println("收到的数据长度：" + bytes.length);
                        //if (Hex.encodeHexString(bytes).equals("ffff") || Hex.encodeHexString(bytes).equals("fff1")){
                            System.out.println("收到的数据：" + Hex.encodeHexString(bytes));
                        //}

                        //websocket传输数据
                        sendMessage(Hex.encodeHexString(bytes), session);
                    }
                });
//                try {
//                    // sleep 一段时间保证线程可以执行完
//                    Thread.sleep(3 * 30 * 1000);
//                } catch (InterruptedException e) {
//                    e.printStackTrace();
//                }
            } catch (TooManyListenersException | PortInUseException e) {
                if (serialPort != null) {
                    serialPort.close();
                }
                sendMessage("400", session);
                e.printStackTrace();
            }
        }

        System.out.println("有新连接加入：" + session.getId() + "，当前在线人数为：" + onlineCount.get());
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(Session session) {
        onlineCount.decrementAndGet(); // 在线数减1
        if (serialPort != null) {
            serialPort.close();
        }
        System.out.println("有一连接关闭：" + session.getId() + "，当前在线人数为：{}" + onlineCount.get());

    }

    int getMs(int hz){
       float c = (float) (1.0/hz);
       int a = (int) (c*1000.0*1000.0);
       return a;
    }

    String updateData(int num,String data){
        int c = num - data.length();
        String a = "";
        for (int i = 0;i<c;i++){
            a = a+'0';
        }
        return a+data;
    }

    public static byte[] hexStringToBytes(String hexString) {
        if (StringUtils.isEmpty(hexString)) {
            return null;
        }
        hexString = hexString.toLowerCase();
        final byte[] byteArray = new byte[hexString.length() >> 1];
        int index = 0;
        for (int i = 0; i < hexString.length(); i++) {
            if (index  > hexString.length() - 1) {
                return byteArray;
            }
            byte highDit = (byte) (Character.digit(hexString.charAt(index), 16) & 0xFF);
            byte lowDit = (byte) (Character.digit(hexString.charAt(index + 1), 16) & 0xFF);
            byteArray[i] = (byte) (highDit << 4 | lowDit);
            index += 2;
        }
        return byteArray;
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message) {
        SetData setData = JSON.parseObject(message, SetData.class);
        //加速度
        if (setData.isAcc_input()) {
            String acc = updateData(8,Integer.toHexString(getMs(setData.getAccfre()))+"");
            String sendByte = ("0101" + acc +"0D0A");
            System.out.println("加速度频率:"+setData.getAccfre());
            System.out.println("加速度转码后："+sendByte);
            SerialPortUtil.sendData(serialPort, hexStringToBytes(sendByte));
            //陀螺仪
        }else {
            SerialPortUtil.sendData(serialPort,hexStringToBytes("0101000000000D0A"));
        }
        if (setData.isGre_input()) {
            String acc = updateData(8,Integer.toHexString(getMs(setData.getGyrfre()))+"");
            String sendByte = ("0102" + acc +"0D0A");
            System.out.println("陀螺仪频率:"+setData.getGyrfre());
            System.out.println("陀螺仪转码后:"+sendByte);
            SerialPortUtil.sendData(serialPort, hexStringToBytes(sendByte));
            //磁力计
        }else {
            SerialPortUtil.sendData(serialPort,hexStringToBytes("0102000000000D0A"));
        }
        if (setData.isMag_input()) {
            String acc = updateData(8,Integer.toHexString(getMs(setData.getMagfre()))+"");
            String sendByte = ("0103" + acc +"0D0A");
            System.out.println("磁力计频率:"+setData.getMagfre());
            System.out.println("磁力计转码后"+sendByte);
            SerialPortUtil.sendData(serialPort, hexStringToBytes(sendByte));
            //光学传感器
        }else {
            SerialPortUtil.sendData(serialPort,hexStringToBytes("0103000000000D0A"));
        }
        if (setData.isOpt_input()) {
            //光学传感器频率
            String acc = updateData(8,Integer.toHexString(getMs(setData.getOptfre()))+"");
            String sendByte = ("02" + acc +"0D0A");
            System.out.println("光学传感器频率:"+setData.getOptfre());
            System.out.println("光学传感器转码后:"+sendByte);
            SerialPortUtil.sendData(serialPort, hexStringToBytes(sendByte));

            //红光
            String rel;
            if (setData.isRel_input()) {
                rel = "0501010d0a";
            }else {
                rel = "0501020d0a";
            }
            SerialPortUtil.sendData(serialPort,hexStringToBytes(rel));
            //红外
            String inf;
            if (setData.isInf_input()) {
                inf = "0502010d0a";
            } else {
                inf = "0502020d0a";
            }
            SerialPortUtil.sendData(serialPort, hexStringToBytes(inf));
            //绿光
            String green;
            if (setData.isGreen_input()) {
                green = "0503010d0a";
            } else {
                green = "0503020d0a";
            }
            SerialPortUtil.sendData(serialPort, hexStringToBytes(green));
            //蓝光
            String blue;
            if (setData.isBlue_input()) {
                blue = "0504010d0a";
            } else {
                blue = "0504020d0a";
            }
            SerialPortUtil.sendData(serialPort, hexStringToBytes(blue));

            //afe1
        } else {
            SerialPortUtil.sendData(serialPort, hexStringToBytes("02000000000D0A"));
        }
        if (setData.isBio1_input()) {
            //频率
            String acc = updateData(8,Integer.toHexString(getMs(setData.getBio1fre()))+"");
            String sendByte = ("0301" + acc +"0D0A");
            SerialPortUtil.sendData(serialPort, hexStringToBytes(sendByte));
            //通道
            String afe1PlByte = updateData(2,Integer.toHexString(setData.getBio1pass())+"");
            String sendByte1 = ("0401" + afe1PlByte + "0D0A");
            SerialPortUtil.sendData(serialPort, hexStringToBytes(sendByte1));

            //afe2
        }else {
            SerialPortUtil.sendData(serialPort, hexStringToBytes("0301000000000D0A"));
        }
        if (setData.isBio2_input()) {
//频率
            String acc = updateData(8,Integer.toHexString(getMs(setData.getBio2fre()))+"");
            String sendByte = ("0302" + acc +"0D0A");
            SerialPortUtil.sendData(serialPort, hexStringToBytes(sendByte));
            //通道
            String afe1PlByte = updateData(2,Integer.toHexString(setData.getBio2pass())+"");
            String sendByte1 = ("0402" + afe1PlByte + "0D0A");
            SerialPortUtil.sendData(serialPort, hexStringToBytes(sendByte1));
        }else {
            SerialPortUtil.sendData(serialPort, hexStringToBytes("0302000000000D0A"));
        }

    }

    @OnError
    public void onError(Throwable error){
        if (serialPort != null) {
            serialPort.close();
        }
        error.printStackTrace();

    }

    /**
     * 服务端发送消息给客户端
     */
    private void sendMessage(String message, Session toSession) {
        try {
            toSession.getBasicRemote().sendText(message);
        } catch (Exception e) {

        }
    }

}
