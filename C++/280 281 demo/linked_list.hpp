#ifndef LINKED_LIST_H
#define LINKED_LIST_H value
#include <iostream>

class IntList {
  struct node {
    node *next;
    node *prev;
    int value;
  };
  node *first;
  node *last;
  void copyList(node *list);

public:
  bool isEmpty();
  void insertLast(int v);
  void insertFirst(int v);
  int removeFirst();
  int removeLast();
  void removeAll();
  IntList();
  ~IntList();
  IntList(const IntList &l); // copy ctor ~IntList(); // dtor
  // assignment
  IntList &operator=(const IntList &l);
};

bool IntList::isEmpty() { return !first; }

void IntList::insertLast(int v) {
  node *np = new node;
  np->value = v;
  np->next = NULL;
  if (isEmpty()) {
    first = last = np;
    np->prev = NULL;
  } else {
    last->next = np;
    np->prev = last;
    last = np;
  }
  // node np;
  // np.value = v;
  // np.next = NULL;
  // if (isEmpty()) {
  //   first = last = &np;
  //   np.prev = NULL;
  // } else {
  //   last->next = &np;
  //   np.prev = last;
  //   last = &np;
  // }
}

void IntList::insertFirst(int v) {
  node *np = new node;
  np->value = v;
  np->prev = NULL;
  if (isEmpty()) {
    first = last = np;
    np->next = NULL;
  } else {
    np->next = first;
    first->prev = np;
    first = np;
  }
}

int IntList::removeFirst() {
  node *victim = first;
  int result;
  if (isEmpty()) {
    throw "List is empty";
  }
  first = victim->next;
  if (victim != last) {
    first->prev = NULL;
  }

  // std::cout<<"execute"<<"\n";
  result = victim->value;
  delete victim;
  return result;
}

int IntList::removeLast() {
  node *victim = last;
  int result;
  if (isEmpty()) {
    throw "List is empty";
  }
  last = victim->prev;
  if (victim != first) {
    last->next = NULL;
  }
  result = victim->value;
  delete victim;
  return result;
}

IntList::IntList() : first(0) {}

void IntList::removeAll() {
  while (!isEmpty()) {
    removeLast();
  }
}

IntList::~IntList() { removeAll(); }

void IntList::copyList(node *list) {
  if (!list)
    return; // Base case
  copyList(list->next);
  insertLast(list->value);
}

IntList::IntList(const IntList &l) : first(0) { copyList(l.first); }

IntList &IntList::operator=(const IntList &l) {
  if (this != &l) {
    removeAll();
    copyList(l.first);
  }
  return *this;
}

#endif
