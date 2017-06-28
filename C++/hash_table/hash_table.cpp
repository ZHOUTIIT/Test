#include <iostream>
using namespace std;
#ifndef Table_Size
#define Table_Size 33
#endif
class HashEntry {
private:
  int key;
  int value;

public:
  HashEntry(int key, int value) {
    this->key = key;
    this->value = value;
  };
  int getKey() { return key; }
  int getValue() { return value; }
};

class HashMap {
private:
  HashEntry **table;

public:
  HashMap() {
    table = new HashEntry *[Table_Size];
    for (int i = 0; i < Table_Size; i++) {
      table[i] = NULL;
    }
  };
  int get(int key) {
    int hash = key % Table_Size;
    while (table[hash] != NULL && table[hash]->getKey() != key) {
      hash = (key + 1) % Table_Size;
    }
    if (table[hash] == NULL) {
      return -1;
    } else
      return table[hash]->getValue();
  }
  void put(int key, int value) {
    int hash = key % Table_Size;
    while (table[hash] != NULL && table[hash]->getKey() != key) {
      hash = (hash + 1) % Table_Size;
    }
    if (table[hash] != NULL) {
      delete table[hash];
    }
    table[hash] = new HashEntry(key, value);
  }
  ~HashMap() {
    for (int i = 0; i < Table_Size; i++) {
      if (table[i] != NULL) {
        delete table[i];
      }
    }
    delete[] table;
  };
};
int main(int argc, char const *argv[]) {
  HashMap Hash;
  Hash.put(1, 4);
  Hash.put(34, 5);
  cout << Hash.get(34);
  return 0;
}
