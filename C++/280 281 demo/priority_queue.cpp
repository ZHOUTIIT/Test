// constructing priority queues
#include <iostream>       // std::cout
#include <queue>          // std::priority_queue
#include <vector>         // std::vector
#include <functional>
using namespace std;

int main(int argc, char const *argv[]) {
  priority_queue<int> pq;
  pq.push(1);
  pq.push(4);
  pq.push(3);
  pq.push(2);
  pq.push(7);
  pq.push(6);
  pq.push(5);
  cout<<pq.top();
  return 0;
}
