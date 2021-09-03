package com.tzt.jiaotong_serialPort.socket;

import com.tzt.jiaotong_serialPort.util.SerialPortUtil;
import gnu.io.*;
import org.apache.commons.codec.binary.Hex;

import java.util.List;
import java.util.TooManyListenersException;

public class SerialDataSocket {

    Socket socket = new Socket();
    public void toMessageSerial(){
        List<String> portList = SerialPortUtil.getSerialPortList();
        System.out.println(portList);

        try {
            final SerialPort serialPort = SerialPortUtil.openSerialPort("COM3", 115200);
            //设置串口的listener
            SerialPortUtil.setListenerToSerialPort(serialPort, event -> {
                //数据通知
                if (event.getEventType() == SerialPortEvent.DATA_AVAILABLE) {
                    byte[] bytes = SerialPortUtil.readData(serialPort);
                    System.out.println("收到的数据长度：" + bytes.length);
                    System.out.println("收到的数据："+ Hex.encodeHexString(bytes));
                    //websocket传输数据



                }
            });
//            try {
//                // sleep 一段时间保证线程可以执行完
//                Thread.sleep(3 * 30 * 1000);
//            } catch (InterruptedException e) {
//                e.printStackTrace();
//            }
        } catch (NoSuchPortException | PortInUseException | UnsupportedCommOperationException | TooManyListenersException e) {
            e.printStackTrace();
        }
    }

}
