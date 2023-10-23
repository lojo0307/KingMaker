package com.dollyanddot.kingmaker.domain.todo.exception;

public class NonExistTodoIdException extends RuntimeException{
    public NonExistTodoIdException(){
        super();
    }
    public NonExistTodoIdException(String message){
        super(message);
    }
    public NonExistTodoIdException(String message, Throwable th){
        super(message, th);
    }
}
