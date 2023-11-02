package com.dollyanddot.kingmaker.domain.notification.exception;

public class ProcessingNotificationException extends RuntimeException{
    public ProcessingNotificationException(){
        super();
    }
    public ProcessingNotificationException(String message){
        super(message);
    }
    public ProcessingNotificationException(String message, Throwable th){
        super(message, th);
    }
}
