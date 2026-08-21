#include "grade_school.h"


int sort(const void * a, const void * b){
    student_t *s1 = (student_t *)a;
    student_t *s2 = (student_t *)b;
    if (s1->grade != s2->grade) 
        return s1->grade - s2->grade;
    else
        return strcmp(s1->name, s2->name);
}

void init_roster(roster_t * rost){
    rost->count = 0;
}

bool add_student(roster_t *roster, 
                 char *name, 
                 uint8_t grade){
    for (size_t i = 0; i < roster->count; i++){
        if (strcmp(roster->students[i].name, name) == 0)
            return false;
    }
    student_t student;
    student.grade = grade;
    strcpy(student.name, name);
    roster->students[roster->count++] = student;
    qsort(roster->students, 
          roster->count, 
          sizeof(student_t), 
          sort);
    return true;
}

roster_t get_grade(roster_t *roster, 
                   uint8_t desired_grade){
    roster_t grade;
    grade.count = 0;
    for (size_t i = 0; i < roster->count; i++){
        if (roster->students[i].grade == desired_grade)
            grade.students[grade.count++] = 
            roster->students[i];
    }
    return grade;
}