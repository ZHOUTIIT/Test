#include <iostream>
#include <vector>
using namespace std;
int *get() {
  int *array = new int[0];
  *(array + 0) = 0;
  *(array + 1) = 1;
  *(array + 2) = 2;
  *(array + 3) = 3;
  *(array + 4) = 4;
  *(array + 5) = 5;
  // int array[] = {1,2,3,4,5};

  return array;
}

bool anagram_string(string a, int sa, string b, int sb) {
  if (sa != sb) {
    return false;
  }
  if (sa == 0) {
    return true;
  }
  int i;
  vector<int> v(26, 0);
  vector<int> v_s(26, 0);

  for (i = 0; i < sa; i++) {
    v.at(int(a[i]) - 97)++;
  }
  for (i = 0; i < sb; i++) {
    v.at(int(b[i]) - 97)--;
  }
  if (v == v_s) {
    return true;
  } else {
    return false;
  }
}

bool anagram_array(char a[], int sa, char b[], int sb) {
  if (sa != sb) {
    return false;
  }
  if (sa == 0) {
    return true;
  }
  int i;
  vector<int> v(26, 0);
  vector<int> v_s(26, 0);

  for (i = 0; i < sa; i++) {
    v.at(int(a[i]) - 97)++;
  }
  for (i = 0; i < sb; i++) {
    v.at(int(b[i]) - 97)--;
  }
  if (v == v_s) {
    return true;
  } else {
    return false;
  }
}

int main(int argc, char const *argv[]) {
  string a = "applee";
  string b = "ppeale";
  char c[] = {'a', 'p', 'p', 'l', 'e','d', '\0'};
  char d[] = {'p', 'p', 'a', 'l', 'e', 'd','\0'};
  cout << sizeof(c) / sizeof(char) << endl;
  if (anagram_array(c, sizeof(c)/sizeof(char)-1, d,sizeof(d)/sizeof(char)-1)){
    cout << "yes" << endl;
  }else{
    cout << "no" << endl;
  }
  // int a[] = {1,2,3,4,5};
  // cout << sizeof(a);

  return 0;
}
