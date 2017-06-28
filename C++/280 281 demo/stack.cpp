#include <iostream>
using namespace std;
struct node {
  node *next;
  node *prev;
  int v;
};
class Stack {
private:
  node *first;
  node *last;
  void removeAll();

public:
  Stack();
  ~Stack();
  int size();
  bool isEmpty();
  void push(node *np);
  void pop();
  node *top();
};

Stack::Stack() : first(NULL), last(NULL) {}
void Stack::removeAll() {
  while (first) {
    pop();
  }
}
int Stack::size() {
  int count = 0;
  node *current = first;
  while (current) {
    count++;
    current = current->next;
  }
  return count;
}
bool Stack::isEmpty() { return size() == 0; }
void Stack::push(node *np) {
  np->next = NULL;
  if (isEmpty()) {
    first = last = np;
    np->prev = NULL;
  } else {
    last->next = np;
    np->prev = last;
    last = np;
  }
}
void Stack::pop() {
  node *victim = last;
  int result;
  if (isEmpty()) {
    throw "List is empty";
  }
  last = victim->prev;
  if (victim != first) {
    last->next = NULL;
  }
  delete victim;


}
node *Stack::top() { return last; }
Stack::~Stack() { removeAll(); }

int main(int argc, char const *argv[]) {
  Stack *s = new Stack;
  node *np0 = new node;
  np0->v = 20;
  np0->prev = NULL;
  np0->next = NULL;
  node *np1 = new node;
  np1->v = 25;
  np1->prev = NULL;
  np1->next = NULL;
  s->push(np0);
  s->push(np1);
  cout << s->top()->v;
  return 0;
}
