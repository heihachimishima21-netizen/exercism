#include "kindergarten_garden.h"

const student_t students[] = {
    {"Alice",   0},
    {"Bob",     1},
    {"Charlie", 2},
    {"David",   3},
    {"Eve",     4},
    {"Fred",    5},
    {"Ginny",   6},
    {"Harriet", 7},
    {"Ileana",  8},
    {"Joseph",  9},
    {"Kincaid", 10},
    {"Larry",   11}
};

int order(const char *name){
    for (int i = 0; i < 12; i++)
        if (strcmp(students[i].name, name) == 0)
            return students[i].order;
    return -1;
}

plant_t plant(const char initial){
    switch (initial){
            case 'C':
                return CLOVER;
            case 'G':
                return GRASS;
            case 'R':
                return RADISHES;
            case 'V':
                return VIOLETS;
            default:
                return -1;
    }
}

plants_t plants(const char *diagram,
                const char *student){
    plants_t cups;
    int len = 0, cup = 2 * order(student);
    while (diagram[len] != '\n') len++;
    for (int i = 0; i < 4; i++, cup++){
        if (i == 2) cup += len - 1;
        cups.plants[i] = plant(diagram[cup]);
    }
    return cups;
}