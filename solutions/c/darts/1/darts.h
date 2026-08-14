#ifndef DARTS_H
#define DARTS_H

typedef struct{
    float x;
    float y;
}coordinate_t;

float radius(coordinate_t l);
int score(coordinate_t landing_position);

#endif
