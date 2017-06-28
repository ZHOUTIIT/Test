// you can use includes, for example:
// #include <algorithm>

// you can write to stdout for debugging purposes, e.g.
// cout << "this is a debug message" << endl;

#include <iostream>
#include <queue>
#include <vector>
using namespace std;

int solution(vector<int> &A, vector<int> &B, int M, int X, int Y) {
  queue<int*> q;
  int size = A.size();
  int i;
  int index = 0;
  int num_stop = 0;
  vector<int> v_s(M + 1, 0);
  vector<int> v(M + 1, 0);
  int weight = 0;
  if (size ==0){
      return 0;
  }
  while (size != 0) {
    weight = 0;
    for (i = index; i < index+X; i++) {
      if (size == 0){
        break;
      }
      weight += A[i];
      if (weight >= Y) {
        index = i+1;
        break;
      }
      int *a = new int[2];
      *a = A[i];
      *(a+1) = B[i];
      q.push(a);
      v.at(a[1])++;
      size--;
    }
    int floor = 0;
    for (int k = 0; k <= M; k++) {
      if (v[k] != 0) {
        floor++;
      }
    }
    num_stop += floor + 1;
    v=v_s;
  }
    return num_stop;
}
