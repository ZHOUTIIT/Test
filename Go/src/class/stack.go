package class

var capacity = 5

type snode struct {
	value int
	next  *snode
}

//Stack stack
type Stack struct {
	top *snode
	num int
}

//Push push node in stack
func (s *Stack) Push(v int) {
	var n snode
	n.next = s.top
	n.value = v
	s.top = &n
	s.num++
}

//Pop pop node from stack
func (s *Stack) Pop() int {
	if s.top == nil {
		panic("empty stack")
	}
	v := s.top
	defer func() {
		s.num--
		v = nil
	}()
	s.top = s.top.next
	return v.value
}

//SetofStack set of stack
type SetofStack struct {
	set []Stack
}

//PushSS push node into SetStack
func (s *SetofStack) PushSS(v int) {
	if len(s.set) == 0 {
		var stack Stack
		s.set = append(s.set, stack)
	}
	if s.set[len(s.set)-1].num == capacity {
		var stack Stack
		s.set = append(s.set, stack)
	}
	s.set[len(s.set)-1].Push(v)
}

//PopSS pop node from Setstack
func (s *SetofStack) PopSS() int {
	if len(s.set) == 0 {
		panic("empty SetofStack")
	}
	v := s.set[len(s.set)-1].Pop()
	if s.set[len(s.set)-1].num == 0 {
		s.set = s.set[:len(s.set)-1]
	}
	return v
}
