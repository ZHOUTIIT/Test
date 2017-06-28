#include "func.h"
#include <iostream>
using namespace std;

double *get() {
  double *a = new double[3];
  a[0] = 1.0;
  a[1] = 2.0;
  a[2] = 3.0;
  cout << a[0] << a[1] << a[2] << endl;
  return a;
}
