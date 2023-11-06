package com.dollyanddot.kingmaker.domain.todo.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class TodoNotFoundException extends NotFoundException {
    public TodoNotFoundException() {
        super("1004", "할 일을 찾을 수 없습니다.");
    }
}
