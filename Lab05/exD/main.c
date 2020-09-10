 // main.c
// ENCM 369 Winter 2020 Lab 5 Exercises D and E

// A NOTE ABOUT THE QueryPerformanceCounter FUNCTION:
//
// QueryPerformanceCounter is service available on Microsoft Windows
// 10 and other recent version of Windows.  It can be used by programs
// built to run on Cygwin64.
//
// The exact details of how the function works are a bit messy, but
// essentially it puts a 64-bit integer value into a LARGE_INTEGER
// object.  This 64-bit integer can be thought of as the value of a
// hardware counter that is increased at very short time intervals as
// a processor runs.  The time measurement is not in nanoseconds or
// microseconds, but in time units that may depend on the processor
// hardware and the operating system version.  The function
// QueryPerformanceFrequency can be used to obtain the number of counts
// per second for a specific MS Windows system.

#include <Windows.h>
#include <stdio.h>
#include "functions.h"

#define ARRAY_SIZE (int) 1.5e7 // 15 million

int x[ARRAY_SIZE];

int main(void)
{
  int i;
  long long int sum;
  double counts_per_sec, start, stop;
  LARGE_INTEGER counter_info;

  // Put some values into the array for addition.
  for (i = 0; i < ARRAY_SIZE; i++)
    x[i] = 10 * (i + 1);

  // Get performance counter value into start.
  QueryPerformanceCounter(&counter_info);
  start = counter_info.QuadPart;

  sum = index_version(x, ARRAY_SIZE);

  QueryPerformanceCounter(&counter_info);
  stop = counter_info.QuadPart;

  // Find out how many counts per second there are for the performance
  // counter.
  QueryPerformanceFrequency(&counter_info);
  counts_per_sec = counter_info.QuadPart;

  printf("microseconds spent in index_version: %.2f\n",
	 1e6 * (stop - start) / counts_per_sec);

  // Printing the sum prevents an optimizing compiler from eliminating
  // all the work done in the call to index_version.
  printf("The sum from index_version was %lld.\n", sum);

  // Repeat the above work with pointer_version in place of index_version.
  QueryPerformanceCounter(&counter_info);
  start = counter_info.QuadPart;

  sum = pointer_version(x, ARRAY_SIZE);

  QueryPerformanceCounter(&counter_info);
  stop = counter_info.QuadPart;

  QueryPerformanceFrequency(&counter_info);
  counts_per_sec = counter_info.QuadPart;

  printf("microseconds spent in pointer_version: %.2f\n",
	 1e6 * (stop - start) / counts_per_sec);
  printf("The sum from pointer_version was %lld.\n", sum);

  return 0;
}
