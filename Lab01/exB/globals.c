// globals.c
// ENCM 369 Winter 2020 Lab 1 Exercise B

void copy(int *dest, const int *src, int n)
{
  int k;
  for (k = 0; k < n; k++)
    dest[k] = src[k];

  // point one (which is AFTER the loop is finished)

  return;
}

void reverse(int *dest, const int *src, int n)
{
  const int *guard;
  guard = dest + n;
  src += n;
  while (dest != guard) {
    src--;
    *dest = *src;

    // point two

    dest++;
  }

  // point three
}

int aa[] = {1001, 2002, 3003, 4004};
int bb[5];
int cc = 5000;

void update_cc(int z)
{
  cc += z;
}

int main(void)
{
  int dd[6];
  int ee[5] = {22, 33, 44, 55, 66}; 

  update_cc(200);
  copy(dd, aa, 4);
  update_cc(30);
  reverse(bb, ee, 5);
  update_cc(4);
  return 0;
}
