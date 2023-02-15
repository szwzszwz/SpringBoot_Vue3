package com.example.common;

public class Result<T> { // 包装类
    private String code; // 请求成功或者失败返回码
    private String msg; // 请求失败的原因(一句话：用户名或者密码不正确)
    private T data; // （泛型）表示可以包装任意数据

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public Result() {
    }

    public Result(T data) {
        this.data = data;
    }

    public static Result success() {
        Result result = new Result<>();
        result.setCode("0");
        result.setMsg("成功");
        return result;
    }

    public static <T> Result<T> success(T data) { // 成功的时候返回的数据
        Result<T> result = new Result<>(data);
        result.setCode("0");
        result.setMsg("成功");
        return result;
    }

    public static Result error(String code, String msg) { // 失败的时候返回的数据
        Result result = new Result();
        result.setCode(code);
        result.setMsg(msg);
        return result;
    }
}
