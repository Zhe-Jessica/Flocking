/*
 * File:          (tailor version) position and position initialization
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
	WbNodeRef robot_node = wb_supervisor_node_get_self();
	WbFieldRef trans_field = wb_supervisor_node_get_field(robot_node, "translation");
	WbFieldRef trans_angle = wb_supervisor_node_get_field(robot_node, "rotation");

	while (wb_robot_step(32) != -1) {
		//Tracking the Position of Robots: ID x y theta
		const double* trans = wb_supervisor_field_get_sf_vec3f(trans_field);
		const double* orient = wb_supervisor_field_get_sf_rotation(trans_angle);

		printf("%g    %g", trans[0], trans[2]);
		printf("    ");
		printf("%g    %g    %g    %g\n", orient[0], orient[1], orient[2], orient[3]);
	}
	wb_robot_step(32);
	wb_robot_cleanup();

	return 0;
}