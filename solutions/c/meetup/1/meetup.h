#ifndef MEETUP_H
#define MEETUP_H

#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*
typedef enum {
    MONDAY,
    TUESDAY,
    WEDNESDAY,
    THURSDAY,
    FRIDAY,
    SATURDAY,
    SUNDAY
} weekday;
*/

typedef enum {
    JANUARY = 1,
    FEBRUARY,
    MARCH,
    APRIL,
    MAY,
    JUNE,
    JULY,
    AUGUST,
    SEPTEMBER,
    OCTOBER,
    NOVEMBER,
    DECEMBER
} months;

bool leap_year(int year);
int yearAdjust(int day, unsigned int year);
int monthValue(unsigned int month, unsigned int year);
int monthAdjust(int day, unsigned int month, unsigned int year);
int day_code(const char *day_of_week);
int requested_day(const char *week);
int meetup_day_of_month(unsigned int year, unsigned int month, const char *week, const char *day_of_week);

#endif