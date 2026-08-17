#include "robot_simulator.h"

robot_status_t robot_create(robot_direction_t direction, int x, int y){
    return (robot_status_t) {direction, {x, y}};
}

void advance(robot_status_t *robot){
    switch(robot->direction){
        case DIRECTION_NORTH:
            robot->position.y++;
            break;
        case DIRECTION_EAST:
            robot->position.x++;
            break;
        case DIRECTION_SOUTH:
            robot->position.y--;
            break;
        case DIRECTION_WEST:
            robot->position.x--;
            break;
    }
}

void robot_move(robot_status_t *robot, const char *commands){
    for (size_t i = 0; i < strlen(commands); i++){
        switch (commands[i]){
            case 'R':
                robot->direction = (robot->direction + 1)%4;
                break;
            case 'L':
                robot->direction = (robot->direction - 1)%4;
                break;
            case 'A':
                advance(robot);
                break;
        }
    }
}