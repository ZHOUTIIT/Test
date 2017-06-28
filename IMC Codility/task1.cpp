// you can use includes, for example:
// #include <algorithm>

// you can write to stdout for debugging purposes, e.g.
// cout << "this is a debug message" << endl;
#include <iostream>
#include <string>
using namespace std;

bool stringvalid(string S, int left, int right) {
  int i;
  for (i = left; i <= right; i++) {
    if ((int)S[i] >= 65 && (int)S[i] <= 90) {
      return true;
    }
  }
  return false;
}

void swap(int *a, int i) {
  int tem = *(a + i);
  *(a + i) = *(a + i + 1);
  *(a + i + 1) = tem;
}

void bubble_sort(int *a, int size) {
  for (int i = size - 2; i >= 0; i--) {
    for (int j = 0; j <= i; j++) {
      if (*(a + j) > *(a + j + 1)) {
        swap(a, j);
      }
    }
  }
}

int solution(string &S) {
  int size = S.size();
  int i;
  if (size==0){
      return -1;
  }
  int *index0 = new int[0];
  int *sub = new int[0];
  int num0 = 0;
  int subnum = 0;
  for (i = 0; i < size; i++) {
    if ((int)S[i] == 48) {
      index0[num0] = i;
      num0++;
    }
  }
  cout << num0;
  cout << index0[0];
  if (num0 == 0) {
    if (stringvalid(S, 0, size - 1)) {
      return size;
    } else {
      return -1;
    }
  }
  for (int j = 0; j < num0; j++) {
    if (j == 0 && index0[0] != 0) {
      if (stringvalid(S, 0, index0[j] - 1)) {
        sub[subnum] = index0[0];
        subnum++;
      }
    }
    if (j == 0 && index0[0] == 0) {
      continue;
    }
    if (stringvalid(S, index0[j - 1] + 1, index0[j] - 1)) {
      sub[subnum] = index0[j] - index0[j - 1] - 1;
      subnum++;
    }
    if (j == num0 - 1) {
      if (stringvalid(S, index0[j] + 1, size - 1)) {
        sub[subnum] = size - 1 - index0[num0 - 1];
        subnum++;
      }
    }
  }
  if (subnum == 0) {
    return -1;
  }
  bubble_sort(sub, subnum);
  return sub[subnum - 1];
}
