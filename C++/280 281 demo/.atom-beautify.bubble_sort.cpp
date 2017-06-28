#include <iostream>
using namespace std;

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

int main(int argc, char const *argv[]) {
  int a[10] = {23, 4, 3523, 546234, 1, 56456, 25, 43, 123, 213};
  bubble_sort(a, sizeof(a) / 4);
  for (int i = 0; i < 10; i++) {
    cout << a[i] << " ";
  }
  cout << endl;
  return 0;
}
