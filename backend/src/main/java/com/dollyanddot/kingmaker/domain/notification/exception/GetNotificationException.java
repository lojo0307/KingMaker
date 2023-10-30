package com.dollyanddot.kingmaker.domain.notification.exception;

public class GetNotificationException extends RuntimeException{
    public GetNotificationException(){
        super();
    }
    public GetNotificationException(String message){
        super(message);
    }
    public GetNotificationException(String message, Throwable th){
        super(message, th);
    }
}