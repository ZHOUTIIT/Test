#include <iostream>
#include <string>
using namespace std;

string spin(string a, int s, int n) {
  int i;
  string b(s,' ');
  for (int i = 0; i < s; i++) {
    b[(i + n) % s] = a[i];
  }
  cout<<b<<endl;
  return b;
}

bool cyclic(string a, string b, int sa, int sb) {
  if (sa != sb) {
    return false;
  }
  if (sa == 0) {
    return true;
  }
  int i;
  for (i = 1; i < sa; i++) {
    if (spin(a, sa, i) == b) {
      return true;
    }
  }
  return false;
}

int main(int argc, char const *argv[]) {
  string a = "application";
  string b = "icationappl";
  if (cyclic(a, b, a.size(), b.size())) {
    cout << "yes" << endl;
  } else {
    cout << "no" << endl;
  }
  return 0;
}
