package com.dollyanddot.kingmaker.domain.category.service;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
import com.dollyanddot.kingmaker.domain.category.dto.CategoryDto;
import com.dollyanddot.kingmaker.domain.category.dto.response.CategoryCntResDto;
import com.dollyanddot.kingmaker.domain.category.exception.CategoryNotFoundException;
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
        log.info("todo 번호: {}", todo.getCategoryId());
        log.info("todo 개수: {}", todo.getCnt());
        log.info("todo 수정일: {}", todo.getModifiedAt());

        CategoryCntResDto routine = routineRepository.getMinRoutineCategory(memberId);
        log.info("routine 번호: {}", routine.getCategoryId());
        log.info("routine 개수: {}", routine.getCnt());
        log.info("routine 수정일: {}", routine.getModifiedAt());

        //둘 다 달성한 개수가 없는 경우
        if(todo.getCnt()==-1 && routine.getCnt()==-1) {
            return CategoryDto.builder().categoryId(-1L).categoryNm(
                "달성한 일정이 없음").build();
        }

        Category category;
        //둘 중에 하나라도 달성한 게 있으면 개수 비교
        if(todo.getCnt()==routine.getCnt()) {
            //최신순
            if(todo.getModifiedAt().isAfter(routine.getModifiedAt())) {
                category = categoryRepository.findById(
                    todo.getCategoryId()).orElseThrow(CategoryNotFoundException::new);
            } else {
                category = categoryRepository.findById(
                    routine.getCategoryId()).orElseThrow(CategoryNotFoundException::new);
            }
        } else {
            Long categoryId = todo.getCnt()<routine.getCnt()? todo.getCategoryId() : routine.getCategoryId();
            category = categoryRepository.findById(categoryId).orElseThrow(CategoryNotFoundException::new);
        }

        return CategoryDto.builder().categoryId(category.getId()).categoryNm(
            category.getName()).build();
    }

    public CategoryDto getMaxCategory(Long memberId) {
        CategoryCntResDto todo = todoRepository.getMaxTodoCategory(memberId);
        log.info("todo 번호: {}", todo.getCategoryId());
        log.info("todo 개수: {}", todo.getCnt());
        log.info("todo 수정일: {}", todo.getModifiedAt());

        CategoryCntResDto routine = routineRepository.getMaxRoutineCategory(memberId);
        log.info("routine 번호: {}", routine.getCategoryId());
        log.info("routine 개수: {}", routine.getCnt());
        log.info("routine 수정일: {}", routine.getModifiedAt());

        //둘 다 달성한 개수가 없는 경우
        if(todo.getCnt()==-1 && routine.getCnt()==-1) {
            return CategoryDto.builder().categoryId(-1L).categoryNm(
                "달성한 일정이 없음").build();
        }

        Category category;
        //둘 중에 하나라도 달성한 게 있으면 개수 비교
        if(todo.getCnt()==routine.getCnt()) {
            //최신순
            if(todo.getModifiedAt().isAfter(routine.getModifiedAt())) {
                category = categoryRepository.findById(
                    todo.getCategoryId()).orElseThrow(CategoryNotFoundException::new);
            } else {
                category = categoryRepository.findById(
                    routine.getCategoryId()).orElseThrow(CategoryNotFoundException::new);
            }
        } else {
            Long categoryId = todo.getCnt()>routine.getCnt()? todo.getCategoryId() : routine.getCategoryId();
            category = categoryRepository.findById(categoryId).orElseThrow(CategoryNotFoundException::new);
        }

        return CategoryDto.builder().categoryId(category.getId()).categoryNm(
            category.getName()).build();
    }

}
