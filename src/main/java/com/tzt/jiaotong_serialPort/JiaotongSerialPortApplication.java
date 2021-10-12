package com.tzt.jiaotong_serialPort;

import com.tzt.jiaotong_serialPort.socket.Socket;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
public class JiaotongSerialPortApplication {

	public static void main(String[] args) {
		SpringApplication.run(JiaotongSerialPortApplication.class, args);

	}

}
