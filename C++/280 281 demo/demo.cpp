// you can use includes, for example:
// #include <algorithm>

// you can write to stdout for debugging purposes, e.g.
// cout << "this is a debug message" << endl;
#include<vector>
#include<iostream>
using namespace std;


int solution(vector<int> &A) {
    int i;
    long int sum = 0;
    long int current_sum = 0;
    int n = A.size();
    if (n==0){
        return -1;
    }
    for (i=0;i<n;i++){
        sum += A[i];
    }
    if (sum == A[0]){
        return 0;
    }
    for (i=0;i<n-1;i++){
        current_sum += A[i];
        if (current_sum == sum - current_sum - A[i+1]){
            return i+1;
        }
    }
    return -1;
}
