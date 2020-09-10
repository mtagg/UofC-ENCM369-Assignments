# 1 "functions.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "functions.c"



# 1 "functions.h" 1






long long int pointer_version(const int *a, int n);

long long int index_version(const int *a, int n);
# 5 "functions.c" 2

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
