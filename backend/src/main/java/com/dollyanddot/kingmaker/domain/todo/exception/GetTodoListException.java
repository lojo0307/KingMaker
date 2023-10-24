package com.dollyanddot.kingmaker.domain.todo.exception;

public class GetTodoListException extends RuntimeException{
    public GetTodoListException(){
        super();
    }
    public GetTodoListException(String message){
        super(message);
    }
    public GetTodoListException(String message, Throwable th){
        super(message, th);
    }
}
