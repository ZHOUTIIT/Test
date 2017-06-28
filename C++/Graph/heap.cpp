#include <iostream>
using namespace std;

void arraytoheap(int *a, int n) {
  for (int i = n / 2; i > 0; i--) {
    int k = i;
    int v = a[k - 1];
    bool heap = false;
    while (!heap && 2 * k <= n) {
      int j = 2 * k;
      if (j < n) {
        if (a[j - 1] < a[j]) {
          j++;
        }
      }
      if (v >= a[j - 1]) {
        heap = true;
      } else {
        a[k - 1] = a[j - 1];
        k = j;
      }
    }
    a[k - 1] = v;
  }
}

int main(int argc, char const *argv[]) {
  int a[] = {1, 9, 8, 5, 4, 7, 6, 3, 2};
  arraytoheap(a, 9);
  cout << *a << *(a + 1) << *(a + 2) << *(a + 3) << *(a + 4) << *(a + 5);
  return 0;
}
