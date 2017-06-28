#include <iostream>
#include <vector>
using namespace std;
//...
int main(int argc, char const *argv[]) {
  std::vector<char> array;
  char c = 0;
  while (c != 'x') {
    std::cin >> c;
    array.push_back(c);
  }
  cout << array.size();
  return 0;
}
