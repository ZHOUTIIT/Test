#include "ADT_class_interface.h"
#include "ADT_class_interface_imp.cpp"
#include <iostream>
using namespace std;

int main(int argc, char const *argv[]) {
  intset *set1 = getintset();
  set1->insert(2);
  cout << set1->get_value();
}
