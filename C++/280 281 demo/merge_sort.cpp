#include <iostream>
using namespace std;

void swap(int *a, int i, int j) {
  int tem = *(a + i);
  *(a + i) = *(a + j);
  *(a + j) = tem;
}

void merge(int *a, int left, int mid, int right) {
  // cout<<"merge(int *a, int "<<left<<", int "<<mid<<", int "<<right<<")"<<endl;
  if (right - left == 1) {
    // cout <<"right-left=1"<<"\n"<< "a[left]=" << *(a + left) << " "
        //  << "a[right]=" << *(a + right) << endl;
    if (*(a + left) > *(a + right)) {
      swap(a, left, right);
    }
    return;
  }

  int list[right - left + 1];
  int left_index = 0;
  int right_index = 0;
  for (int i = 0; i <= right - left; i++) {
    if (left + left_index > mid) {
      // cout << "left" << endl;
      for (int i = 0; i < mid + 1 + right_index; i++) {
        *(a + left + i) = list[i];
        // cout << "a[" << left + i << "]=" << list[i] << endl;
      }
      return;
    }
    if (mid + 1 + right_index > right) {
      // cout << "right" << endl;
      for (int i = left + left_index; i <= mid; i++) {
        list[i + right - mid-left] = *(a + i);
        // cout << "a[" << i + right - mid << "]=" << *(a + i) << endl;
      }
      // for (int i = 0; i <= right - mid + left + left_index; i++) {
      //   *(a + left + i) = list[i];
      // }
      for (int i = 0; i <= right - left; i++) {
        *(a + left + i) = list[i];
      }
      return;
    }
    if (*(a + left + left_index) < *(a + mid + 1 + right_index)) {
      list[i] = *(a + left + left_index);
      left_index++;
    } else {
      list[i] = *(a + mid + 1 + right_index);
      right_index++;
    }
  }
  for (int i = 0; i <= right - left; i++) {
    *(a + left + i) = list[i];
  }
}

void merge_sort(int *a, int left, int right) {
  if (left >= right)
    return;
  int mid = (left + right) / 2;
  merge_sort(a, left, mid);
  merge_sort(a, mid + 1, right);
  merge(a, left, mid, right);
}

int main(int argc, char const *argv[]) {
  int a[10] = {23, 4, 3523, 546234, 1, 56456, 25, 43, 123, 213};
  int size = sizeof(a) / 4;
  merge_sort(a, 0, sizeof(a) / 4 - 1);
  for (int i = 0; i < size; i++) {
    cout << a[i] << " ";
  }
  cout << endl;
  return 0;
}
