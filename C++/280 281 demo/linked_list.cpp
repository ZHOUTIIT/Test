#include "linked_list.hpp"
#include <iostream>
using namespace std;

int main(int argc, char const *argv[]) {
  // IntList *list = new IntList;
  IntList list;
  // list->insertLast(5);
  list.insertLast(5);
  cout << list.removeFirst() << endl;
  return 0;
}
