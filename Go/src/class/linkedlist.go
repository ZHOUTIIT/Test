package class

type llnode struct {
	value int
	prev  *llnode
	next  *llnode
}

//List linked list
type List struct {
	first *llnode
	last  *llnode
}

//Isempty return whether the list is empty
func (l *List) Isempty() bool {
	return l.first == nil
}

//InsertFront insert a llnode at front
func (l *List) InsertFront(v int) {
	if l.Isempty() {
		n := llnode{v, nil, nil}
		l.first = &n
		l.last = &n
	} else {
		n := llnode{v, nil, l.first}
		l.first.prev = &n
		l.first = &n

	}
}

//InsertEnd insert a llnode at end
func (l *List) InsertEnd(v int) {
	if l.Isempty() {
		n := llnode{v, nil, nil}
		l.first = &n
		l.last = &n
	} else {
		n := llnode{v, l.last, nil}
		l.last.next = &n
		l.last = &n
	}
}

//RemoveFront remove the first llnode return v
func (l *List) RemoveFront() int {
	if l.Isempty() {
		panic("empty list")
	}
	victom := l.first
	defer func() {
		victom = nil
	}()
	l.first = l.first.next
	if victom != l.last {
		l.first.prev = nil
	}
	v := victom.value
	return v
}

//RemoveEnd remove the last llnode return v
func (l *List) RemoveEnd() int {
	if l.Isempty() {
		panic("empty list")
	}
	victom := l.last
	defer func() {
		victom = nil
	}()
	l.last = l.last.prev
	if victom != l.first {
		l.last.next = nil
	}
	v := victom.value
	return v
}
