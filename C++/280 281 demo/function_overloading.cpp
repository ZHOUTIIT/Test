#include <iostream>
using namespace std;

int average(int a, int b) { return (a + b) / 2; }

double average(double a, double b) { return (a + b) / 2; }

int average(int a, int b, int c) { return (a + b + c) / 3; }

int main(int argc, char const *argv[]) {
  cout<<average(1.1,2.2);
  return 0;
}
