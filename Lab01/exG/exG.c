// exG.c
// ENCM 369 Winter 2020 Lab 1 Exercise G

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define MAX_ABS_F (5.0e-10)
#define POLY_DEGREE 4

double polyval(const double *a, int n, double x);
// Return a[0] + a[1] * x + ... + a[n] * pow(x, n).

int main(void)
{
    double f[ ] = {12.0, 8.0, -7.5, -2.0, 1.0};
    double dfdx[POLY_DEGREE];

    double guess;
    int max_updates;
    int update_count;
    int scan_count;
    int i;
    int close_enough = 0;

    double current_x, current_f, current_dfdx;

    printf("This program demonstrates use of Newton's Method to find\n"
           "approximate roots of the polynomial\nf(x) = ");
    printf("%.2f", f[0]);

	i = 1;
	start_loop0:
	    if (!(i <= POLY_DEGREE)) goto end_loop0;
	        if (!(f[i] >= 0)) goto else_line0;
	            printf(" + %.2f*pow(x,%d)", f[i], i);
				i++;
				goto start_loop0;
	        else_line0:
	            printf(" - %.2f*pow(x,%d)", -f[i], i);
				i++;
				goto start_loop0;
	end_loop0:


    printf("\nPlease enter a guess at a root, and a maximum number of\n"
           "updates to do, separated by a space.\n");
    scan_count = scanf("%lf%d", &guess, &max_updates);


    if (!(scan_count != 2)) goto end0;
        printf("Sorry, I couldn't understand the input.\n");
        exit(1);
		end0:


    if (!(max_updates < 0)) goto end1;
        printf("Sorry, a negative limit on updates does not make sense.\n");
        exit(1);
    	end1:

    printf("Running with initial guess %f.\n", guess);
	i = POLY_DEGREE-1;

	start_loop1:
	    if (!(i >= 0)) goto end_loop1;
	        dfdx[i] = (i + 1) * f[i + 1];   // Calculus!
			i--;
			goto start_loop1;
	end_loop1:

	current_x = guess;
	update_count = 0;

	start_loop2:
        current_f = polyval(f, POLY_DEGREE, current_x);
        printf("%d update(s) done; x is %.15f; f(x) is %.15e\n",
               update_count, current_x, current_f);
        close_enough = fabs(current_f) < MAX_ABS_F;
        if (close_enough) goto end_loop2;
		if (update_count == max_updates) goto end_loop2;
        current_dfdx = polyval(dfdx, POLY_DEGREE - 1, current_x);
        current_x -= current_f / current_dfdx;
        update_count++;
		goto start_loop2;
	end_loop2:


    if (!(close_enough)) goto else_line1;
        printf("Stopped with approximate solution of %.12f.\n",
               current_x);
			   goto end2;
    else_line1:
        printf("%d updates performed, |f(x)| still >= %g.\n",
               update_count, MAX_ABS_F);
	end2:
		 ;

    return 0;
}

double polyval(const double *a, int n, double x)
{
    double result = a[n];
    int i = n - 1;

	start_loop3:
	    if (!(i >= 0)) goto end_loop3;
			result = x * result + a[i];
			i--;
			goto start_loop3;
	end_loop3:
				;
    return result;
}
