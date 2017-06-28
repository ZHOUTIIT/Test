#include <fstream>
#include <iostream>
#include <sstream>
using namespace std;

int main(int argc, char const *argv[]) {
  // ifstream ifile;
  // ifile.open("input.txt");
  // string a[100];
  // int i = 0;
  // while (ifile) {
  //   ifile >> a[i];
  //   cout << a[i] << endl;
  //   i++;
  // }

  // istringstream istream;
  // string s = "123 420.2";
  // int a;
  // double b;
  // istream.str(s);
  // istream >> a >> b;
  // cout << a << " " << b << endl;

  int foo = 512;
  int bar = 1024;
  string result;
  ostringstream oStream;
  oStream << foo << " " << bar;
  result = oStream.str();
  cout << result << endl;
  return 0;
}
