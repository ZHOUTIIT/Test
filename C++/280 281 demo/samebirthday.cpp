#include <iostream>
using namespace std;

int main(int argc, char const *argv[]) {
  double result = 1;
  cout << "enter the possibility that two people have the same birthday:"
       << "\n";
  double p;
  cin >> p;
  int i = 364;
  while (result > 1 - p) {
    result = result * (double)i / 365;
    if (i == 0){
      break;
    }
    i--;
  }
  cout << "at least " << 365 - i << " people" << endl;
  return 0;
}
