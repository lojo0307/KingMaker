package com.dollyanddot.kingmaker.domain.category.exception;

import com.dollyanddot.kingmaker.global.exception.domain.NotFoundException;

public class CategoryNotFoundException extends NotFoundException {
    public CategoryNotFoundException() {
        super("1804", "할 일을 찾을 수 없습니다.");
    }

}