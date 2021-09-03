package com.tzt.jiaotong_serialPort.socket;

import com.tzt.jiaotong_serialPort.util.SerialPortUtil;
import gnu.io.*;
import org.apache.commons.codec.binary.Hex;
import org.springframework.stereotype.Component;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TooManyListenersException;
import java.util.concurrent.atomic.AtomicInteger;

@Component
@ServerEndpoint(value = "/web/socket")
public class Socket {

    /** 记录当前在线连接数 */
    private static AtomicInteger onlineCount = new AtomicInteger(0);

    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public void onOpen(Session session) {
        onlineCount.incrementAndGet(); // 在线数加1

        //传输数据
        //获取串口信息
        List<String> portList = SerialPortUtil.getSerialPortList();
        if (portList == null || portList.size() == 0){
            //没有串口
            sendMessage("300",session);
        }else {
            try {

                final SerialPort serialPort = SerialPortUtil.openSerialPort("COM3", 115200);
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
                        System.out.println("收到的数据："+ Hex.encodeHexString(bytes));
                        //websocket传输数据
                        sendMessage(Hex.encodeHexString(bytes),session);

                    }
                });
            try {
                // sleep 一段时间保证线程可以执行完
                Thread.sleep(3 * 30 * 1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            } catch (NoSuchPortException | PortInUseException | UnsupportedCommOperationException | TooManyListenersException e) {
                sendMessage("400",session);
                e.printStackTrace();
            }
        }

        System.out.println("有新连接加入："+session.getId()+"，当前在线人数为："+ onlineCount.get());
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(Session session) {
        onlineCount.decrementAndGet(); // 在线数减1
        System.out.println("有一连接关闭："+session.getId()+"，当前在线人数为：{}"+ onlineCount.get());
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message
     *            客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("服务端收到客户端"+session.getId()+"的消息:"+ message);

    }

    @OnError
    public void onError(Session session, Throwable error) {

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
