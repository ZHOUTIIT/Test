#include <iostream>
#include "template.hpp"
using namespace std;

int main(int argc, char const *argv[]) {
  IntList<int> *list = new IntList<int>;
  list->insertLast(5);
  list->insertFirst(7);
  cout << list->removeFirst()<<endl;
  return 0;
}
