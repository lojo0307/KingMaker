package com.dollyanddot.kingmaker.domain.category.service;

import com.dollyanddot.kingmaker.domain.category.dto.CategoryDto;
import com.dollyanddot.kingmaker.domain.category.dto.response.CategoryCntResDto;
import com.dollyanddot.kingmaker.domain.category.repository.CategoryRepository;
import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRepository;
import com.dollyanddot.kingmaker.domain.todo.repository.TodoRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class CategoryService {

    private final TodoRepository todoRepository;
    private final RoutineRepository routineRepository;
    private final CategoryRepository categoryRepository;

    public CategoryDto getMinCategory(Long memberId) {
        CategoryCntResDto todo = todoRepository.getMinTodoCategory(memberId);
        if(todo!=null) {
            log.info("번호: {}", todo.getCategoryId());
            log.info("개수: {}", todo.getCnt());
            log.info("수정일: {}", todo.getModifiedAt());
        }

        CategoryCntResDto routine = routineRepository.getMinRoutineCategory(memberId);
        if(routine!=null) {
            log.info("번호: {}", routine.getCategoryId());
            log.info("개수: {}", routine.getCnt());
            log.info("수정일: {}", routine.getModifiedAt());
        }

        //카테고리 예외 처리?
        if(todo==null && routine!=null) {
            return CategoryDto.from(categoryRepository.findById(routine.getCategoryId()).get());
        } else if(todo!=null && routine==null) {
            return CategoryDto.from(categoryRepository.findById(todo.getCategoryId()).get());
        } else if(todo!=null && routine!=null) {
            int comparison = (todo.getCnt() == routine.getCnt())
                ? todo.getModifiedAt().compareTo(routine.getModifiedAt())
                : Long.compare(todo.getCnt(), routine.getCnt());
        } else if(todo==null && routine==null) {
        }

        return null;
    }

    public CategoryDto getMaxCategory(Long memberId) {
        CategoryCntResDto categoryTodoCntResDto = todoRepository.getMaxTodoCategory(memberId);
        if(categoryTodoCntResDto!=null) {
            log.info("번호: {}", categoryTodoCntResDto.getCategoryId());
            log.info("개수: {}", categoryTodoCntResDto.getCnt());
            log.info("수정일: {}", categoryTodoCntResDto.getModifiedAt());
        }

        CategoryCntResDto categoryRoutineCntResDto = routineRepository.getMaxRoutineCategory(memberId);
        if(categoryRoutineCntResDto!=null) {
            log.info("번호: {}", categoryRoutineCntResDto.getCategoryId());
            log.info("개수: {}", categoryRoutineCntResDto.getCnt());
            log.info("수정일: {}", categoryRoutineCntResDto.getModifiedAt());
        }

        return null;
    }

}
