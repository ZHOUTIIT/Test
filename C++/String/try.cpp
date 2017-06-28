#include <iostream>
using namespace std;

int set() {
  static int apple = 1;
  apple++;
  return apple;
}

int main(int argc, char const *argv[]) {
  int apple;
  for (int i = 0; i < 5; i++) {
    apple = set();
  }
  cout << apple;
  return 0;
}
