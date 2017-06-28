#include <iostream>
using namespace std;
struct node {
  node *next;
  node *prev;
  int v;
};
class Queue {
private:
  node *first;
  node *last;
  void removeAll();

public:
  Queue();
  ~Queue();
  int size();
  bool isEmpty();
  void enqueue(node *np);
  void dequeue();
  node *rear();
  node *front();
};

Queue::Queue() : first(NULL), last(NULL) {}
void Queue::removeAll() {
  while (first) {
    dequeue();
  }
}
int Queue::size() {
  int count = 0;
  node *current = first;
  while (current) {
    count++;
    current = current->next;
  }
  return count;
}
bool Queue::isEmpty() { return size() == 0; }
void Queue::enqueue(node *np) {
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
void Queue::dequeue() {
  node *victim = first;
  int result;
  if (isEmpty()) {
    throw "List is empty";
  }
  first = victim->next;
  if (victim != last) {
    first->prev = NULL;
  }
  delete victim;
}
node *Queue::rear() { return last; }
node *Queue::front() { return first; }
Queue::~Queue() { removeAll(); }

int main(int argc, char const *argv[]) {
  Queue *q = new Queue;
  node *np0 = new node;
  np0->v = 20;
  np0->prev = NULL;
  np0->next = NULL;
  node *np1 = new node;
  np1->v = 25;
  np1->prev = NULL;
  np1->next = NULL;

  q->enqueue(np0);
  q->enqueue(np1);
  q->dequeue();
  cout<<q->rear()->v;
  return 0;
}
