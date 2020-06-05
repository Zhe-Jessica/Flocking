/*
 * File:          set position and set position
 * Date:
 * Description: using supervisor functions
 * Author:
 * Modifications:
 */
#include <webots/robot.h>
#include <webots/supervisor.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>     /* srand, rand */

#define TIME_STEP 32

int main() {
	wb_robot_init();

	
	

	//get handle to robot's translation field
	//WbNodeRef robot_node = wb_supervisor_node_get_from_def("puck");

	WbNodeRef robot_node = wb_supervisor_node_get_self();
	WbFieldRef trans_field = wb_supervisor_node_get_field(robot_node, "translation");
	WbFieldRef trans_angle = wb_supervisor_node_get_field(robot_node, "rotation");
	
	
	//try to use name to distinguish robot
	//WbFieldRef name = wb_supervisor_node_get_field(robot_node, "name");
	//const char* def = wb_supervisor_node_get_def(robot_node);
	const char* name = wb_robot_get_name();;
	//const char* name = wb_supervisor_node_get_type_name(robot_node);
	//int robot_id = wb_supervisor_node_get_id(robot_node);
	//const char* name = wb_supervisor_node_get_base_type_name(robot_node);
	//printf("%s\n", def);
	int name_number = atoi(name);

	//int remainder_number(int number){
	//	remainder = (number - 1) % 3;
	//	return remainder;
	//}
	int quotient_number;
	int remainder_number;
	quotient_number = (name_number - 1) % 3;
	remainder_number = (name_number + 2) / 3;

	double length = 0.09;	//length of square for each robot
	double position_set_x = length * quotient_number + (length * (double)rand() / (double)RAND_MAX);	//(0,length)
	//double position_set_y = length * remainder_number + (length * (double)rand() / (double)RAND_MAX);
	//double position_set_angle = 6.28 * (double)rand() / (double)RAND_MAX - 3.14;	//(-3.14,3.14)  change to pi
	double position_set_y =  0.09 * (double)rand() / (double)RAND_MAX;
	double position_set_angle = 6.28 * (double)rand() / (double)RAND_MAX - 3.14;	//(-3.14,3.14)  change to pi
	//printf("%f\n", remainder_number);
	//int a;
	//int i;
	//for (i = 1; i < 13; i++) {
	//	double random = (double)rand() / (double)RAND_MAX;
	//	printf("%f\n", random);
	//}
	//
	//printf("%s\n", name);
	

	//reset the robot
	const double INITIAL_TRANS[3] = { position_set_x, 0, position_set_y };
	const double INITIAL_ROT[4] = { 0, 1, 0, position_set_angle };
	wb_supervisor_field_set_sf_vec3f(trans_field, INITIAL_TRANS);
	wb_supervisor_field_set_sf_rotation(trans_angle, INITIAL_ROT);
	wb_supervisor_simulation_reset_physics();

	//check setting positions
	printf("ID:%s", name);
	printf("    ");
	printf("position set: %f", position_set_x);
	printf("    ");
	printf("%f", position_set_y);
	printf("    ");
	printf("%f", position_set_angle);

	//Tracking the Position of Robots
	const double* trans = wb_supervisor_field_get_sf_vec3f(trans_field);
	const double* orient = wb_supervisor_field_get_sf_rotation(trans_angle);
	printf("    ");
	printf("MY_ROBOT is at position: %g %g", trans[0], trans[2]);
	printf("    ");
	printf("orientation: %g\n", orient[4]);
	wb_robot_step(32);
	wb_robot_cleanup();

	return 0;
}