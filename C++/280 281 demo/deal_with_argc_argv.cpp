#include <cstdlib>
#include <iostream>
using namespace std;

int main(int argc, char const *argv[]) {
  int sum = 0;
  for (int i = 1; i < argc; i++) {
    sum = sum + atoi(argv[i]);
  }
  std::cout << sum << '\n';
  return 0;
}
