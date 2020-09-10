// simple_loops.c
// ENCM 369 Winter 2020 Lab 1 Exercise E

// INSTRUCTIONS:
//   Recode the definition of main in Goto-C
//   Make sure your modified program produces exactly the same
//   output as the original.

#include <stdio.h>

int main(void)
{
  int a[4] = {1200, 3400, 5600, 7800};
  int *p;
  int i;
  p = a;
start_for:
	if (!(p<a+4)) goto end_for;
		printf("%d\n", *p);
		p++;
		goto start_for;
end_for:
		;

  /*
  for (p = a; p < a + 4; p++)
    printf("%d\n", *p);
	*/

  i = 234567;
  /*
  while (i > 1) {
    printf("%d\n", i);
    i /= 16;
	}
	*/
start_while:
	if (!(i>1)) goto end_while;
		printf("%d\n", i);
		i /= 16;
		goto start_while;

end_while:
			;


  return 0;
}
