package com.tzt.jiaotong_serialPort.socket;

import com.alibaba.fastjson.JSON;
import com.tzt.jiaotong_serialPort.model.SetData;
import com.tzt.jiaotong_serialPort.util.SerialPortUtil;
import gnu.io.*;
import org.apache.commons.codec.binary.Hex;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

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


    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session) throws NoSuchPortException, PortInUseException, UnsupportedCommOperationException, TooManyListenersException, InterruptedException {

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

                serialPort = SerialPortUtil.openSerialPort("COM3", 115200);
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
                        System.out.println("收到的数据长度：" + bytes.length);
                        System.out.println("收到的数据：" + Hex.encodeHexString(bytes));
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
    public void onClose(Session session) throws NoSuchPortException, PortInUseException, UnsupportedCommOperationException, TooManyListenersException {
        onlineCount.decrementAndGet(); // 在线数减1
        if (serialPort != null) {
            serialPort.close();
        }
        System.out.println("有一连接关闭：" + session.getId() + "，当前在线人数为：{}" + onlineCount.get());

    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        SetData setData = JSON.parseObject(message, SetData.class);
        //加速度
        if (setData.isAcc_input()) {
            byte[] sendByte = ("01"+Integer.toHexString(setData.getAccfre())+"0D0A").getBytes();
            SerialPortUtil.sendData(serialPort,sendByte);
            //陀螺仪
        } else if (setData.isGre_input()) {
            byte[] sendByte = ("01"+Integer.toHexString(setData.getAccfre())+"0D0A").getBytes();
            SerialPortUtil.sendData(serialPort,sendByte);
            //磁力计
        } else if (setData.isMag_input()) {
            byte[] sendByte = "0110D0A".getBytes();
            SerialPortUtil.sendData(serialPort,sendByte);
            //光学传感器
        } else if (setData.isOpt_input()) {

            //afe1
        } else if (setData.isBio1_input()) {

            //afe2
        } else if (setData.isBio2_input()) {

        }

    }

    @OnError
    public void onError(Session session, Throwable error) throws NoSuchPortException, PortInUseException, UnsupportedCommOperationException, TooManyListenersException {
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
