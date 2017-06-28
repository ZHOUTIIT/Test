#include <iostream>
using namespace std;

bool is_palindrome(string s){
  int size = s.length();
  //go through and check
  for (int i = 0; i <= size-i; i++){
    if (s[i] != s[size-1-i]){
      return false;
    }
  }
  return true;
}

int main() {
  string s;
  while (true) {
    /* code */
    cin >> s;
    if (is_palindrome(s)) {
      /* code */
      std::cout << "yes, it's a palindrome" << '\n';
    } else {
      std::cout << "no, it's not a palindrome" << '\n';
      /* code */
    }
  }


  return 0;
}
