// functions.c
// ENCM 369 Winter 2020 Lab 5 Exercises D and E

#include "functions.h"

long long int pointer_version(const int *a, int n)
{
  long long int sum = 0;
  const int *p = a, *guard = a + n;
  while (p != guard) {
    sum += *p;
    p++;
  }
  return sum;
}

long long int index_version(const int *a, int n)
{
  long long int sum = 0;
  int i;
  for (i = 0; i < n; i++)
    sum += a[i];
  return sum;
}
