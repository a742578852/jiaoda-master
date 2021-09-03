package com.tzt.jiaotong_serialPort.model;


public class SetData {

    //加速度频率
    private int accfre;
    //陀螺仪频率
    private int gyrfre;
    //磁力计频率
    private int magfre;
    //光学传感器频率
    private int optfre;
    //生物电势1工作通道数
    private int bio1pass;
    //生物电势1频率
    private int bio1fre;
    //生物2通道数
    private int bio2pass;
    //生物2频率
    private int bio2fre;
    //加速度开关
    private boolean acc_input;
    //陀螺仪开关
    private boolean gre_input;
    //磁力计开关
    private boolean mag_input;
    //光学传感器
    private boolean opt_input;
    //红光
    private boolean rel_input;
    //红外
    private boolean inf_input;
    //绿光
    private boolean green_input;
    //蓝光
    private boolean blue_input;
    //生物电1开关
    private boolean bio1_input;
    //生物电2开关
    private boolean bio2_input;

    public int getAccfre() {
        return accfre;
    }

    public void setAccfre(int accfre) {
        this.accfre = accfre;
    }

    public int getGyrfre() {
        return gyrfre;
    }

    public void setGyrfre(int gyrfre) {
        this.gyrfre = gyrfre;
    }

    public int getMagfre() {
        return magfre;
    }

    public void setMagfre(int magfre) {
        this.magfre = magfre;
    }

    public int getOptfre() {
        return optfre;
    }

    public void setOptfre(int optfre) {
        this.optfre = optfre;
    }

    public int getBio1pass() {
        return bio1pass;
    }

    public void setBio1pass(int bio1pass) {
        this.bio1pass = bio1pass;
    }

    public int getBio1fre() {
        return bio1fre;
    }

    public void setBio1fre(int bio1fre) {
        this.bio1fre = bio1fre;
    }

    public int getBio2pass() {
        return bio2pass;
    }

    public void setBio2pass(int bio2pass) {
        this.bio2pass = bio2pass;
    }

    public int getBio2fre() {
        return bio2fre;
    }

    public void setBio2fre(int bio2fre) {
        this.bio2fre = bio2fre;
    }

    public boolean isAcc_input() {
        return acc_input;
    }

    public void setAcc_input(boolean acc_input) {
        this.acc_input = acc_input;
    }

    public boolean isGre_input() {
        return gre_input;
    }

    public void setGre_input(boolean gre_input) {
        this.gre_input = gre_input;
    }

    public boolean isMag_input() {
        return mag_input;
    }

    public void setMag_input(boolean mag_input) {
        this.mag_input = mag_input;
    }

    public boolean isOpt_input() {
        return opt_input;
    }

    public void setOpt_input(boolean opt_input) {
        this.opt_input = opt_input;
    }

    public boolean isRel_input() {
        return rel_input;
    }

    public void setRel_input(boolean rel_input) {
        this.rel_input = rel_input;
    }

    public boolean isInf_input() {
        return inf_input;
    }

    public void setInf_input(boolean inf_input) {
        this.inf_input = inf_input;
    }

    public boolean isGreen_input() {
        return green_input;
    }

    public void setGreen_input(boolean green_input) {
        this.green_input = green_input;
    }

    public boolean isBlue_input() {
        return blue_input;
    }

    public void setBlue_input(boolean blue_input) {
        this.blue_input = blue_input;
    }

    public boolean isBio1_input() {
        return bio1_input;
    }

    public void setBio1_input(boolean bio1_input) {
        this.bio1_input = bio1_input;
    }

    public boolean isBio2_input() {
        return bio2_input;
    }

    public void setBio2_input(boolean bio2_input) {
        this.bio2_input = bio2_input;
    }
}
