package com.tzt.jiaotong_serialPort.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("web")
public class SerialController {

    @RequestMapping("hello")
    public String goHello(){


        return "hello";
    }
}
