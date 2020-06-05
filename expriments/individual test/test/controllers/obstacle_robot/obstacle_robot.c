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
	long int lost_count = 0;
	long int time_number = 0;
	double ps_values[8];

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
	double left_speed = 0.5 * MAX_SPEED;
	double right_speed = 0.5 * MAX_SPEED;

	// feedback loop: step simulation until an exit event is received
	while (wb_robot_step(TIME_STEP) != -1) {
		wb_motor_set_velocity(left_motor, left_speed);
		wb_motor_set_velocity(right_motor, right_speed);
		// read sensors outputs
		ps_values[2] = wb_distance_sensor_get_value(ps[2]);
		//printf("%d ", time_print);
		if (ps[2] < 150) {
			//printf("lost\n");
			lost_count += 1;
		}
		time_number += 1;
		time_print = TIME_STEP * time_number;
	}
	//printf("%d\n", lost_count);
	wb_robot_step(32);
	wb_robot_cleanup();
	return 0;
}