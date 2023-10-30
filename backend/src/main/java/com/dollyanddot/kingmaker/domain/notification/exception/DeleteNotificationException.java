package com.dollyanddot.kingmaker.domain.notification.exception;

public class DeleteNotificationException extends RuntimeException{
    public DeleteNotificationException(){
        super();
    }
    public DeleteNotificationException(String message){
        super(message);
    }
    public DeleteNotificationException(String message, Throwable th){
        super(message, th);
    }
}