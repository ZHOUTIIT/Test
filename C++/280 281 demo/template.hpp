#ifndef TEMPLATE_H
#define TEMPLATE_H value
template <class T>
class IntList {
  struct node {
    node *next;
    node *prev;
    T value;
  };
  node *first;
  node *last;
  void copyList(node *list);

public:
  bool isEmpty();
  void insertLast(T v);
  void insertFirst(T v);
  T removeFirst();
  T removeLast();
  void removeAll();
  IntList();
  ~IntList();
  IntList(const IntList &l); // copy ctor ~IntList(); // dtor
  // assignment
  IntList &operator=(const IntList &l);
};
template <class T>
bool IntList<T>::isEmpty() { return !first; }
template <class T>
void IntList<T>::insertLast(T v) {
  node *np = new node;
  np->value = v;
  np->next = NULL;
  if (isEmpty()) {
    first = last = np;
  } else {
    last->next = np;
    np->prev = last;
    last = np;
  }
}
template <class T>
void IntList<T>::insertFirst(T v) {
  node *np = new node;
  np->value = v;
  np->prev = NULL;
  if (isEmpty()) {
    first = last = np;
  } else {
    np->next = first;
    first->prev = np;
    first = np;
  }
}
template <class T>
T IntList<T>::removeFirst() {
  node *victim = first;
  T result;
  if (isEmpty()) {
    throw "List is empty";
  }
  first = victim->next;
  first->prev = NULL;
  result = victim->value;
  delete victim;
  return result;
}
template <class T>
T IntList<T>::removeLast() {
  node *victim = last;
  T result;
  if (isEmpty()) {
    throw "List is empty";
  }
  last = victim->prev;
  last->next = NULL;
  result = victim->value;
  delete victim;
  return result;
}
template <class T>
IntList<T>::IntList() : first(0) {}
template <class T>
void IntList<T>::removeAll() {
  while (!isEmpty()) {
    removeLast();
  }
}
template <class T>
IntList<T>::~IntList() { removeAll(); }
template <class T>
void IntList<T>::copyList(node *list) {
  if (!list)
    return; // Base case
  copyList(list->next);
  insertLast(list->value);
}
template <class T>
IntList<T>::IntList(const IntList &l) : first(0) { copyList(l.first); }
template <class T>
IntList<T> &IntList<T>::operator=(const IntList &l) {
  if (this != &l) {
    removeAll();
    copyList(l.first);
  }
  return *this;
}


#endif
