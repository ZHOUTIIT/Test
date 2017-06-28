#include <iostream>
#include <vector>
using namespace std;
struct grade {
  string name;
  int grade;
};

void addpoint(grade & a) {
  a.grade = 88;
}

int main(int argc, char const *argv[]) {
  grade *a,b;
  a = &b;
  addpoint(*a);

  std::cout << a->grade << '\n';
  return 0;
}
