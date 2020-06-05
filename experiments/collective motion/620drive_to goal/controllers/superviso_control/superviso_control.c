/*
 * File:          (tailor version) position and position initialization
 * Date:
 * Description: using supervisor functions
 * Author:
 * Modifications:
 */
#include <webots/robot.h>
#include <webots/supervisor.h>
#include <webots/distance_sensor.h>
#include <webots/motor.h>
#include <stdio.h>
#include <math.h>
#include <stdlib.h>     /* srand, rand */
 //#include <ctime>

 // time in [ms] of a simulation step
#define TIME_STEP 64
#define MAX_SPEED 6.28
#define PI 3.14159265358979323846
static double sin_distance[8] = { 0.276, 0.707, 1, 0.5, -0.5, -1, -0.707, -0.276 };
static double cos_distance[8] = { 0.961, 0.707, 0, -0.866, -0.866, 0, 0.707, 0.961 };
// entry point of the controller
int main(int argc, char** argv) {
	// initialize the Webots API
	wb_robot_init();

	// internal variables
	int i;
	long int time_print = 0;
	long int time_number = 0;
	double ps_values[8];
	double real_distance_to_goal;
	double real_angle_to_goal;
	double speed_controller_for_goal = 4; //1.5/450
	double angle_controller = 1; //1/
	WbDeviceTag ps[8];
	char ps_names[8][4] = {
	  "ps0", "ps1", "ps2", "ps3",
	  "ps4", "ps5", "ps6", "ps7"
	};

	// initialize devices
	for (i = 0; i < 8; i++) {
		ps[i] = wb_robot_get_device(ps_names[i]);
		wb_distance_sensor_enable(ps[i], TIME_STEP);
	}

	WbDeviceTag left_motor = wb_robot_get_device("left wheel motor");
	WbDeviceTag right_motor = wb_robot_get_device("right wheel motor");
	wb_motor_set_position(left_motor, INFINITY);
	wb_motor_set_position(right_motor, INFINITY);
	wb_motor_set_velocity(left_motor, 0.0);
	wb_motor_set_velocity(right_motor, 0.0);

	//get handle to robot's translation field
	WbNodeRef robot_node = wb_supervisor_node_get_self();
	WbFieldRef trans_field = wb_supervisor_node_get_field(robot_node, "translation");
	WbFieldRef trans_angle = wb_supervisor_node_get_field(robot_node, "rotation");

	// initialize speed
	double left_speed = 0.5 * MAX_SPEED;
	double right_speed = 0.5 * MAX_SPEED;
	double distance_to_goal_x = 0;
	double distance_to_goal_y = 0;
	double set_x = -0.5;
	double set_y = 0.5;

	// feedback loop: step simulation until an exit event is received
	while (wb_robot_step(TIME_STEP) != -1) {

		//Tracking the Position of Robots: ID x y theta
		const double* trans = wb_supervisor_field_get_sf_vec3f(trans_field);
		const double* orient = wb_supervisor_field_get_sf_rotation(trans_angle);
		//printf("local: ");
		//printf("%g    %g", trans[0], trans[2]);
		//printf("    ");
		//printf("%g", orient[3]);

		distance_to_goal_x = trans[0] - set_x;
		distance_to_goal_y = trans[2] - set_y;

		real_distance_to_goal = sqrt(pow(distance_to_goal_x, 2) + pow(distance_to_goal_y, 2)); //distance(x_distance, y_distance);
		real_angle_to_goal = atan2(distance_to_goal_x, distance_to_goal_y);
		printf("  dianstance: %f", real_distance_to_goal);
		printf("   ");
		printf("%f", real_angle_to_goal);
		printf("   ");

		if (real_distance_to_goal > 0.1) {
			//speed set
			double v_goal = speed_controller_for_goal * real_distance_to_goal;	// positive // 0.5 * MAX_SPEED +
			left_speed = v_goal;
			right_speed = v_goal;

			//position set
			double position_set_angle = real_angle_to_goal;	//(-3.14,3.14)  change to pi
			const double INITIAL_ROT[4] = { 0, 1, 0, position_set_angle };
			wb_supervisor_field_set_sf_rotation(trans_angle, INITIAL_ROT);

			printf("    ");
			printf("velocity: %f     %f", left_speed, right_speed);
			printf("   ");
			distance_to_goal_x = trans[0] - set_x;
			distance_to_goal_y = trans[2] - set_y;

			
		}
		else {
			left_speed = 0;
			right_speed = 0;
		}

		wb_motor_set_velocity(left_motor, left_speed);
		wb_motor_set_velocity(right_motor, right_speed);
	}
	wb_robot_step(32);
	wb_robot_cleanup();

	return 0;
}