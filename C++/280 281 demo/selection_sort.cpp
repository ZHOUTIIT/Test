#include <iostream>
using namespace std;

void findsmallest_swap(int *a, int i, int size) {
  int min = *(a + i);
  int index = i;
  for (int j = i + 1; j < size; j++) {
    if (*(a + j) < min) {
      min = *(a + j);
      index = j;
    }
  }
  int tem = *(a + i);
  *(a + i) = min;
  *(a + index) = tem;
}

void selection_sort(int *a, int size) {
  for (int i = 0; i < size - 1; i++) {
    findsmallest_swap(a,i,size);
  }
}

int main(int argc, char const *argv[]) {
  int a[10] = {23, 4, 3523, 546234, 1, 56456, 25, 43, 123, 213};
  selection_sort(a, sizeof(a) / 4);
  for (int i = 0; i < 10; i++) {
    cout << a[i] << " ";
  }
  cout << endl;
}
