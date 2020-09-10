// ex12A.c
// ENCM 369 Winter 2020 Lab 12 Exercise A

#include <stdio.h>

int func1(int a, int b, int c, int d);

unsigned int func2(unsigned int a, unsigned int b, 
                   unsigned int c, unsigned int d);

int main(void)
{
  int rs;
  unsigned int ru;
 
  rs = func1(3, 15002, 10, 311);
  printf("\nfirst result: %d", rs);
  rs = func1(31111, 31333, -12, 1000000000);
  printf("\nsecond result: %d", rs);
  rs = func1(-6, 4, 2, 5);
  printf("\nthird result: %d", rs);
  rs = func1(-47653, -48767, -11, 100000);
  printf("\nfourth result: %d", rs);

  ru = func2(10, 1001, 301, 123456789);
  printf("\nfifth result: %u", ru);
  ru = func2(0xf0000000, 10000, 460, 0xffffffff);
  printf("\nsixth result: %u", ru);
  ru = func2(11, 10000, 460, 0xffffffff);
  printf("\nseventh result: %u", ru);
  ru = func2(1000000000, 10, 1820000, 12345);
  printf("\neighth result: %u", ru);

  printf("\n");
  return 0;
}

int func1(int a, int b, int c, int d)
{
  return (-121 / c) * ((a * b) % d);
}

unsigned int func2(unsigned int a, unsigned int b, 
                   unsigned int c, unsigned int d)
{
  return d % (999 * b) * c / a;
}
