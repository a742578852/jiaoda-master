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
    <script src="/excel/sheetjs-master/xlsx.mini.js"></script>
    <title>串口数据</title>
</head>
<body>

<div class="layui-container">

    <div class="layui-row">
        <div class="layui-col-md9">

            <div id="ser_connect" style="padding: 30px;display: none" class="layui-row layui-col-space15">
                <span style="font-weight: bold">串口连接状态:</span>
                <span>
                    <i class="layui-icon layui-icon-rss" style="font-size: 30px; color: green;"></i>
                    <span style="color: green">连接正常</span>
                </span>
            </div>

            <div id="ser_break" style="padding: 30px" class="layui-row layui-col-space15">
                <span style="font-weight: bold">串口连接状态:</span>
                <span>
                    <i class="layui-icon layui-icon-rss" style="font-size: 30px; color: red;"></i>
                    <span style="color: red">连接断开</span>
                </span>

            </div>

            <dv style="padding: 30px;">
                <span>请选择串口:</span>
                <select id="cklst" lay-verify="">
                    <option value="">请选择串口</option>

                </select>
                <button id="con_btn" type="button" onclick="con()" class="layui-btn">连接</button>
            </dv>

            <div style="padding: 30px" class="layui-row layui-col-space15">
                <!--数据储存区-->
                <form class="layui-form">
                    <div style="padding: 10px">
                        <label class="layui-form-label">数据保存</label>
                        <div class="layui-input-block">
                            <input type="text" id="save_data" name="data_name" required lay-verify="required"
                                   placeholder="请输入文件名"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div style="padding: 10px;display: flex;justify-content: space-between">
                        <div>
                            <label class="layui-form-label">定时</label>
                            <div class="layui-input-block">
                                <input type="number" id="set_time" name="data_time" placeholder="请输入时长,单位:秒"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                        <div>
                            <input id="time_check" type="checkbox" name="yyy" lay-skin="switch" lay-text="ON|OFF">
                        </div>
                    </div>

                    <div style="padding: 10px;display: flex;justify-content: space-around">
                        <button id="action_btn" type="button" class="layui-btn">开始</button>
                        <button type="button" class="layui-btn layui-btn-normal layui-btn-disabled" id="stop_btn">暂停
                        </button>
                        <button type="button" class="layui-btn layui-btn-warm layui-btn-disabled" id="end_btn">结束
                        </button>
                    </div>

                    <div style="padding: 10px;margin-right: 20px">
                        <span>已保存数据长度:
                            <input type="number" id="data_number" disabled>

                        </span>
                    </div>

                </form>

            </div>
            <!--数据显示页面-->
            <div style="padding: 10px" class="layui-row layui-col-space15">
                <div style="padding: 10px;">

                    <select id="data_sel" name="data_name" lay-verify="" style="height: 30px">
                        <option value="01">加速度计</option>
                        <option value="02">陀螺仪</option>
                        <option value="03">磁力计</option>
                        <option value="04">光学传感器</option>
                        <option value="05">1-生物电势AFE</option>
                        <option value="06">2-生物电势AFE</option>
                    </select>

                    <button id="qh_btn" onclick="qh()" type="button" class="layui-btn">切换</button>
                </div>
                <div>
                    <button class="layui-btn layui-btn-danger" id="clear_btn">数据清除</button>
                </div>
                <!--加速度实时数据-->
                <h3 style="color: #0b97c4">加速度</h3>
                <div id="acc_d" style="display: flex;">
                    <div >
                      <span >x轴:
                            <input  id="acc_d_x">
                          </span>
                    </div>
                    <div >
                        <span >y轴:
                            <input  id="acc_d_y">

                        </span>
                    </div>
                    <div >
                        <span >z轴:
                            <input  id="acc_d_z">

                        </span>
                    </div>
                    <div >
                         <span >时间:
                            <input  id="acc_d_time">

                        </span>
                    </div>


                </div>
                <!--陀螺仪实时数据-->
                <h3 style="color: #0b97c4">陀螺仪</h3>
                <div id="gyr_d" style="display: flex;">
                    <div >
                      <span >x轴:
                            <input  id="gry_d_x">
                          </span>
                    </div>
                    <div >
                        <span >y轴:
                            <input  id="gry_d_y">

                        </span>
                    </div>
                    <div >
                        <span >z轴:
                            <input  id="gry_d_z">

                        </span>
                    </div>
                    <div >
                         <span >时间:
                            <input  id="gry_d_time">

                        </span>
                    </div>
                </div>
                <!--磁力计实时数据-->
                <h3 style="color: #0b97c4">磁力计</h3>
                <div id="mag_d" style="display: flex;">
                    <div >
                      <span >x轴:
                            <input  id="mag_d_x">
                          </span>
                    </div>
                    <div >
                        <span >y轴:
                            <input  id="mag_d_y">

                        </span>
                    </div>
                    <div >
                        <span >z轴:
                            <input  id="mag_d_z">

                        </span>
                    </div>
                    <div >
                         <span >时间:
                            <input  id="mag_d_time">

                        </span>
                    </div>
                </div>
                <!--光学传感器实时数据-->
                <h3 style="color: #0b97c4">光学传感器</h3>
                <div id="opt_d" style="display: flex;flex-wrap: wrap;">
                    <div style="width: 33%;margin-bottom: 10px">
                      <span >红光:
                            <input  id="opt_d_red">
                          </span>
                    </div>
                    <div style="width: 33%;margin-bottom: 10px">
                        <span >红外:
                            <input  id="opt_d_hw">

                        </span>
                    </div>
                    <div style="width: 33%;margin-bottom: 10px">
                        <span >绿光:
                            <input  id="opt_d_lv">

                        </span>
                    </div>
                    <div style="width: 33%;margin-bottom: 10px">
                        <span >蓝光:
                            <input  id="opt_d_lan">

                        </span>
                    </div>
                    <div style="width: 33%;margin-bottom: 10px">
                         <span >时间:
                            <input  id="opt_d_time">

                        </span>
                    </div>
                </div>
                <!--afe1实时数据-->
                <h3 style="color: #0b97c4">AFE1传感器</h3>
                <div id="afe1_d" style="display: flex;flex-wrap: wrap;">

                    <div style="width: 25%;margin-bottom: 10px">
                      <span >通道一:
                            <input  id="afe1_d_one">
                          </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道二:
                            <input  id="afe1_d_two">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道三:
                            <input  id="afe1_d_three">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道四:
                            <input  id="afe1_d_four">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道五:
                            <input  id="afe1_d_five">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道六:
                            <input  id="afe1_d_six">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道七:
                            <input  id="afe1_d_seven">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道八:
                            <input  id="afe1_d_eight">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                         <span >时间:
                            <input  id="afe1_d_time">

                        </span>
                    </div>

                </div>
                <!--afe2实时数据-->
                <h3 style="color: #0b97c4">AFE2传感器</h3>
                <div id="afe2_d" style="display: flex;flex-wrap: wrap;">
                    <div style="width: 25%;margin-bottom: 10px">
                      <span >通道一:
                            <input  id="afe2_d_one">
                          </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道二:
                            <input  id="afe2_d_two">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道三:
                            <input  id="afe2_d_three">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道四:
                            <input  id="afe2_d_four">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道五:
                            <input  id="afe2_d_five">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道六:
                            <input  id="afe2_d_six">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道七:
                            <input  id="afe2_d_seven">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                        <span >通道八:
                            <input  id="afe2_d_eight">

                        </span>
                    </div>
                    <div style="width: 25%;margin-bottom: 10px">
                         <span >时间:
                            <input  id="afe2_d_time">

                        </span>
                    </div>
                </div>
                <!--图表-->
<%--                <div>--%>
<%--                    <!--加速度-->--%>
<%--                    <div id="acc_ec" style="width: 900px;height:500px;margin-left:-100px;margin-top: 20px "></div>--%>

<%--                </div>--%>


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
                                    <span>采样频率(hz)</span>
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
                                    <span>采样频率(hz)</span>
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
                                    <span>采样频率(hz)</span>
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
                                    <span>采样频率(hz)</span>
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
                                    <span>采样频率(hz)</span>
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
                                    <span>采样频率(hz)</span>
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

        //获取当前选中的值
        var selData = $('#data_sel').val()

        //加速度数据集合
        var acc_list = []
        //陀螺仪数据集合
        var gyr_list = []
        //磁力计数据集合
        var mag_list = []
        //光学传感器数据集合
        var opt_list = []
        //afe1数据集合
        var afe1_list = []
        //afe2数据集合
        var afe2_list = []
        //要保存的加速度数据
        var accSaveData = [];
        //陀螺仪
        var gyrSaveData = [];
        //磁力计
        var magSaveData = []
        //光学传感器
        var optSaveData = []
        //afe1
        var afe1SaveData = []
        //afe2
        var afe2SaveData = []

        //设定的定时时间
        var setTime;

        var setTimeFlg = 1;

        //开始时间
        var startTime;
        //结束时间
        var endTime;
        //暂停开始时间
        var stopStartTime = [];
        //暂停结束时间
        var stopEndTime = []

        var number_flg = 1;

        var stop_number_flg = 0;

        //开始连接
        function con(){
            //设置全局变量
            var  data = $("#cklst").find("option:selected").text();

            $.ajax({
                type:"POST",
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                url:"setCom",
                data:{"comName":data},
                success:function (res){
                        //开始socket
                        //判断当前浏览器是否支持WebSocket, 主要此处要更换为自己的地址
                        location.reload()
                    }
            })

            //webSocket开始启动



        }

        //获取采集数量
        function getDataNumber() {
            getSaveData()
            $('#data_number').val(accSaveData.length)

            if (number_flg == 0) {
                setTimeout(function () {
                    getDataNumber()
                }, 1000)
            }

        }


        //json对象转二维数据
        function je(data) {
            var arr = []
            for (var i in data) {
                arr[i] = [];
                for (var j in data[i]) {
                    arr[i].push(data[i][j])
                }
            }
            return arr

        }

        // 将一个sheet转成最终的excel文件的blob对象，然后利用URL.createObjectURL下载
        function sheet2blob(sheet, sheetName) {
            sheetName = sheetName || 'sheet1';
            var workbook = {
                SheetNames: [sheetName],
                Sheets: {}
            };
            workbook.Sheets[sheetName] = sheet;
            // 生成excel的配置项
            var wopts = {
                bookType: 'xlsx', // 要生成的文件类型
                bookSST: false, // 是否生成Shared String Table，官方解释是，如果开启生成速度会下降，但在低版本IOS设备上有更好的兼容性
                type: 'binary'
            };
            var wbout = XLSX.write(workbook, wopts);
            var blob = new Blob([s2ab(wbout)], {type: "application/octet-stream"});

            // 字符串转ArrayBuffer
            function s2ab(s) {
                var buf = new ArrayBuffer(s.length);
                var view = new Uint8Array(buf);
                for (var i = 0; i != s.length; ++i) view[i] = s.charCodeAt(i) & 0xFF;
                return buf;
            }

            return blob;
        }

        //excel下载
        function openDownloadDialog(url, saveName) {
            if (typeof url == 'object' && url instanceof Blob) {
                url = URL.createObjectURL(url); // 创建blob地址
            }
            var aLink = document.createElement('a');
            aLink.href = url;
            aLink.download = saveName || ''; // HTML5新增的属性，指定保存文件名，可以不要后缀，注意，file:///模式下不会生效
            var event;
            if (window.MouseEvent) event = new MouseEvent('click');
            else {
                event = document.createEvent('MouseEvents');
                event.initMouseEvent('click', true, false, window, 0, 0, 0, 0, 0, false, false, false, false, 0, null);
            }
            aLink.dispatchEvent(event);
        }

        //筛选要保存的数据
        function getSaveData() {
            var length = []
            if(acc_list.length != 0){
                length = acc_list
            }else if(opt_list.length != 0){
                length = opt_list
            }else if(afe1_list.length != 0){
                length = afe1_list
            }else {
                length = afe2_list
            }
            for (var i = 0; i < length.length; i++) {
                if (length[i].save_date >= startTime && length[i].save_date <= endTime) {
                    var f = 0;
                    //扣除在暂停时间内的数据
                    for (var j = 0; j < stopEndTime.length; j++) {
                        if (length[i].save_date >= stopStartTime[j] && length[i].save_date <= stopEndTime[j]) {
                            f = 1
                        }
                    }
                    if (f == 0) {
                        accSaveData.push(acc_list[i])
                        gyrSaveData.push(gyr_list[i])
                        magSaveData.push(mag_list[i])
                        optSaveData.push(opt_list[i])
                        afe1SaveData.push(afe1_list[i])
                        afe2SaveData.push(afe2_list[i])
                    }
                }
            }

        }

        //计数
        function dataNumber() {
            var length = []
            if(acc_list.length != 0){
                length = acc_list
            }else if(opt_list.length != 0){
                length = opt_list
            }else if(afe1_list.length != 0){
                length = afe1_list
            }else {
                length = afe2_list
            }

            var data = []
            for (var i = 0; i < length.length; i++) {
                if (length[i].save_date >= startTime && length[i].save_date <= new Date()) {
                    var f = 0;
                    //扣除在暂停时间内的数据
                    for (var j = 0; j < stopEndTime.length; j++) {
                        if (length[i].save_date >= stopStartTime[j] && length[i].save_date <= stopEndTime[j]) {
                            f = 1
                        }
                    }
                    if (f == 0) {
                        data.push(length[i])

                    }
                }
            }
            $("#data_number").val(data.length)
            console.log("数据长度是:"+data.length)
            if (number_flg == 0) {
                setTimeout(function () {
                    dataNumber()
                }, 1000)
            }
        }

        //倒计时函数
        function countDown() {
            console.log("定时" + setTime)
            setTime--
            $("#set_time").val(setTime)
            if (setTime > 0 && setTimeFlg == 1) {
                setTimeout(function () {
                    console.log("进入倒计时"+setTime)
                    countDown()
                }, 1000)

            } else if (setTime > 0 && setTimeFlg == 0) {
                return
            } else {
                console.log("进入保存")
                endTime = new Date()
                //保存数据
                //筛选数据
                getSaveData();
                //保存
                //加速度
                accSaveData.unshift({'x轴': 'x轴', 'y轴': 'y轴', 'z轴': 'z轴', '时间': '采集时间', '日期': '日期'})
                var acc_sheet = XLSX.utils.aoa_to_sheet(je(accSaveData))
                openDownloadDialog(sheet2blob(acc_sheet), $('#save_data').val() + '(加速度).xlsx')
                //陀螺仪
                gyrSaveData.unshift({'x轴': 'x轴', 'y轴': 'y轴', 'z轴': 'z轴', '时间': '采集时间', '日期': '日期 '})
                var gyr_sheet = XLSX.utils.aoa_to_sheet(je(gyrSaveData))
                openDownloadDialog(sheet2blob(gyr_sheet), $('#save_data').val() + '(陀螺仪).xlsx')
                //磁力计
                magSaveData.unshift({'x轴': 'x轴', 'y轴': 'y轴', 'z轴': 'z轴', '时间': '采集时间', '日期': '日期 '})
                var mag_sheet = XLSX.utils.aoa_to_sheet(je(magSaveData))
                openDownloadDialog(sheet2blob(mag_sheet), $('#save_data').val() + '(磁力计).xlsx')
                //光学传感器
                optSaveData.unshift({'红外': '红外', '红光': '红光','绿光':'绿光','蓝光':'蓝光','时间': '采集时间', '日期': '日期 '})
                var opt_sheet = XLSX.utils.aoa_to_sheet(je(optSaveData))
                openDownloadDialog(sheet2blob(opt_sheet), $('#save_data').val() + '(光学传感器).xlsx')

                //afe1
                afe1SaveData.unshift({
                    '一通道': '一通道',
                    '二通道': '二通道',
                    '三通道': '三通道',
                    '四通道': '四通道',
                    '五通道': '五通道',
                    '六通道': '六通道',
                    '七通道': '七通道',
                    '八通道': '八通道',
                    '时间': '采集时间',
                    '日期': '日期 '
                })
                var afe1_sheet = XLSX.utils.aoa_to_sheet(je(afe1SaveData))
                openDownloadDialog(sheet2blob(afe1_sheet), $('#save_data').val() + '(AFE1).xlsx')
                //afe2
                afe2SaveData.unshift({
                    '一通道': '一通道',
                    '二通道': '二通道',
                    '三通道': '三通道',
                    '四通道': '四通道',
                    '五通道': '五通道',
                    '六通道': '六通道',
                    '七通道': '七通道',
                    '八通道': '八通道',
                    '时间': '采集时间',
                    '日期': '日期 '
                })
                var afe2_sheet = XLSX.utils.aoa_to_sheet(je(afe2SaveData))
                openDownloadDialog(sheet2blob(afe2_sheet), $('#save_data').val() + '(AFE2).xlsx')

                //清空
                accSaveData = []
                gyrSaveData = []
                magSaveData = []
                optSaveData = []
                afe1SaveData = []
                afe2SaveData = []
                number_flg = 1

                //恢复正常键位
                //开始 数据清空 按钮放开
                $('#action_btn').removeClass("layui-btn-disabled").attr("disabled", false)
                $('#clear_btn').removeClass("layui-btn-disabled").attr("disabled", false)
                //暂停结束按钮禁用
                $('#stop_btn').addClass("layui-btn-disabled").attr("disabled", true)
                $('#end_btn').addClass("layui-btn-disabled").attr("disabled", true)
                setTimeFlg = 0
                setTime = 0
                number_flg = 1
                return;
            }


        }

        //数据保存开始
        $("#action_btn").click(function () {
            //判断文件名是否为空
            var saveName = $('#save_data').val()
            if (saveName.trim() == '') {
                alert("请输入文件名")
                return;
            }
            //设立开始时间
            startTime = new Date();

            number_flg = 0
            dataNumber()
            //暂停 结束按钮设为启用
            $('#stop_btn').removeClass("layui-btn-disabled").attr("disabled", false);
            $('#end_btn').removeClass("layui-btn-disabled").attr("disabled", false);
            //开始按钮设为禁用
            $('#action_btn').addClass("layui-btn-disabled").attr("disabled", true)
            $('#clear_btn').addClass("layui-btn-disabled").attr("disabled", true)

            //判断定时开关是否开启
            var timeCheck = $('#time_check').get(0).checked
            if (timeCheck) {
                setTimeFlg = 1
                //给定时器赋值
                setTime = $('#set_time').val()
                countDown()
            } else {


            }

        })
        //数据保存结束
        $('#end_btn').click(function () {
            //记录结束时间
            endTime = new Date();

            //保存数据
            //筛选数据
            getSaveData();
            //保存
            //加速度
            accSaveData.unshift({'x轴': 'x轴', 'y轴': 'y轴', 'z轴': 'z轴', '时间': '采集时间', '日期': '日期'})
            var acc_sheet = XLSX.utils.aoa_to_sheet(je(accSaveData))
            openDownloadDialog(sheet2blob(acc_sheet), $('#save_data').val() + '(加速度).xlsx')
            //陀螺仪
            gyrSaveData.unshift({'x轴': 'x轴', 'y轴': 'y轴', 'z轴': 'z轴', '时间': '采集时间', '日期': '日期 '})
            var gyr_sheet = XLSX.utils.aoa_to_sheet(je(gyrSaveData))
            openDownloadDialog(sheet2blob(gyr_sheet), $('#save_data').val() + '(陀螺仪).xlsx')
            //磁力计
            magSaveData.unshift({'x轴': 'x轴', 'y轴': 'y轴', 'z轴': 'z轴', '时间': '采集时间', '日期': '日期 '})
            var mag_sheet = XLSX.utils.aoa_to_sheet(je(magSaveData))
            openDownloadDialog(sheet2blob(mag_sheet), $('#save_data').val() + '(磁力计).xlsx')
            //光学传感器
            optSaveData.unshift({'红外': '红外', '红光': '红光','绿光':'绿光','蓝光':'蓝光','时间': '采集时间', '日期': '日期 '})
            var opt_sheet = XLSX.utils.aoa_to_sheet(je(optSaveData))
            openDownloadDialog(sheet2blob(opt_sheet), $('#save_data').val() + '(光学传感器).xlsx')
            //afe1
            afe1SaveData.unshift({
                '一通道': '一通道',
                '二通道': '二通道',
                '三通道': '三通道',
                '四通道': '四通道',
                '五通道': '五通道',
                '六通道': '六通道',
                '七通道': '七通道',
                '八通道': '八通道',
                '时间': '采集时间',
                '日期': '日期 '
            })
            var afe1_sheet = XLSX.utils.aoa_to_sheet(je(afe1SaveData))
            openDownloadDialog(sheet2blob(afe1_sheet), $('#save_data').val() + '(AFE1).xlsx')
            //afe2
            afe2SaveData.unshift({
                '一通道': '一通道',
                '二通道': '二通道',
                '三通道': '三通道',
                '四通道': '四通道',
                '五通道': '五通道',
                '六通道': '六通道',
                '七通道': '七通道',
                '八通道': '八通道',
                '时间': '采集时间',
                '日期': '日期 '
            })
            var afe2_sheet = XLSX.utils.aoa_to_sheet(je(afe2SaveData))
            openDownloadDialog(sheet2blob(afe2_sheet), $('#save_data').val() + '(AFE2).xlsx')

            //清空
            accSaveData = []
            gyrSaveData = []
            magSaveData = []
            optSaveData = []
            afe1SaveData = []
            afe2SaveData = []
            number_flg = 1


            var btnName = document.getElementById("stop_btn").innerHTML
            if (btnName.trim() == '继续') {
                endTime = stopStartTime[stopStartTime.length - 1]
            }
            //开始 数据清空 按钮放开
            $('#action_btn').removeClass("layui-btn-disabled").attr("disabled", false)
            $('#clear_btn').removeClass("layui-btn-disabled").attr("disabled", false)
            //暂停结束按钮禁用
            $('#stop_btn').addClass("layui-btn-disabled").attr("disabled", true)
            $('#end_btn').addClass("layui-btn-disabled").attr("disabled", true)
            setTimeFlg = 0
            setTime = 0
            number_flg = 1


        })

        //数据保存暂停
        $('#stop_btn').click(function () {
            var btnName = document.getElementById("stop_btn").innerHTML
            if (btnName.trim() == '暂停') {
                stop_number_flg = 1
                setTimeFlg = 0
                document.getElementById("stop_btn").innerHTML = '继续'
                stopStartTime.push(new Date())
            } else {
                stop_number_flg = 0
                document.getElementById("stop_btn").innerHTML = '暂停'
                stopEndTime.push(new Date())
                setTimeFlg = 1
                var timeCheck = $('#time_check').get(0).checked
                if (timeCheck) {
                    countDown()
                }

            }

        })


        //清除数据
        $('#clear_btn').click(function () {
            acc_list = []
            gyr_list = []
            mag_list = []
            opt_list = []
            afe1_list = []
            afe2_list = []
        })

        function getCurrentTime() {

            let date = new Date()
            let M = date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : (date.getMonth() + 1)
            let D = date.getDate() < 10 ? ('0' + date.getDate()) : date.getDate()
            let hours = date.getHours()
            let minutes = date.getMinutes() < 10 ? ('0' + date.getMinutes()) : date.getMinutes()
            let seconds = date.getSeconds() < 10 ? ('0' + date.getSeconds()) : date.getSeconds()
            date = M + '-' + D + ' ' + hours + ':' + minutes + ':' + seconds
            return date

        }

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


        function fuhaohex2int(i){
            let two = parseInt(i, 16).toString(2);
            let bitNum=i.length*4;
            if (two.length < bitNum) {
                while (two.length < bitNum) {
                    two = "0" + two;
                }
            }

            if (two.substring(0, 1) == "0") {
                two = parseInt(two, 2);

                return two;
            } else {
                let two_unsign = "";
                two = parseInt(two, 2) - 1;
                two = two.toString(2);
                two_unsign = two.substring(1, bitNum);
                two_unsign = two_unsign.replace(/0/g, "z");
                two_unsign = two_unsign.replace(/1/g, "0");
                two_unsign = two_unsign.replace(/z/g, "1");
                two = parseInt(-two_unsign, 2);

                return two;
            }

        }

        function FillString(t, c, n, b) {
            if ((t == "") || (c.length != 1) || (n <= t.length)) {
                return t;
            }
            var l = t.length;
            for (var i = 0; i < n - l; i++) {
                if (b == true) {
                    t = c + t;
                }
                else {
                    t += c;
                }
            }
            return t;
        }

        // 16 进制转浮点数
        function HexToSingle(t) {
            t = t.replace(/\s+/g, "");
            if (t == "") {
                return "";
            }
            if (t == "00000000") {
                return "0";
            }
            if ((t.length > 8) || (isNaN(parseInt(t, 16)))) {
                return "Error";
            }
            if (t.length < 8) {
                t = FillString(t, "0", 8, true);
            }
            t = parseInt(t, 16).toString(2);
            t = FillString(t, "0", 32, true);
            var s = t.substring(0, 1);
            var e = t.substring(1, 9);
            var m = t.substring(9);
            e = parseInt(e, 2) - 127;
            m = "1" + m;
            if (e >= 0) {
                m = m.substr(0, e + 1) + "." + m.substring(e + 1)
            } else {
                m = "0." + FillString(m, "0", m.length - e - 1, true)
            }
            if (m.indexOf(".") == -1) {
                m = m + ".0";
            }
            var a = m.split(".");
            var mi = parseInt(a[0], 2);
            var mf = 0;
            for (var i = 0; i < a[1].length; i++) {
                mf += parseFloat(a[1].charAt(i)) * Math.pow(2, -(i + 1));
            }
            m = parseInt(mi) + parseFloat(mf);
            if (s == 1) {
                m = 0 - m;
            }
            return m;
        }

        var websocket = null

        if ('WebSocket' in window) {
            console.log("进入")
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
            if (event.data == 300) {

            } else {
                document.getElementById("ser_connect").style.display = "";//显示
                document.getElementById("ser_break").style.display = "none";//显示
                //数据解析
                var data = event.data
               // console.log(data)
                //加速度
                var acc_data = {}
                var gyr_data = {}
                var mag_data ={}
                if (event.data.substring(0,4) == 'aaaa'){
                    var accDatax = fuhaohex2int(event.data.substring(4, 8))
                    var accDatay = fuhaohex2int(event.data.substring(8, 12))
                    var accDataz = fuhaohex2int(event.data.substring(12, 16))

                    acc_data = {
                        "accDatax": accDatax,
                        "accDatay": accDatay,
                        "accDataz": accDataz,
                        "date": getCurrentTime(),
                        "save_date": new Date()
                    }


                    //陀螺仪

                    var gyrDatax = fuhaohex2int(event.data.substring(16, 20))
                    var gyrDatay = fuhaohex2int(event.data.substring(20, 24))
                    var gyrDataz = fuhaohex2int(event.data.substring(24, 28))
                    gyr_data = {
                        "gyrDatax": gyrDatax,
                        "gyrDatay": gyrDatay,
                        "gyrDataz": gyrDataz,
                        "date": getCurrentTime(),
                        "save_date": new Date()
                    }

                    //磁力计
                    var magDatax = fuhaohex2int(event.data.substring(28, 32))
                    var magDatay = fuhaohex2int(event.data.substring(32, 36))
                    var magDataz = fuhaohex2int(event.data.substring(36, 40))
                    mag_data = {
                        "magDatax": magDatax,
                        "magDatay": magDatay,
                        "magDataz": magDataz,
                        "date": getCurrentTime(),
                        "save_date": new Date()
                    }
                }

                var opt_data = {}
                if (event.data.substring(0,4) == 'bbbb'){
                    //光学传感器
                    var hw = hex2int(event.data.substring(4, 12))
                    var h = hex2int(event.data.substring(12, 20))
                    var lv = hex2int(event.data.substring(20,28))
                    var lan = hex2int(event.data.substring(28,36))
                    opt_data = {
                        "hw": hw,
                        "h": h,
                        "lv":lv,
                        "lan":lan,
                        "date": getCurrentTime(),
                        "save_date": new Date()
                    }
                }


                var afe1_data = {}
                if (event.data.substring(0,4) == 'cccc'){

                    //AFE传感器1
                    //通道1-通道8
                    var AFE1_one = HexToSingle(event.data.substring(6, 14)).toString().substring(0,10)
                    var AFE1_two = HexToSingle(event.data.substring(14, 22)).toString().substring(0,10)
                    var AFE1_three = HexToSingle(event.data.substring(22, 30)).toString().substring(0,10)
                    var AFE1_four = HexToSingle(event.data.substring(30, 38)).toString().substring(0,10)
                    var AFE1_five = HexToSingle(event.data.substring(44, 52)).toString().substring(0,10)
                    var AFE1_six = HexToSingle(event.data.substring(52, 60)).toString().substring(0,10)
                    var AFE1_seven = HexToSingle(event.data.substring(60, 68)).toString().substring(0,10)
                    var AFE1_eight = HexToSingle(event.data.substring(68, 76)).toString().substring(0,10)


                    afe1_data = {
                        "AFE1_one": AFE1_one,
                        "AFE1_two": AFE1_two,
                        "AFE1_three": AFE1_three,
                        "AFE1_four": AFE1_four,
                        "AFE1_five": AFE1_five,
                        "AFE1_six": AFE1_six,
                        "AFE1_seven": AFE1_seven,
                        "AFE1_eight": AFE1_eight,
                        "date": getCurrentTime(),
                        "save_date": new Date()
                    }

                }

                var afe2_data = {}
                if (event.data.substring(0,4) == 'dddd'){
                    //AFE传感器2
                    //通道1-通道8
                    var AFE2_one = HexToSingle(event.data.substring(6, 14)).toString().substring(0,10)
                    var AFE2_two = HexToSingle(event.data.substring(14, 22)).toString().substring(0,10)
                    var AFE2_three = HexToSingle(event.data.substring(22, 30)).toString().substring(0,10)
                    var AFE2_four = HexToSingle(event.data.substring(30, 38)).toString().substring(0,10)
                    var AFE2_five = HexToSingle(event.data.substring(44, 52)).toString().substring(0,10)
                    var AFE2_six = HexToSingle(event.data.substring(52, 60)).toString().substring(0,10)
                    var AFE2_seven = HexToSingle(event.data.substring(60, 68)).toString().substring(0,10)
                    var AFE2_eight = HexToSingle(event.data.substring(68, 76)).toString().substring(0,10)
                    afe2_data = {
                        "AFE2_one": AFE2_one,
                        "AFE2_two": AFE2_two,
                        "AFE2_three": AFE2_three,
                        "AFE2_four": AFE2_four,
                        "AFE2_five": AFE2_five,
                        "AFE2_six": AFE2_six,
                        "AFE2_seven": AFE2_seven,
                        "AFE2_eight": AFE2_eight,
                        "date": getCurrentTime(),
                        "save_date": new Date()
                    }
                }

                //加速度数
                if (JSON.stringify(acc_data) != '{}'){
                    // "accDatax": accDatax,
                    //     "accDatay": accDatay,
                    //     "accDataz": accDataz,
                    //     "date": getCurrentTime(),
                    //     "save_date": new Date()
                    $("#acc_d_x").val(acc_data.accDatax)
                    $("#acc_d_y").val(acc_data.accDatay)
                    $("#acc_d_z").val(acc_data.accDataz)
                    $("#acc_d_time").val(acc_data.date)
                    acc_list.push(acc_data)
                }
                if(acc_list.length > 100 && number_flg == 1){
                    acc_list = []
                }
                //陀螺仪数据添加
                if (JSON.stringify(gyr_data) != '{}'){
                    $("#gry_d_x").val(gyr_data.gyrDatax)
                    $("#gry_d_y").val(gyr_data.gyrDatay)
                    $("#gry_d_z").val(gyr_data.gyrDataz)
                    $("#gry_d_time").val(gyr_data.date)
                    gyr_list.push(gyr_data)
                }
                if(gyr_list.length > 100 && number_flg == 1){
                    gyr_list = []
                }
                //磁力计数据添加
                if (JSON.stringify(mag_data) != '{}'){
                    $("#mag_d_x").val(mag_data.magDatax)
                    $("#mag_d_y").val(mag_data.magDatay)
                    $("#mag_d_z").val(mag_data.magDataz)
                    $("#mag_d_time").val(mag_data.date)
                    mag_list.push(mag_data)
                }
                if(mag_list.length > 100 && number_flg == 1){
                    mag_list = []
                }
                //光学传感器数据添加
                if (JSON.stringify(opt_data) != '{}'){
                  //  console.log(opt_data)
                    $("#opt_d_red").val(opt_data.h)
                    $("#opt_d_hw").val(opt_data.hw)
                    $("#opt_d_lv").val(opt_data.lv)
                    $("#opt_d_lan").val(opt_data.lan)
                    $("#opt_d_time").val(opt_data.date)
                    opt_list.push(opt_data)
                }
                if(opt_list.length > 100 && number_flg == 1){
                    opt_list = []
                }
                //afe1数据添加
                if (JSON.stringify(afe1_data) != '{}'){
                    $("#afe1_d_one").val(afe1_data.AFE1_one)
                    $("#afe1_d_two").val(afe1_data.AFE1_two)
                    $("#afe1_d_three").val(afe1_data.AFE1_three)
                    $("#afe1_d_four").val(afe1_data.AFE1_four)
                    $("#afe1_d_five").val(afe1_data.AFE1_five)
                    $("#afe1_d_six").val(afe1_data.AFE1_six)
                    $("#afe1_d_seven").val(afe1_data.AFE1_seven)
                    $("#afe1_d_eight").val(afe1_data.AFE1_eight)
                    $("#afe1_d_time").val(afe1_data.date)
                    afe1_list.push(afe1_data)
                }
                if(afe1_list.length > 100 && number_flg == 1){
                    afe1_list = []
                }
                //afe2数据添加
                if (JSON.stringify(afe2_data) != '{}'){
                    $("#afe2_d_one").val(afe2_data.AFE2_one)
                    $("#afe2_d_two").val(afe2_data.AFE2_two)
                    $("#afe2_d_three").val(afe2_data.AFE2_three)
                    $("#afe2_d_four").val(afe2_data.AFE2_four)
                    $("#afe2_d_five").val(afe2_data.AFE2_five)
                    $("#afe2_d_six").val(afe2_data.AFE2_six)
                    $("#afe2_d_seven").val(afe2_data.AFE2_seven)
                    $("#afe2_d_eight").val(afe2_data.AFE2_eight)
                    $("#afe2_d_time").val(afe2_data.date)
                    afe2_list.push(afe2_data)
                }
                if(afe2_list.length > 100 && number_flg == 1){
                    afe2_list = []
                }



                //图表
                //标题
                // var text;
                // //元素
                // var lenged;
                // //横坐标数据
                // var xAxis;
                // //纵坐标数据
                // var series = [];
                //
                // //加速度
                // if (selData == '01') {
                //     var acc_x = []
                //     var acc_y = []
                //     var acc_z = []
                //     var acc_time = []
                //
                //     text = '加速度'
                //     lenged = ['x轴', 'y轴', 'z轴']
                //
                //     for (var i = 0; i < acc_list.length; i++) {
                //         // alert(acc_list[i].date+' '+acc_list[i].accDatax)
                //         acc_time.push(acc_list[i].date)
                //         acc_x.push(acc_list[i].accDatax)
                //         acc_y.push(acc_list[i].accDatay)
                //         acc_z.push(acc_list[i].accDataz)
                //     }
                //
                //     // if(acc_x.length >= 100){
                //     //     acc_x = acc_x.slice(-100)
                //     //     acc_time = acc_time.slice(-100)
                //     //     acc_y = acc_y.slice(-100)
                //     //     acc_z = acc_z.slice(-100)
                //     // }
                //     xAxis = acc_time
                //     series = [
                //         {
                //             name: 'x轴',
                //             type: 'line',
                //             stack: '总量',
                //             data: acc_x
                //         },
                //         {
                //             name: 'y轴',
                //             type: 'line',
                //             stack: '总量',
                //             data: acc_y
                //         },
                //         {
                //             name: 'z轴',
                //             type: 'line',
                //             stack: '总量',
                //             data: acc_z
                //         }
                //     ]
                //
                // } else if (selData == '02') {
                //     var gyr_x = []
                //     var gyr_y = []
                //     var gyr_z = []
                //     var gyr_time = []
                //
                //     text = '陀螺仪'
                //     lenged = ['x轴', 'y轴', 'z轴']
                //     for (var i = 0; i < gyr_list.length; i++) {
                //         // alert(acc_list[i].date+' '+acc_list[i].accDatax)
                //         gyr_time.push(gyr_list[i].date)
                //         gyr_x.push(gyr_list[i].gyrDatax)
                //         gyr_y.push(gyr_list[i].gyrDatay)
                //         gyr_z.push(gyr_list[i].gyrDataz)
                //     }
                //
                //     // if(gyr_x.length >= 100){
                //     //     gyr_x.slice(-100)
                //     //     gyr_time.slice(-100)
                //     //     gyr_y.slice(-100)
                //     //     gyr_z.slice(-100)
                //     // }
                //     xAxis = gyr_time
                //     series = [
                //         {
                //             name: 'x轴',
                //             type: 'line',
                //             data: gyr_x
                //         },
                //         {
                //             name: 'y轴',
                //             type: 'line',
                //             data: gyr_y
                //         },
                //         {
                //             name: 'z轴',
                //             type: 'line',
                //             data: gyr_z
                //         }
                //     ]
                //     //磁力计
                // } else if (selData == '03') {
                //
                //     var mag_x = []
                //     var mag_y = []
                //     var mag_z = []
                //     var mag_time = []
                //
                //     text = '磁力计'
                //     lenged = ['x轴', 'y轴', 'z轴']
                //     for (var i = 0; i < mag_list.length; i++) {
                //         // alert(acc_list[i].date+' '+acc_list[i].accDatax)
                //         mag_time.push(mag_list[i].date)
                //         mag_x.push(mag_list[i].magDatax)
                //         mag_y.push(mag_list[i].magDatay)
                //         mag_z.push(mag_list[i].magDataz)
                //     }
                //
                //     // if(mag_x.length >= 100){
                //     //     mag_x.slice(-100)
                //     //     mag_time.slice(-100)
                //     //     mag_y.slice(-100)
                //     //     mag_z.slice(-100)
                //     // }
                //     xAxis = mag_time
                //     series = [
                //         {
                //             name: 'x轴',
                //             type: 'line',
                //             data: mag_x
                //         },
                //         {
                //             name: 'y轴',
                //             type: 'line',
                //             data: mag_y
                //         },
                //         {
                //             name: 'z轴',
                //             type: 'line',
                //             data: mag_z
                //         }
                //     ]
                //     //光学传感器
                // } else if (selData == '04') {
                //     var hw = []
                //     var h = []
                //     var lv = []
                //     var lan =[]
                //     var opt_time = []
                //
                //     text = '光学传感器'
                //     lenged = ['红外', '红光','绿光','蓝光']
                //     for (var i = 0; i < opt_list.length; i++) {
                //         // alert(acc_list[i].date+' '+acc_list[i].accDatax)
                //         opt_time.push(opt_list[i].date)
                //         hw.push(opt_list[i].hw)
                //         h.push(opt_list[i].h)
                //         lv.push(opt_list[i].lv)
                //         lan.push(opt_list[i].lan)
                //
                //     }
                //
                //     // if(hw.length >= 100){
                //     //     opt_time.slice(-100)
                //     //     hw.slice(-100)
                //     //     h.slice(-100)
                //     //     lv.slice(-100)
                //     //     lan.slice(-100)
                //     // }
                //     xAxis = opt_time
                //     series = [
                //         {
                //             name: '红外',
                //             type: 'line',
                //             data: hw
                //         },
                //         {
                //             name: '红光',
                //             type: 'line',
                //             data: h
                //         },
                //         {
                //             name: '绿光',
                //             type: 'line',
                //             data: lv
                //         },
                //         {
                //             name: '蓝光',
                //             type: 'line',
                //             data: lan
                //         }
                //     ]
                //
                // } else if (selData == '05') {
                //     var afe1_one = []
                //     var afe1_two = []
                //     var afe1_three = []
                //     var afe1_four = []
                //     var afe1_five = []
                //     var afe1_six = []
                //     var afe1_seven = []
                //     var afe1_eight = []
                //     var afe1_time = []
                //
                //     text = '生物电势AFE1'
                //     lenged = ['一通道', '二通道', '三通道', '四通道', '五通道', '六通道', '七通道', '八通道']
                //     for (var i = 0; i < afe1_list.length; i++) {
                //         // alert(acc_list[i].date+' '+acc_list[i].accDatax)
                //         afe1_time.push(afe1_list[i].date)
                //         afe1_one.push(afe1_list[i].AFE1_one)
                //         afe1_two.push(afe1_list[i].AFE1_two)
                //         afe1_three.push(afe1_list[i].AFE1_three)
                //         afe1_four.push(afe1_list[i].AFE1_four)
                //         afe1_five.push(afe1_list[i].AFE1_five)
                //         afe1_six.push(afe1_list[i].AFE1_six)
                //         afe1_seven.push(afe1_list[i].AFE1_seven)
                //         afe1_eight.push(afe1_list[i].AFE1_eight)
                //
                //     }
                //     // if (afe1_time.length >= 100){
                //     //     afe1_time.slice(-100)
                //     //     afe1_one.slice(-100)
                //     //     afe1_two.slice(-100)
                //     //     afe1_three.slice(-100)
                //     //     afe1_four.slice(-100)
                //     //     afe1_five.slice(-100)
                //     //     afe1_six.slice(-100)
                //     //     afe1_seven.slice(-100)
                //     //     afe1_eight.slice(-100)
                //     // }
                //     xAxis = afe1_time
                //     series = [
                //         {
                //             name: '一通道',
                //             type: 'line',
                //             data: afe1_one
                //         },
                //         {
                //             name: '二通道',
                //             type: 'line',
                //             data: afe1_two
                //         },
                //         {
                //             name: '三通道',
                //             type: 'line',
                //             data: afe1_three
                //         },
                //         {
                //             name: '四通道',
                //             type: 'line',
                //             data: afe1_four
                //         },
                //         {
                //             name: '五通道',
                //             type: 'line',
                //             data: afe1_five
                //         },
                //         {
                //             name: '六通道',
                //             type: 'line',
                //             data: afe1_six
                //         },
                //         {
                //             name: '七通道',
                //             type: 'line',
                //             data: afe1_seven
                //         },
                //         {
                //             name: '八通道',
                //             type: 'line',
                //             data: afe1_eight
                //         },
                //     ]
                //
                //
                // } else if (selData == '06') {
                //     var afe2_one = []
                //     var afe2_two = []
                //     var afe2_three = []
                //     var afe2_four = []
                //     var afe2_five = []
                //     var afe2_six = []
                //     var afe2_seven = []
                //     var afe2_eight = []
                //     var afe2_time = []
                //
                //     text = '生物电势AFE2'
                //     lenged = ['一通道', '二通道', '三通道', '四通道', '五通道', '六通道', '七通道', '八通道']
                //     for (var i = 0; i < afe2_list.length; i++) {
                //         // alert(acc_list[i].date+' '+acc_list[i].accDatax)
                //         afe2_time.push(afe2_list[i].date)
                //         afe2_one.push(afe2_list[i].AFE2_one)
                //         afe2_two.push(afe2_list[i].AFE2_two)
                //         afe2_three.push(afe2_list[i].AFE2_three)
                //         afe2_four.push(afe2_list[i].AFE2_four)
                //         afe2_five.push(afe2_list[i].AFE2_five)
                //         afe2_six.push(afe2_list[i].AFE2_six)
                //         afe2_seven.push(afe2_list[i].AFE2_seven)
                //         afe2_eight.push(afe2_list[i].AFE2_eight)
                //
                //     }
                //     // if (afe2_time.length >= 100){
                //     //     afe2_time.slice(-100)
                //     //     afe2_one.slice(-100)
                //     //     afe2_two.slice(-100)
                //     //     afe2_three.slice(-100)
                //     //     afe2_four.slice(-100)
                //     //     afe2_five.slice(-100)
                //     //     afe2_six.slice(-100)
                //     //     afe2_seven.slice(-100)
                //     //     afe2_eight.slice(-100)
                //     // }
                //     xAxis = afe2_time
                //     series = [
                //         {
                //             name: '一通道',
                //             type: 'line',
                //             data: afe2_one
                //         },
                //         {
                //             name: '二通道',
                //             type: 'line',
                //             data: afe2_two
                //         },
                //         {
                //             name: '三通道',
                //             type: 'line',
                //             data: afe2_three
                //         },
                //         {
                //             name: '四通道',
                //             type: 'line',
                //             data: afe2_four
                //         },
                //         {
                //             name: '五通道',
                //             type: 'line',
                //             data: afe2_five
                //         },
                //         {
                //             name: '六通道',
                //             type: 'line',
                //             data: afe2_six
                //         },
                //         {
                //             name: '七通道',
                //             type: 'line',
                //             data: afe2_seven
                //         },
                //         {
                //             name: '八通道',
                //             type: 'line',
                //             data: afe2_eight
                //         },
                //     ]
                // }




               // console.log("标题:"+text)
              //  console.log("元素"+lenged)
              //  console.log(xAxis)
               // console.log("纵坐标:"+series)
                //渲染图表
                //加速度图表
                // 1 单独一个
                // var myChart = echarts.init(document.getElementById('acc_ec'));
                // var option;

                // option = {
                //     title: {
                //         text: text
                //     },
                //     tooltip: {
                //         trigger: 'axis'
                //     },
                //     legend: {
                //         data: lenged
                //     },
                //     grid: {
                //         left: '3%',
                //         right: '4%',
                //         bottom: '3%',
                //         containLabel: true
                //     },
                //     toolbox: {
                //         feature: {
                //             saveAsImage: {}
                //         }
                //     },
                //     xAxis: {
                //         show:false,
                //         type: 'category',
                //         boundaryGap: false,
                //         data: xAxis,
                //         axisLabel: {
                //             rotate: -30
                //         }
                //     },
                //     yAxis: {
                //         type: 'value',
                //         minInterval: 1
                //     },
                //     series: series
                // };


                $('#qh_btn').click(function (){

                    myChart.clear()
                    selData = $('#data_sel').val()

                })
                // 使用刚指定的配置项和数据显示图表。
                myChart.setOption(option);

            }
        }

        //连接关闭的回调方法
        websocket.onclose = function () {
            setMessageInnerHTML("close");
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

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function () {
            websocket.close();

            //加个loading

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
            //获取com列表
            $.ajax({
                type:"POST",
                contentType: "application/x-www-form-urlencoded;charset=UTF-8",
                url:"getCom",
                success:function (res){
                 //   console.log(res)
                    $("#cklst").empty();//首先清空select现在有的内容
                    $("#cklst").append("<option selected='selected'  value=0>请选择串口</option>");
                    for (var i = 0;i<res.length;i++){
                        var item = res[i]
                        $("#cklst").append("<option  value=" + item+ ">" + item + "</option>");

                    }
                }
            })



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

            websocket.send(JSON.stringify(setData))

            //传到后台
            <%--$.ajax({--%>
            <%--    data: {"setData": setData},--%>
            <%--    type: "post",--%>
            <%--    dataType: "json",--%>
            <%--    url: "${pageContext.request.contextPath}/web/setUp",--%>
            <%--    success: function (data) {--%>


            <%--        if (data.code == 200) {--%>
            <%--            alert("配置修改成功")--%>
            <%--        }--%>
            <%--    }--%>
            <%--})--%>


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
