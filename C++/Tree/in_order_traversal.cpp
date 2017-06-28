#include <iostream>
using namespace std;

class BinaryTree {
private:
  struct node {
    int v;
    node *left;
    node *right;
  } node *root;

public:
  bool tree_isEmpty(tree_t tree);
  // EFFECTS: returns true if tree is empty, false otherwise
  tree_t tree_make();
  // EFFECTS: creates an empty tree.
  tree_t tree_make(int elt, tree_t left, tree_t right);
  // EFFECTS: creates a new tree, with elt as it's element, left as // its left
  // subtree, and right as its right subtree
  int tree_elt(tree_t tree);
  // REQUIRES: tree is not empty
  // EFFECTS: returns the element at the top of tree.
  tree_t tree_left(tree_t tree);
  // REQUIRES: tree is not empty
  // EFFECTS: returns the left subtree of tree
  tree_t tree_right(tree_t tree);
  // REQUIRES: tree is not empty
  // EFFECTS: returns the right subtree of tree
  void tree_print(tree_t tree);
  // MODIFIES: cout
  // EFFECTS: prints tree to cout.
  // Note: this uses a non-intuitive, but easy-to-print // format.2
  BinaryTree();
  virtual ~B inaryTree();
};
