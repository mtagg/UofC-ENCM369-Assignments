// exH.c
// ENCM 369 Winter 2020 Lab 1 Exercise H

#include <stdio.h>

void print_array(const char *str, const int *a, int n);
// Prints the string given by str on stdout, then
// prints a[0], a[1], ..., a[n - 1] on stdout on a single line.

void sort_descending(int *a, int n);
// Sorts a[0], a[1], ..., a[n - 1] from largest to smallest.

int main(void)
{
  int test_array[] = {440, 220, 330, 550, 330, 660, 110, 330, 440};

  print_array("before sorting ...", test_array, 9);
  sort_descending(test_array, 9);
  print_array("after sorting ...", test_array, 9);
  return 0;
}

void print_array(const char *str, const int *a, int n)
{
  int i = 0;
  puts(str);

  	start_loop0:
	  	if (!(i < n)) goto end_loop1;
		    printf("    %d", a[i]);
			i++;
			goto start_loop0;
	end_loop1:
  		printf("\n");
}

void sort_descending(int *a, int n)
{
  // This is an implementation of an algorithm called insertion sort.

	int j = 1, k, v;

	start_outter_loop:

		if (!(j < n)) goto end_outter_loop;
		    v = a[j];
		    k = j;
			start_inner_loop:
			    if (!(k >= 1)) goto end_inner_loop;
				if (!(a[k - 1] < v)) goto end_inner_loop;
			      	a[k] = a[k - 1];
			      	k--;
					goto start_inner_loop;

			end_inner_loop:
		    a[k] = v;
			j++;
			goto start_outter_loop;

	end_outter_loop:
					;
}
