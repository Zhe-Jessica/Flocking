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


	//get handle to robot's translation field
	WbNodeRef robot_node = wb_supervisor_node_get_self();
	WbFieldRef trans_field = wb_supervisor_node_get_field(robot_node, "translation");
	WbFieldRef trans_angle = wb_supervisor_node_get_field(robot_node, "rotation");

	//set position
	const double INITIAL_TRANS[3] = { 0, 0, 0 };
	const double INITIAL_ROT[4] = { 0, 1, 0, 0 };
	wb_supervisor_field_set_sf_vec3f(trans_field, INITIAL_TRANS);
	wb_supervisor_field_set_sf_rotation(trans_angle, INITIAL_ROT);

	// feedback loop: step simulation until an exit event is received
	while (time_number < 1000) {

	}
	wb_robot_step(32);
	wb_robot_cleanup();
	return 0;
}