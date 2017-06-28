#include <iostream>
using namespace std;

void print(int *a) {
  for (int k = 0; k < 9; k++) {
    cout << a[k] << " ";
  }
  cout << endl;
}

void swap(int *a, int i, int j) {
  int tem = *(a + i);
  *(a + i) = *(a + j);
  *(a + j) = tem;
}

int partition(int *a, int left, int right) {
  int i = left + 1;
  int j = right;
  while (true) {
    while (*(a + i) < *(a + left)) {
      i++;
    }
    while (*(a + j) > *(a + left)) {
      j--;
    }
    if (i < j) {
      swap(a, i, j);
      i++;
      j--;
    } else {
      swap(a, left, j);
      return j;
    }
  }
}

void quick_sort(int *a, int left, int right) {
  int pivotat; // index of the pivot if(left >= right) return;
  if (left >= right)
    return;
  pivotat = partition(a, left, right);
  quick_sort(a, left, pivotat - 1);
  quick_sort(a, pivotat + 1, right);
}

int main(int argc, char const *argv[]) {
  int a[10] = {23, 4, 3523, 546234, 1, 56456, 25, 43, 123, 213};
  int size = sizeof(a) / 4;
  quick_sort(a, 0, size - 1);
  print(a);
  return 0;
}
