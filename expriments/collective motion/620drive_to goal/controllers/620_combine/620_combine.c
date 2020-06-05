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
	double real_distance;
	double real_angle;
	double speed_controller = 0.00375; //1.5/450
	double angle_controller = 0.00556; //1/
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

	//try to use name to distinguish robot
	const char* name = wb_robot_get_name();;
	int name_number = atoi(name);
	int quotient_number;
	int remainder_number;
	quotient_number = (name_number - 1) % 3;
	remainder_number = (name_number + 2) / 3;
	double length = 0.09;	//length of square for each robot

	//set position
	//srand(time(0));
	double position_set_x = length * quotient_number + (length * (double)rand() / (double)RAND_MAX);	//(0,length)
	double position_set_y = length * remainder_number + (length * (double)rand() / (double)RAND_MAX);
	double position_set_angle = 6.28 * (double)rand() / (double)RAND_MAX - 3.14;	//(-3.14,3.14)  change to pi

	//reset the robot
	const double INITIAL_TRANS[3] = { position_set_x, 0, position_set_y };
	const double INITIAL_ROT[4] = { 0, 1, 0, position_set_angle };
	wb_supervisor_field_set_sf_vec3f(trans_field, INITIAL_TRANS);
	wb_supervisor_field_set_sf_rotation(trans_angle, INITIAL_ROT);

	// initialize speed
	double left_speed = 0.5 * MAX_SPEED;
	double right_speed = 0.5 * MAX_SPEED;


	// feedback loop: step simulation until an exit event is received
	while (wb_robot_step(TIME_STEP) != -1) {

		//Tracking the Position of Robots: ID x y theta
		const double* trans = wb_supervisor_field_get_sf_vec3f(trans_field);
		const double* orient = wb_supervisor_field_get_sf_rotation(trans_angle);
		printf("Time:%d", time_print);
		printf("    ");		
		printf("ID:%s", name);
		printf("    ");
		printf("%g    %g", trans[0], trans[2]);
		printf("    ");
		printf("%g", orient[3]);

		// read sensors outputs
		double x_distance = 0;
		double y_distance = 0;
		for (i = 0; i < 8; i++) {
			ps_values[i] = wb_distance_sensor_get_value(ps[i]);
			x_distance += sin_distance[i] * ps_values[i];	//calculate total x distance, right positive
			y_distance += cos_distance[i] * ps_values[i];
			//printf("%f", ps_values[i]);
			//printf("   ");
		}
		real_distance = sqrt(pow(x_distance, 2) + pow(y_distance, 2)); //distance(x_distance, y_distance);
		real_angle = atan2(x_distance, y_distance) * 180 / PI;
		//printf("%f", real_distance);
		//printf("   ");
		//printf("%f", real_angle);
		//printf("   ");

		// initialize speed
		double left_speed = 0.5 * MAX_SPEED;
		double right_speed = 0.5 * MAX_SPEED;

		if ((real_distance > 150 && real_distance < 300) || (real_distance > 700)) {
			// controller
			double v_goal = 0.5 * MAX_SPEED + speed_controller * (500 - real_distance);	// positive // 0.5 * MAX_SPEED +
			double angle_goal = angle_controller * (real_angle);	// noise is big

			/*left_speed = 487.8049* v_goal - 1.7317 * angle_goal;
			right_speed = 487.8049 * v_goal + 1.7317 * angle_goal;*/
			left_speed = v_goal + angle_goal;
			right_speed = v_goal - angle_goal;

			printf("    ");
			printf("%f", v_goal);
			printf("   ");
			printf("%f\n", angle_goal);
		}
		else {
			printf("    ");
			printf("lost\n");
		}

		// write actuators inputs
		wb_motor_set_velocity(left_motor, left_speed);
		wb_motor_set_velocity(right_motor, right_speed);
		time_number += 1;
		time_print = TIME_STEP * time_number;

	}
	wb_robot_step(32);
	wb_robot_cleanup();

	return 0;
}