#include <iostream>
using namespace std;
int fac(int n) {
  if (n < 0) {
    throw "abc";
  }
  return 0;
}
int main(int argc, char const *argv[]) {
  try {
    fac(-1);
  } catch (char const* n) {
    cout << "error: n is " << n;
  }
  return 0;
}
