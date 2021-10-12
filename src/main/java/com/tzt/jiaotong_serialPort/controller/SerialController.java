package com.tzt.jiaotong_serialPort.controller;

import com.tzt.jiaotong_serialPort.config.EumConfig;
import com.tzt.jiaotong_serialPort.model.SetData;
import com.tzt.jiaotong_serialPort.socket.Socket;
import com.tzt.jiaotong_serialPort.util.SerialPortUtil;
import gnu.io.NoSuchPortException;
import gnu.io.PortInUseException;
import gnu.io.SerialPort;
import gnu.io.UnsupportedCommOperationException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.websocket.Session;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("web")
public class SerialController {

    /**
     * 首页地址
     * @return
     */
    @RequestMapping("hello")
    public String goHello(){


        return "hello";
    }

//    @RequestMapping("test")
//    public String goTest(){
//
//
//        return "test";
//    }

//    /**
//     * 模块配置
//     * @param
//     * @return
//     */
//    @PostMapping("setUp")
//    @ResponseBody
//    public Map setUp(SetData setData){
//
//
//
//        Map map = new HashMap();
//        map.put("code",200);
//        return map;
//    }

    @PostMapping("flush")
    @ResponseBody
    public Map flush() throws NoSuchPortException, PortInUseException, UnsupportedCommOperationException {
        Map map = new HashMap();
        //关闭串口
//        final SerialPort serialPort = SerialPortUtil.openSerialPort("COM3");
//        SerialPortUtil.closeSerialPort(serialPort);


        map.put("code",200);
        return map;
    }

    //设置串口
    @ResponseBody
    @PostMapping("setCom")
    public Map setCom(String comName){
        Map map = new HashMap();
        EumConfig.com = comName;
        return map;
    }


    //获取串口信息
    @ResponseBody
    @PostMapping("getCom")
    public List<String> getCom(){
        List<String> portList = SerialPortUtil.getSerialPortList();
        return portList;
    }

}
