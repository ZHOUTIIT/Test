#include "ADT_class_interface.h"
#include <iostream>
using namespace std;
class intsetimp : public intset {
private:
  int set;

public:
  intsetimp();
  void insert(int v);
  int get_value();
  void remove(int v);
  bool query(int v);
  int size();
};
intsetimp::intsetimp() : set(0) {}
void intsetimp::remove(int v) {}
bool intsetimp::query(int v) { return true; }
int intsetimp::size() { return 1; }
void intsetimp::insert(int v) { set = v; }
int intsetimp::get_value() { return set; }
intset *getintset() {
  static intsetimp impl;
  return &impl;
}
