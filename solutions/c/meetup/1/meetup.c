#include "meetup.h"

bool leap_year(int year){
    if ((year%4 == 0 && year%100 != 0) || year%400 == 0) return true;
    else return false;
}

int yearAdjust(int day, unsigned int year){
    int adjustedYear = year - 1900;
    int absAdjustedYear = abs(adjustedYear);
    for (int i = 0; i < absAdjustedYear; i++){
        if (adjustedYear >= 0)
            day += (leap_year(1900 + i)) ? 366 : 365;
        else
            day -= (leap_year(1899 - i)) ? 366 : 365;
        day = (day%7 + 7)%7;
    }
    return day;
}

int monthValue(unsigned int month, unsigned int year){
    int adjustment = 0;
    switch (month) {
        case JANUARY: case MARCH: case MAY: case JULY: case AUGUST: case OCTOBER: case DECEMBER:
            adjustment += 31;
            break;
        case APRIL: case JUNE: case SEPTEMBER: case NOVEMBER:
            adjustment += 30;
            break;
        case FEBRUARY:
            adjustment += (leap_year(year)) ? 29 : 28;
            break;
        default:
            printf("monthvalue error month = %u", month);
            break;
    }
    return adjustment;
}

int monthAdjust(int day, unsigned int month, unsigned int year){
    for (unsigned int i = 1; i < month; i++)
        day += monthValue(i, year);
    day %= 7;
    return day;
}

int day_code(const char *day_of_week){
    if      (strcmp(day_of_week, "Monday") == 0)    return 0;
    else if (strcmp(day_of_week, "Tuesday") == 0)   return 1;
    else if (strcmp(day_of_week, "Wednesday") == 0) return 2;
    else if (strcmp(day_of_week, "Thursday") == 0)  return 3;
    else if (strcmp(day_of_week, "Friday") == 0)    return 4;
    else if (strcmp(day_of_week, "Saturday") == 0)  return 5;
    else if (strcmp(day_of_week, "Sunday") == 0)    return 6;
    return -1;
}

int requested_day(const char *week){
    if      (strcmp(week, "first") == 0)  return 1;
    else if (strcmp(week, "second") == 0) return 2;
    else if (strcmp(week, "third") == 0)  return 3;
    else if (strcmp(week, "fourth") == 0) return 4;
    else if (strcmp(week, "last") == 0)   return 5;
    else if (strcmp(week, "teenth") == 0) return 6;
    return 0;
}

int meetup_day_of_month(unsigned int year, unsigned int month,
                        const char *week, const char *day_of_week){
    int day = 0,   /* 1st Jan 1900 == Monday*/
        date = 1, 
        code = day_code(day_of_week), 
        requested = requested_day(week);
    day = yearAdjust(day, year);
    day = monthAdjust(day, month, year);
    if (1 <= requested && requested <= 4)
        while(true){
            if (requested == 1 && day == code)
                break;
            if (day == code)
                requested--;
            date++;
            day++;
            day %= 7;
        }
    else if (requested == 5){
        int placeholder, monLen = monthValue(month, year);
        while(date <= monLen){
            if (day == code)
                placeholder = date;
            date++;
            day++;
            day %= 7;
        }
        date = placeholder;
    }
    else if (requested == 6)
        while(true){
            if (date > 12 && day == code)
                break;
            date++;
            day++;
            day %= 7;
        }
    else return -1;    
    return date;
}