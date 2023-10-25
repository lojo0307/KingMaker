package com.dollyanddot.kingmaker.domain.todo.exception;

public class GetTodoDetailException extends RuntimeException{
    public GetTodoDetailException(){
        super();
    }
    public GetTodoDetailException(String message){
        super(message);
    }
    public GetTodoDetailException(String message, Throwable th){
        super(message, th);
    }
}
