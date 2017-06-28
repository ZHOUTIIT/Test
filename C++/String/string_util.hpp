#ifndef _STRING_UTIL_
#define _STRING_UTIL_ value

#include <cctype>
#include <queue>
#include <string>

using namespace std;

struct Key {
  int num;
  char ch;
  bool operator<(const Key &k) const { return num < k.num; }
};

// rearrange stirng s to eliminate adjacent same char
string rearrange(string s) {
  priority_queue<Key> pq;
  int count[26] = {0};
  string str = "";
  Key prev = {-1, '#'};
  for (int i = 0; i < s.length(); i++) {
    count[s[i] - 'a']++;
  }
  for (char c = 'a'; c <= 'z'; c++) {
    if (count[c - 'a']) {
      if (count[c - 'a'] > (s.length() + 1) / 2) {
        return "wrong input";
      }
      struct Key k = {count[c - 'a'], c};
      pq.push(k);
    }
  }
  while (!pq.empty()) {
    Key k_p;
    Key k = pq.top();
    pq.pop();
    bool p = false;
    if (k.ch == prev.ch) {
      k_p = k;
      k = pq.top();
      pq.pop();
      p = true;
    }
    str += k.ch;
    prev = k;
    if (k.num) {
      k.num--;
      pq.push(k);
    }
    if (p) {
      pq.push(k_p);
    }
  }
  return str;
}

// return if the bth bit of string a is uppercase or not
bool ifUpper(string s, int b) { return toupper(s[b]) == s[b]; }

// return the first repeat index of a string s
int firstRepeatIndex(string s) {
  string table(128, '0');
  for (int i = 0; i < s.length(); i++) {
    if (table[s[i]] == '1') {
      return i;
    }
    table[s[i]] = '1';
  }
  return -1;
}

// reverse an array

void reverseArrayHelpSwap(int *a, int first, int second) {
  int temp = *(a + first);
  *(a + first) = *(a + second);
  *(a + second) = temp;
}

void reverseArray(int *a, int size) {
  if (size < 2) {
    return;
  }
  for (int i = 0; i < size / 2; i++) {
    reverseArrayHelpSwap(a, i, size - i - 1);
  }
}

//

#endif
