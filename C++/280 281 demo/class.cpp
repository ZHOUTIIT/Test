#include <iostream>
using namespace std;

class intset {
private:
protected:
  int set;
  int num;

public:
  void set_value(int n);
  int get_value();
  void insert(int n);
  bool query(int n);
  int size() const;
  intset();
};
intset::intset() : num(0) {}
void intset::set_value(int n){set = n;}
int intset::get_value(){return set;}
void intset::insert(int n) {}
bool intset::query(int n) { return true; }
int intset::size() const { return num; }

class maxset : public intset {
public:
  int max();
};

int main(int argc, char const *argv[]) {
  maxset max;
  max.set_value(4);
  intset in = max;
  cout<<in.get_value();
  return 0;
}
