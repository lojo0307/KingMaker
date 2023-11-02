package com.dollyanddot.kingmaker.domain.notification.exception;

public class UpdateNotificationException extends RuntimeException{
    public UpdateNotificationException(){
        super();
    }
    public UpdateNotificationException(String message){
        super(message);
    }
    public UpdateNotificationException(String message, Throwable th){
        super(message, th);
    }
}