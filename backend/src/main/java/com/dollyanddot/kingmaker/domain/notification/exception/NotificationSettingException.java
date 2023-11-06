package com.dollyanddot.kingmaker.domain.notification.exception;

public class NotificationSettingException extends RuntimeException{
    public NotificationSettingException(){
        super();
    }
    public NotificationSettingException(String message){
        super(message);
    }
    public NotificationSettingException(String message, Throwable th){
        super(message, th);
    }
}