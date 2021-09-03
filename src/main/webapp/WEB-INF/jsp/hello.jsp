<%--
  Created by IntelliJ IDEA.
  User: PC
  Date: 2021/8/29
  Time: 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>

    <link rel="stylesheet" href="//unpkg.com/layui@2.6.8/dist/css/layui.css">
    <script src="//unpkg.com/layui@2.6.8/dist/layui.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/echarts@5.1.2/dist/echarts.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.js"></script>
    <title>串口数据</title>
</head>
<body>

<div class="layui-container">

    <div class="layui-row">
        <div class="layui-col-md9">

            <div id="ser_connect" style="padding: 30px;" class="layui-row layui-col-space15">
                <span style="font-weight: bold">串口连接状态:</span>
                <span>
                    <i class="layui-icon layui-icon-rss" style="font-size: 30px; color: green;"></i>
                    <span style="color: green">连接正常</span>
                </span>

            </div>

            <div id="ser_break" style="padding: 30px;display: none" class="layui-row layui-col-space15">
                <span style="font-weight: bold">串口连接状态:</span>
                <span>
                    <i class="layui-icon layui-icon-rss" style="font-size: 30px; color: red;"></i>
                    <span style="color: red">连接断开</span>
                </span>

            </div>


            <div style="padding: 30px" class="layui-row layui-col-space15">
                <!--数据储存区-->
                <form class="layui-form">
                    <div style="padding: 10px">
                        <label class="layui-form-label">数据保存</label>
                        <div class="layui-input-block">
                            <input type="text" name="data_name" required lay-verify="required" placeholder="请输入文件名"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div style="padding: 10px;display: flex;justify-content: space-between">
                        <div>
                            <label class="layui-form-label">定时</label>
                            <div class="layui-input-block">
                                <input type="number" name="data_time" placeholder="请输入时长,单位:秒" autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                        <div>
                            <input type="checkbox" name="yyy" lay-skin="switch" lay-text="ON|OFF">
                        </div>
                    </div>

                    <div style="padding: 10px;display: flex;justify-content: space-around">
                        <button type="button" class="layui-btn">开始</button>
                        <button type="button" class="layui-btn layui-btn-normal">暂停</button>
                        <button type="button" class="layui-btn layui-btn-warm">结束</button>
                    </div>

                    <div style="padding: 10px;margin-right: 20px">
                        <span>已保存数据长度:
                            <span style="color: green">
                             24
                            </span>
                            S
                        </span>
                    </div>

                </form>

            </div>
            <!--数据显示页面-->
            <div style="padding: 30px" class="layui-row layui-col-space15">
                <div style="padding: 10px;">

                    <select id="select" name="city" lay-verify="" style="height: 30px">
                        <option value="">请选择要查看的传感器或通道</option>
                        <option value="010">加速度计</option>
                        <option value="021">陀螺仪</option>
                        <option value="0571">磁力计</option>
                        <option value="0571">光学传感器</option>
                        <option value="0571">1-生物电势AFE</option>
                        <option value="0571">2-生物电势AFE</option>
                    </select>
                </div>
                <!--图表-->
                <div>
                    <div id="main" style="width: 800px;height:400px;"></div>


                    <!--实时数据-->
                    <script type="text/javascript">
                        // 1 单独一个
                        var myChart = echarts.init(document.getElementById('main'));

                        var option;

                        option = {
                            title: {
                                text: '折线图堆叠'
                            },
                            tooltip: {
                                trigger: 'axis'
                            },
                            legend: {
                                data: ['邮件营销', '联盟广告', '视频广告', '直接访问', '搜索引擎']
                            },
                            grid: {
                                left: '3%',
                                right: '4%',
                                bottom: '3%',
                                containLabel: true
                            },
                            toolbox: {
                                feature: {
                                    saveAsImage: {}
                                }
                            },
                            xAxis: {
                                type: 'category',
                                boundaryGap: false,
                                data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
                            },
                            yAxis: {
                                type: 'value'
                            },
                            series: [
                                {
                                    name: '邮件营销',
                                    type: 'line',
                                    stack: '总量',
                                    data: [120, 132, 101, 134, 90, 230, 210]
                                },
                                {
                                    name: '联盟广告',
                                    type: 'line',
                                    stack: '总量',
                                    data: [220, 182, 191, 234, 290, 330, 310]
                                },
                                {
                                    name: '视频广告',
                                    type: 'line',
                                    stack: '总量',
                                    data: [150, 232, 201, 154, 190, 330, 410]
                                },
                                {
                                    name: '直接访问',
                                    type: 'line',
                                    stack: '总量',
                                    data: [320, 332, 301, 334, 390, 330, 320]
                                },
                                {
                                    name: '搜索引擎',
                                    type: 'line',
                                    stack: '总量',
                                    data: [820, 932, 901, 934, 1290, 1330, 1320]
                                }
                            ]
                        };
                        // 使用刚指定的配置项和数据显示图表。
                        myChart.setOption(option);


                    </script>
                </div>


            </div>

        </div>

        <div class="layui-col-md3">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md12">
                    <div class="layui-panel">
                        <form class="layui-form" action="">
                            <!--加速度设置-->
                            <div>
                                <div style="padding-right: 30px;padding-top: 20px;padding-left:30px;display: flex;justify-content: space-between">
                                    <span style="margin-top: 8px">加速度计</span>
                                    <input type="checkbox" id="acceleration_input" name="yyy" lay-skin="switch"
                                           lay-text="ON|OFF" lay-filter="acc_filter"
                                           style="">
                                </div>
                                <div id="acc_block" style="padding-left: 30px;padding-bottom: 30px;padding-top: 10px">
                                    <span>采样频率(ms)</span>
                                    <div style="padding-top: 10px;padding-right: 10px" id="slider_acceleration"></div>
                                </div>
                                <hr style="margin-left: 20px;margin-right: 20px;margin-top:0px;border: 1px">
                            </div>
                            <!--陀螺仪设置-->
                            <div>
                                <div style="padding-right: 30px;padding-top: 20px;padding-left:30px;display: flex;justify-content: space-between">
                                    <span style="margin-top: 8px">陀螺仪</span>
                                    <input id="gyroscope_input" type="checkbox" name="yyy" lay-skin="switch"
                                           lay-text="ON|OFF" lay-filter="gyr_filter"
                                           style="">
                                </div>
                                <div id="gyr_block" style="padding-left: 30px;padding-bottom: 30px;padding-top: 10px">
                                    <span>采样频率(ms)</span>
                                    <div style="padding-top: 10px;padding-right: 10px" id="slider_gyroscope"></div>
                                </div>
                                <hr style="margin-left: 20px;margin-right: 20px;margin-top:0px;border: 1px">
                            </div>
                            <!--磁力计设置-->
                            <div>
                                <div style="padding-right: 30px;padding-top: 20px;padding-left:30px;display: flex;justify-content: space-between">
                                    <span style="margin-top: 8px">磁力计</span>
                                    <input id="magnetometer_input" type="checkbox" name="yyy" lay-skin="switch"
                                           lay-text="ON|OFF" lay-filter="mag_filter"
                                           style="">
                                </div>
                                <div id="mag_block" style="padding-left: 30px;padding-bottom: 30px;padding-top: 10px">
                                    <span>采样频率(ms)</span>
                                    <div style="padding-top: 10px;padding-right: 10px" id="slider_magnetometer"></div>
                                </div>
                                <hr style="margin-left: 20px;margin-right: 20px;margin-top:0px;border: 1px">
                            </div>
                            <!--光学传感器-->
                            <div>
                                <div style="padding-right: 30px;padding-top: 20px;padding-left:30px;display: flex;justify-content: space-between">
                                    <span style="margin-top: 8px">光学传感器</span>
                                    <input id="optical_input" type="checkbox" name="yyy" lay-skin="switch"
                                           lay-text="ON|OFF" lay-filter="opt_filter"
                                           style="">
                                </div>
                                <div id="red_block"
                                     style="padding-right: 30px;padding-top: 20px;padding-left:30px;display: flex;justify-content: space-between">
                                    <span style="margin-top: 8px">红光</span>
                                    <input id="redlight_input" type="checkbox" name="yyy" lay-skin="switch"
                                           lay-text="ON|OFF"
                                           style="">
                                    <span style="margin-top: 8px">红外</span>
                                    <input id="infra_input" type="checkbox" name="yyy" lay-skin="switch"
                                           lay-text="ON|OFF"
                                           style="">
                                </div>
                                <div id="green_block"
                                     style="padding-right: 30px;padding-top: 20px;padding-left:30px;display: flex;justify-content: space-between">
                                    <span style="margin-top: 8px">绿光</span>
                                    <input id="green_input" type="checkbox" name="yyy" lay-skin="switch"
                                           lay-text="ON|OFF"
                                           style="">
                                    <span style="margin-top: 8px">蓝光</span>
                                    <input id="blue_input" type="checkbox" name="yyy" lay-skin="switch"
                                           lay-text="ON|OFF"
                                           style="">
                                </div>
                                <div id="opt_block" style="padding-left: 30px;padding-bottom: 30px;padding-top: 10px">
                                    <span>采样频率(ms)</span>
                                    <div style="padding-top: 10px;padding-right: 10px" id="slider_optical_sensor"></div>
                                </div>
                                <hr style="margin-left: 20px;margin-right: 20px;margin-top:0px;border: 1px">
                            </div>
                            <!--1-生物电势AFE-->
                            <div>
                                <div style="padding-right: 30px;padding-top: 20px;padding-left:30px;display: flex;justify-content: space-between">
                                    <span style="margin-top: 8px">1-生物电势AFE</span>
                                    <input id="bioelectric1_input" type="checkbox" name="yyy" lay-skin="switch"
                                           lay-text="ON|OFF" lay-filter="bio1_filter"
                                           style="">
                                </div>
                                <div id="biopass1_block"
                                     style="padding-left: 30px;padding-bottom: 30px;padding-top: 10px">
                                    <span>工作通道数</span>
                                    <div style="padding-top: 10px;padding-right: 10px"
                                         id="slider_bioelectric_passageway_1"></div>
                                </div>
                                <div id="biofre1_block"
                                     style="padding-left: 30px;padding-bottom: 30px;padding-top: 10px">
                                    <span>采样频率(ms)</span>
                                    <div style="padding-top: 10px;padding-right: 10px"
                                         id="slider_bioelectric_frequency_1"></div>
                                </div>
                                <hr style="margin-left: 20px;margin-right: 20px;margin-top:0px;border: 1px">
                            </div>

                            <!--2-生物电势AFE-->
                            <div>
                                <div style="padding-right: 30px;padding-top: 20px;padding-left:30px;display: flex;justify-content: space-between">
                                    <span style="margin-top: 8px">2-生物电势AFE</span>
                                    <input id="bioelectric2_input" type="checkbox" name="yyy" lay-skin="switch"
                                           lay-text="ON|OFF" lay-filter="bio2_filter"
                                           style="">
                                </div>
                                <div id="biopas2_block"
                                     style="padding-left: 30px;padding-bottom: 30px;padding-top: 10px">
                                    <span>工作通道数</span>
                                    <div style="padding-top: 10px;padding-right: 10px"
                                         id="slider_bioelectric_passageway_2"></div>
                                </div>
                                <div id="biofre2_block"
                                     style="padding-left: 30px;padding-bottom: 30px;padding-top: 10px">
                                    <span>采样频率(ms)</span>
                                    <div style="padding-top: 10px;padding-right: 10px"
                                         id="slider_bioelectric_frequency_2"></div>
                                </div>
                                <div style="text-align: center;margin-bottom: 10px">
                                    <button id="setup_btn" type="button" class="layui-btn">确定</button>
                                </div>

                            </div>

                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script type="text/javascript">
        function hex2int(hex) {
            var len = hex.length, a = new Array(len), code;
            for (var i = 0; i < len; i++) {
                code = hex.charCodeAt(i);
                if (48 <= code && code < 58) {
                    code -= 48;
                } else {
                    code = (code & 0xdf) - 65 + 10;
                }
                a[i] = code;
            }

            return a.reduce(function (acc, c) {
                acc = 16 * acc + c;
                return acc;
            }, 0);
        }


        var websocket = null

        //判断当前浏览器是否支持WebSocket, 主要此处要更换为自己的地址
        if ('WebSocket' in window) {
            websocket = new WebSocket("ws://localhost:8085/web/socket");
        } else {
            alert('Not support websocket')
        }

        //连接发生错误的回调方法
        websocket.onerror = function () {
            //连接状态显示
            setMessageInnerHTML("error");
        };

        //连接成功建立的回调方法
        websocket.onopen = function (event) {

        }

        //接收到消息的回调方法
        websocket.onmessage = function (event) {
            if (event.data == 400 || event.data == 300) {
                document.getElementById("ser_connect").style.display = "none";//显示
                document.getElementById("ser_break").style.display = "";//显示
            } else {
                //数据解析
                var data = event.data
                //加速度
                var accDatax = hex2int(event.data.substring(4, 8))
                var accDatay = hex2int(event.data.substring(8, 12))
                var accDataz = hex2int(event.data.substring(12, 16))
                var acc_data = {"accDatax": accDatax, "accDatay": accDatay, "accDataz": accDataz}
                localStorage.setItem("acc_data", acc_data)
                //陀螺仪
                var gyrDatax = hex2int(event.data.substring(16,20))
                var gyrDatay = hex2int(event.data.substring(20,24))
                var gyrDataz = hex2int(event.data.substring(24,28))
                var gyr_data = {"gyrDatax":gyrDatax,"gyrDatay":gyrDatay,"gyrDataz":gyrDataz}
                localStorage.setItem("gyr_data",gyr_data)
                //磁力计



                //数据保存
            }
        }

        //连接关闭的回调方法
        websocket.onclose = function () {
            setMessageInnerHTML("close");
        }


        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function () {
            websocket.close();
            //清除localStroage数据
        }

        //将消息显示在网页上
        function setMessageInnerHTML(innerHTML) {
            document.getElementById('message').innerHTML += innerHTML + '<br/>';
        }

        //关闭连接
        function closeWebSocket() {
            websocket.close();
        }

        //发送消息
        function send() {
            var message = document.getElementById('text').value;
            websocket.send(message);
        }


    </script>

    <!--配置模块-->
    <script type="text/javascript">
        //加速度频率
        var accfre = 0;
        //陀螺仪频率
        var gyrfre = 0;
        //磁力计数据
        var magfre = 0;
        //光学传感器频率
        var optfre = 0;
        //生物1通道
        var bio1pass = 0;
        //生物1频率
        var bio1fre = 0;
        //生物2通道
        var bio2pass = 0;
        //生物2频率
        var bio2fre = 0;

        //数据初始化
        $(function () {// 初始化内容

            //获取页面右侧配置数据
            var setData = JSON.parse(localStorage.getItem("setData"))

            //加速度频率
            accfre = setData.accfre
            //加速度开关状态
            if (setData.acc_input) {
                layui.jquery('input[id="acceleration_input"]').attr('checked', 'checked')
                document.getElementById("acc_block").style.display = "";//显示
            } else {
                layui.jquery('input[id="acceleration_input"]').removeAttr('checked'); //改变开关为 关
                document.getElementById("acc_block").style.display = "none";//隐藏
            }
            //陀螺仪频率
            gyrfre = setData.gyrfre;
            //陀螺仪开关状态
            if (setData.gre_input) {
                layui.jquery('input[id="gyroscope_input"]').attr('checked', 'checked')
                document.getElementById("gyr_block").style.display = "";
            } else {
                layui.jquery('input[id="gyroscope_input"]').removeAttr('checked'); //改变开关为 关
                document.getElementById("gyr_block").style.display = "none";//隐藏
            }
            //磁力计数据
            magfre = setData.magfre;
            //磁力计开关状态
            if (setData.mag_input) {
                layui.jquery('input[id="magnetometer_input"]').attr('checked', 'checked')
                document.getElementById("mag_block").style.display = "";
            } else {
                layui.jquery('input[id="magnetometer_input"]').removeAttr('checked'); //改变开关为 关
                document.getElementById("mag_block").style.display = "none";//隐藏
            }

            //光学传感器频率
            optfre = setData.optfre;
            //光学传感器开关状态
            if (setData.opt_input) {
                layui.jquery('input[id="optical_input"]').attr('checked', 'checked')
                document.getElementById("red_block").style.display = "";
                document.getElementById("green_block").style.display = "";
                document.getElementById("opt_block").style.display = "";
            } else {
                layui.jquery('input[id="optical_input"]').removeAttr('checked'); //改变开关为 关
                document.getElementById("red_block").style.display = "none";//隐藏
                document.getElementById("green_block").style.display = "none";//隐藏
                document.getElementById("opt_block").style.display = "none";//隐藏
            }
            //红光按钮开关状态
            if (setData.rel_input) {
                layui.jquery('input[id="redlight_input"]').attr('checked', 'checked')
            } else {
                layui.jquery('input[id="redlight_input"]').removeAttr('checked'); //改变开关为 关
            }
            //红外开关状态
            if (setData.inf_input) {
                layui.jquery('input[id="infra_input"]').attr('checked', 'checked')
            } else {
                layui.jquery('input[id="infra_input"]').removeAttr('checked'); //改变开关为 关
            }
            //绿光开关状态
            if (setData.gre_input) {
                layui.jquery('input[id="green_input"]').attr('checked', 'checked')
            } else {
                layui.jquery('input[id="green_input"]').removeAttr('checked'); //改变开关为 关
            }
            //蓝光开关状态
            if (setData.blue_input) {
                layui.jquery('input[id="blue_input"]').attr('checked', 'checked')
            } else {
                layui.jquery('input[id="blue_input"]').removeAttr('checked'); //改变开关为 关
            }

            //生物1通道
            bio1pass = setData.bio1pass;
            //生物1频率
            bio1fre = setData.bio1fre;
            if (setData.bio1_input) {
                layui.jquery('input[id="bioelectric1_input"]').attr('checked', 'checked')
                document.getElementById("biopass1_block").style.display = "";
                document.getElementById("biofre1_block").style.display = "";
            } else {
                layui.jquery('input[id="bioelectric1_input"]').removeAttr('checked'); //改变开关为 关
                document.getElementById("biopass1_block").style.display = "none";//隐藏
                document.getElementById("biofre1_block").style.display = "none";//隐藏
            }

            //生物2通道
            bio2pass = setData.bio2pass;
            //生物2频率
            bio2fre = setData.bio2fre;
            if (setData.bio2_input) {
                layui.jquery('input[id="bioelectric2_input"]').attr('checked', 'checked')
                document.getElementById("biopas2_block").style.display = "";
                document.getElementById("biofre2_block").style.display = "";
            } else {
                layui.jquery('input[id="bioelectric2_input"]').removeAttr('checked'); //改变开关为 关
                document.getElementById("biopas2_block").style.display = "none";//隐藏
                document.getElementById("biofre2_block").style.display = "none";//隐藏
            }


            layui.form.render('checkbox')
        });

        //配置设置保存并且与后台通信向串口传递
        $("#setup_btn").click(function () {
            //需要保存的数据
            var setData = {};

            //获取加速度数据
            //获取加速度开关状态
            var acc_input = $("#acceleration_input").get(0).checked
            //获取加速度的采样频率
            //获取陀螺仪开关状态
            var gre_input = $("#gyroscope_input").get(0).checked
            //获取磁力计开关状态
            var mag_input = $("#magnetometer_input").get(0).checked
            //获取光学传感器开关状态
            var opt_input = $("#optical_input").get(0).checked
            //获取红光开关状态
            var rel_input = $("#redlight_input").get(0).checked
            //获取红外开关状态
            var inf_input = $("#infra_input").get(0).checked
            //获取绿光开关状态
            var green_input = $("#green_input").get(0).checked
            //获取蓝光开关状态
            var blue_input = $("#blue_input").get(0).checked
            //获取生物电势1开关状态
            var bio1_input = $("#bioelectric1_input").get(0).checked
            //获取生物电势2开关状态
            var bio2_input = $("#bioelectric2_input").get(0).checked

            //数据拼接
            setData = {
                "accfre": accfre,
                "gyrfre": gyrfre,
                "magfre": magfre,
                "optfre": optfre,
                "bio1pass": bio1pass,
                "bio1fre": bio1fre,
                "bio2pass": bio2pass,
                "bio2fre": bio2fre,
                "acc_input": acc_input,
                "gre_input": gre_input,
                "mag_input": mag_input,
                "opt_input": opt_input,
                "rel_input": rel_input,
                "inf_input": inf_input,
                "green_input": green_input,
                "blue_input": blue_input,
                "bio1_input": bio1_input,
                "bio2_input": bio2_input
            }

            //数据保存到浏览器缓存
            localStorage.setItem("setData", JSON.stringify(setData))
            //传到后台
            $.ajax({
                data: {"setData": setData},
                type: "post",
                dataType: "json",
                url: "${pageContext.request.contextPath}/web/setUp",
                success: function (data) {


                    if (data.code == 200) {
                        alert("配置修改成功")
                    }
                }
            })


        })


        //滑块渲染
        layui.use('slider', function () {
            var slider = layui.slider;

            //渲染
            slider.render({
                elem: '#slider_acceleration',  //加速度
                min: 25,
                max: 2000,
                value: accfre,
                change: function (value) {
                    accfre = value
                }
            });

            //渲染
            slider.render({
                elem: '#slider_gyroscope',  //陀螺仪
                min: 25,
                max: 2000,
                value: gyrfre,
                change: function (value) {
                    gyrfre = value
                }
            });

            //渲染
            slider.render({
                elem: '#slider_magnetometer',  //磁力计
                min: 25,
                max: 2000,
                value: magfre,
                change: function (value) {
                    magfre = value
                }
            });

            //渲染
            slider.render({
                elem: '#slider_optical_sensor',  //光学传感器
                min: 25,
                max: 2000,
                value: optfre,
                change: function (value) {
                    optfre = value
                }
            });

            //渲染
            slider.render({
                elem: '#slider_bioelectric_passageway_1',  //1-生物电势AFE通道
                min: 1,
                max: 8,
                value: bio1pass,
                change: function (value) {
                    bio1pass = value
                }
            });

            //渲染
            slider.render({
                elem: '#slider_bioelectric_frequency_1',  //1-生物电势AFE频率
                min: 25,
                max: 2000,
                value: bio1fre,
                change: function (value) {
                    bio1fre = value
                }
            });

            //渲染
            slider.render({
                elem: '#slider_bioelectric_passageway_2',  //2-生物电势AFE通道
                min: 1,
                max: 8,
                value: bio2pass,
                change: function (value) {
                    bio2pass = value
                }
            });
            //渲染
            slider.render({
                elem: '#slider_bioelectric_frequency_2',  //2-生物电势AFE频率
                min: 25,
                max: 2000,
                value: bio2fre,
                change: function (value) {
                    bio2fre = value
                }
            });


        });


        //表单内模块配置
        layui.use(['form'], function () {
            var form = layui.form
            //加速度开关监听
            form.on('switch(acc_filter)', function (data) {
                var checked = data.elem.checked
                if (checked) {
                    document.getElementById("acc_block").style.display = "";//显示
                } else {
                    document.getElementById("acc_block").style.display = "none";//隐藏
                }
            })
            //陀螺仪开关监听
            form.on('switch(gyr_filter)', function (data) {
                var checked = data.elem.checked
                if (checked) {
                    document.getElementById("gyr_block").style.display = "";//显示
                } else {
                    document.getElementById("gyr_block").style.display = "none";//隐藏
                }
            })
            //磁力计开关监听
            form.on('switch(mag_filter)', function (data) {
                var checked = data.elem.checked
                if (checked) {
                    document.getElementById("mag_block").style.display = "";//显示
                } else {
                    document.getElementById("mag_block").style.display = "none";//隐藏
                }
            })
            //光学传感器开关监听
            form.on('switch(opt_filter)', function (data) {
                var checked = data.elem.checked
                if (checked) {
                    document.getElementById("red_block").style.display = "";//显示
                    document.getElementById("green_block").style.display = "";//显示
                    document.getElementById("opt_block").style.display = "";//显示
                } else {
                    document.getElementById("red_block").style.display = "none";//隐藏
                    document.getElementById("green_block").style.display = "none";//隐藏
                    document.getElementById("opt_block").style.display = "none";//隐藏
                }
            })
            //生物电势1开关监听
            form.on('switch(bio1_filter)', function (data) {
                var checked = data.elem.checked
                if (checked) {
                    document.getElementById("biopass1_block").style.display = "";//显示
                    document.getElementById("biofre1_block").style.display = "";//显示
                } else {
                    document.getElementById("biopass1_block").style.display = "none";//隐藏
                    document.getElementById("biofre1_block").style.display = "none";//隐藏
                }
            })

            //生物电势2开关监听
            form.on('switch(bio2_filter)', function (data) {
                var checked = data.elem.checked
                if (checked) {
                    document.getElementById("biopas2_block").style.display = "";//显示
                    document.getElementById("biofre2_block").style.display = "";//显示
                } else {
                    document.getElementById("biopas2_block").style.display = "none";//隐藏
                    document.getElementById("biofre2_block").style.display = "none";//隐藏
                }
            })


        })


    </script>


</div>
</body>
</html>
