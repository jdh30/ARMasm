#include <stdio.h>
#include <stdlib.h>

typedef long long int64;

typedef struct pair pair;

struct pair {
  int len;
  int64 n;
};

int64 foo = 5000000000;

void op(long long n) {
  printf("%d%lld", 123, n);
}

pair make_pair(int len, int64 n) {
  pair p = {len, n};
  return p;
}
/*
int collatzLen(int c, int64 n) {
  if (n==1) return c;
  return collatzLen(c+1, n%2==0 ? n/2 : 3*n+1);
}

int64 loop(int64 i, pair soln) {
  if (i == 1) return soln.n;
  int ilen = collatzLen(1, i);
  return loop(i-1, ilen > soln.len ? make_pair(ilen, i) : soln);
}
*/
int collatzLen(int c, int64 n) {
  while (n != 1) {
    c++;
    n = n%2==0 ? n/2 : 3*n+1;
  }
  return c;
}

int64 loop(int64 i, pair soln) {
  while (i != 1) {
    int ilen = collatzLen(1, i);
    if (ilen > soln.len)
      soln = make_pair(ilen, i);
    i--;
  }
  return soln.n;
}

int main(int argc, char *argv[]) {
  if (argc != 2) {
    printf("Usage: hailstone <n>\n");
    return 1;
  }
  int i = atoi(argv[1]);
  printf("hailstone(%d) = %lld\n", i, loop(i, make_pair(-1, -1)));
  return 0;
}
