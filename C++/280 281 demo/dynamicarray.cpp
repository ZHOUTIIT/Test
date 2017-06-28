#include <iostream>
using namespace std;
int main(int argc, char const *argv[]) {
  int *ia = new int[5];
  ia[0] = 1;
  ia[1] = 2;
  ia[2] = 3;
  ia[3] = 4;
  ia[4] = 5;
  ia[5] = 6;
  ia[6] = 7;
  ia[7] = 8;
  ia[8] = 9;
  ia[9] = 0;
  cout<<ia[0]<<ia[1]<<ia[2]<<ia[3]<<ia[4]<<ia[5]<<ia[6]<<ia[7]<<ia[8]<<ia[9]<<'\n';
  delete [] ia;
  return 0;
}
