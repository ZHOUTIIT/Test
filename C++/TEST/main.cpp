#include "func.cpp"
#include <iostream>
using namespace std;

int main(int argc, char const *argv[]) {
  // double *a = get();
  double *a = new double[1];
  a[0] = 0.2;
  a[1] = 1.1;
  a[2] = 2.1;
  cout << *a << *(a + 1) << *(a + 2) << endl;
  int *b = new int[0];
  b[0] = 222;
  b[1] = 321;
  b[2] = 145;
  cout << b[0] << b[1] << b[2] << endl;

  delete[] a;
  delete[] b;
  // double a[3] = {1.2, 2.2, 3.2};
  // cout << a[0] << a[1] << a[2] << endl;
  return 0;
}
