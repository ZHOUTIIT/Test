#include <iostream>
using namespace std;

void swap(int *a, int i, int j) {
  for (int b = i; b > j; b--) {
    *(a + b) = *(a + b - 1);
  }
}

void insertion_sort(int *a, int size) {
  for (int i = 1; i < size; i++) {
    for (int j = 0; j < i; j++) {
      if (*(a + i) < *(a + j)) {
        int tem = *(a + i);
        swap(a, i, j);
        *(a + j) = tem;
        break;
      }
    }
  }
}

int main(int argc, char const *argv[]) {
  int a[10] = {23, 4, 3523, 546234, 1, 56456, 25, 43, 123, 213};
  insertion_sort(a, sizeof(a) / 4);
  for (int i = 0; i < 10; i++) {
    cout << a[i] << " ";
  }
  cout << endl;
  return 0;
}
