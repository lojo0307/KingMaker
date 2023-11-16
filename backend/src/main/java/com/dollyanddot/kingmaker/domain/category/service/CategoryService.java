package com.dollyanddot.kingmaker.domain.category.service;

import com.dollyanddot.kingmaker.domain.category.domain.Category;
import com.dollyanddot.kingmaker.domain.category.dto.CategoryDto;
import com.dollyanddot.kingmaker.domain.category.dto.response.CategoryCntResDto;
import com.dollyanddot.kingmaker.domain.category.exception.CategoryNotFoundException;
import com.dollyanddot.kingmaker.domain.category.repository.CategoryRepository;
import com.dollyanddot.kingmaker.domain.routine.repository.RoutineRepository;
import com.dollyanddot.kingmaker.domain.todo.repository.TodoRepository;
import java.util.ArrayList;
import java.util.List;
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
    public List<CategoryDto> getMaxCategory(Long memberId) {
        List<CategoryCntResDto> todoList = todoRepository.getMaxTodoCategory(memberId);
        List<CategoryCntResDto> routineList = routineRepository.getMaxRoutineCategory(memberId);
        log.info("size1: {}", todoList.size());
        log.info("size2: {}", routineList.size());

        List<CategoryDto> category = new ArrayList<>();
        Long maxCnt = 0L;
        Long minCnt = 0L;

        //둘 다 달성한 게 하나도 없는 경우
        if(todoList.size()==1 && routineList.size()==1) {
            if(todoList.get(0).getCnt()==-1 && routineList.get(0).getCnt()==-1) {
                CategoryDto c1 = CategoryDto.builder().categoryId(-1L).categoryNm(
                    "달성한 일정이 없음").type("MAX").build();
                category.add(c1);
                CategoryDto c2 = CategoryDto.builder().categoryId(-1L).categoryNm(
                    "달성한 일정이 없음").type("MIN").build();
                category.add(c2);
                return category;

                //동일한 달성 개수인 경우
            } else if(todoList.get(0).getCnt()!=-1 && routineList.get(0).getCnt()!=1){
                Long categoryId = todoList.get(0).getCnt() > routineList.get(0).getCnt()
                    ? todoList.get(0).getCategoryId() : routineList.get(0).getCategoryId();
                Category c = categoryRepository.findById(categoryId)
                    .orElseThrow(CategoryNotFoundException::new);
                category.add(CategoryDto.from(c, "MAX"));

                //max값
                maxCnt = todoList.get(0).getCnt() > routineList.get(0).getCnt()
                    ? todoList.get(0).getCnt() : routineList.get(0).getCnt();

                CategoryDto c2 = CategoryDto.builder().categoryId(-1L).categoryNm(
                    "달성한 일정이 없음").type("MIN").build();
                category.add(c2);
                return category;
            }
        }

        //1개인데 -1이 아닌 경우(null이 아니었던 경우-최소 비교를 위해 넣기)
        if(todoList.size()==1 && todoList.get(0).getCnt()!=-1) {
            CategoryCntResDto c = CategoryCntResDto.builder().categoryId(-1L).cnt(-1L).build();
            todoList.add(c);
        }
        for(CategoryCntResDto todo : todoList) {
            log.info("todo 번호: {}", todo.getCategoryId());
            log.info("todo 개수: {}", todo.getCnt());
        }

        //1개인데 -1이 아닌 경우(null이 아니었던 경우-최소 비교를 위해 넣기)
        if(routineList.size()==1 && routineList.get(0).getCnt()!=-1) {
            CategoryCntResDto c = CategoryCntResDto.builder().categoryId(-1L).cnt(-1L).build();
            routineList.add(c);
        }
        for(CategoryCntResDto routine : routineList) {
            log.info("routine 번호: {}", routine.getCategoryId());
            log.info("routine 개수: {}", routine.getCnt());
        }

        //둘 중에 하나라도 달성한 게 있으면 우선 max값 비교
        if(todoList.get(0).getCnt()==routineList.get(0).getCnt()) {
            //최신순
            if(todoList.get(0).getModifiedAt().isAfter(routineList.get(0).getModifiedAt())) {
                Category c = categoryRepository.findById(todoList.get(0).getCategoryId())
                    .orElseThrow(CategoryNotFoundException::new);
                category.add(CategoryDto.from(c, "MAX"));
                maxCnt = todoList.get(0).getCnt();

            } else {
                Category c = categoryRepository.findById(routineList.get(0).getCategoryId())
                    .orElseThrow(CategoryNotFoundException::new);
                category.add(CategoryDto.from(c, "MAX"));
                maxCnt = routineList.get(0).getCnt();
            }

        } else {
            Long categoryId = todoList.get(0).getCnt()>routineList.get(0).getCnt()
                    ? todoList.get(0).getCategoryId() : routineList.get(0).getCategoryId();
            Category c = categoryRepository.findById(categoryId)
                .orElseThrow(CategoryNotFoundException::new);
            category.add(CategoryDto.from(c, "MAX"));
            maxCnt = todoList.get(0).getCnt() > routineList.get(0).getCnt()
                ? todoList.get(0).getCnt() : routineList.get(0).getCnt();
        }

        //min값 비교
        int tLen = todoList.size()-1;
        int rLen = routineList.size()-1;

        //근데 -1은 걸러
        if(todoList.get(tLen).getCnt()==-1 && routineList.get(rLen).getCnt()!=-1) {
            Category c =  categoryRepository.findById(routineList.get(rLen).getCategoryId())
                .orElseThrow(CategoryNotFoundException::new);
            category.add(CategoryDto.from(c, "MIN"));

        } else if(todoList.get(tLen).getCnt()!=-1 && routineList.get(rLen).getCnt()==-1) {
            Category c = categoryRepository.findById(todoList.get(tLen).getCategoryId())
                .orElseThrow(CategoryNotFoundException::new);
            category.add(CategoryDto.from(c, "MIN"));

        } else if(todoList.get(tLen).getCnt()==-1 && routineList.get(rLen).getCnt()==-1) {
            CategoryDto c = CategoryDto.builder().categoryId(-1L).categoryNm(
                "달성한 일정이 없음").type("MIN").build();
            category.add(c);

        } else {
            if (todoList.get(tLen).getCnt() == routineList.get(rLen).getCnt()) {
                //근데 만약 max개수랑 같으면 min은 없는 걸로
                if(todoList.get(tLen).getCnt() == maxCnt) {
                    CategoryDto c = CategoryDto.builder().categoryId(-1L).categoryNm(
                        "달성한 일정이 없음").type("MIN").build();
                    category.add(c);

                } else {
                    //최신순
                    if (todoList.get(tLen).getModifiedAt()
                        .isAfter(routineList.get(rLen).getModifiedAt())) {
                        Category c = categoryRepository.findById(todoList.get(tLen).getCategoryId())
                            .orElseThrow(CategoryNotFoundException::new);
                        category.add(CategoryDto.from(c, "MIN"));
                    } else {
                        Category c = categoryRepository.findById(routineList.get(rLen).getCategoryId())
                            .orElseThrow(CategoryNotFoundException::new);
                        category.add(CategoryDto.from(c, "MIN"));
                    }
                }

            } else {
                Long categoryId = todoList.get(tLen).getCnt() < routineList.get(rLen).getCnt()
                    ? todoList.get(tLen).getCategoryId() : routineList.get(rLen).getCategoryId();
                Category c = categoryRepository.findById(categoryId)
                    .orElseThrow(CategoryNotFoundException::new);
                category.add(CategoryDto.from(c, "MIN"));
            }
        }

        return category;
    }
}
