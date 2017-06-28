package class

import "fmt"

type tnode struct {
	value               int
	left, right, parent *tnode
}

//BST binary search tree
type BST struct {
	root *tnode
}

//Add node in a bst
func (bst *BST) Add(v int) {
	bst.root = bst.root.insert(v, nil)
}

//Remove node in a bst
func (bst *BST) Remove(v int) {
	bst.root.remove(bst.search(v))
}

//Search node with value v
func (bst *BST) search(v int) *tnode {
	return bst.root.search(v)
}

//PrintBST print bst
func (bst *BST) PrintBST() {
	if bst.root != nil {
		fmt.Println(bst.root.value)
	} else {
		fmt.Println(" ")
	}
	if bst.root.left != nil {
		fmt.Print(bst.root.left.value, " ")
	} else {
		fmt.Print(" ")
	}
	if bst.root.right != nil {
		fmt.Println(bst.root.right.value)
	} else {
		fmt.Println(" ")
	}
	if bst.root.left.left != nil {
		fmt.Print(bst.root.left.left.value, " ")
	} else {
		fmt.Print(" ")
	}
	if bst.root.left.right != nil {
		fmt.Print(bst.root.left.right.value, " ")
	} else {
		fmt.Print(" ")
	}
	if bst.root.right.left != nil {
		fmt.Println(bst.root.right.left.value, " ")
	} else {
		fmt.Println(" ")
	}

}

func (root *tnode) insert(v int, parent *tnode) *tnode {
	if root == nil {
		return &tnode{value: v, parent: parent}
	} else if v > root.value {
		root.right = root.right.insert(v, root)
	} else {
		root.left = root.left.insert(v, root)
	}
	return root
}

func (root *tnode) remove(node *tnode) {
	if node.left == nil && node.right == nil {
		if node.parent.left == node {
			node.parent.left = nil
		} else {
			node.parent.right = nil
		}
	} else if node.left == nil {
		node.right.parent = node.parent
		if node.parent.right == node {
			node.parent.right = node.right
		} else {
			node.parent.left = node.right
		}
	} else if node.right == nil {
		node.left.parent = node.parent
		if node.parent.right == node {
			node.parent.right = node.left
		} else {
			node.parent.left = node.left
		}
	} else {
		replace := findmax(node.left)
		replace.parent.right = nil
		replace.left = node.left
		replace.right = node.right
		replace.parent = node.parent
		if node.parent != nil {
			if node.parent.left == node {
				node.parent.left = replace
			} else {
				node.parent.right = replace
			}
		}
	}
}
func (root *tnode) search(v int) *tnode {
	if v > root.value {
		return root.right.search(v)
	} else if v < root.value {
		return root.left.search(v)
	}
	return root
}

func findmax(root *tnode) *tnode {
	if root.right == nil {
		return root
	}
	return findmax(root.right)
}
