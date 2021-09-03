package com.tzt.jiaotong_serialPort.controller;

import com.tzt.jiaotong_serialPort.model.SetData;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
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

    /**
     * 模块配置
     * @param setData
     * @return
     */
    @PostMapping("setUp")
    @ResponseBody
    public Map setUp(SetData setData){

        Map map = new HashMap();
        map.put("code",200);
        return map;
    }

}
