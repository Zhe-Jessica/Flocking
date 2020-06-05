#include <webots/robot.h>
#include <webots/supervisor.h>
#include <stdio.h>

int main() {
	wb_robot_init();

	// do this once only
	WbNodeRef robot_node = wb_supervisor_node_get_from_def("MY_ROBOT");
	WbFieldRef trans_field = wb_supervisor_node_get_field(robot_node, "translation");
	WbFieldRef trans_angle = wb_supervisor_node_get_field(robot_node, "rotation");

	while (wb_robot_step(32) != -1) {
		// this is done repeatedly
		const double* trans = wb_supervisor_field_get_sf_vec3f(trans_field);
		const double* orient = wb_supervisor_field_get_sf_rotation(trans_angle);
		printf("%g    %g", trans[0], trans[2]);
		printf("    ");
		printf("%g\n", orient[3]);
	}

	wb_robot_cleanup();

	return 0;
}