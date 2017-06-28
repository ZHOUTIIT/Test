package class

type qnode struct {
	value int
	next  *qnode
}

//Queue queue
type Queue struct {
	first *qnode
	last  *qnode
}

//Enqueue enqueue a node
func (q *Queue) Enqueue(v int) {
	var n qnode
	n.value = v
	if q.first == nil {
		q.first = &n
		q.last = &n
	} else {
		q.last.next = &n
		n.next = nil
		q.last = &n
	}
}

//Dequeue dequeue a node
func (q *Queue) Dequeue() int {
	if q.first == nil {
		panic("empty queue")
	}
	v := q.first
	defer func() {
		v = nil
	}()
	if q.first == q.last {
		q.first = nil
		q.last = nil
	} else {
		q.first = q.first.next
	}
	return v.value
}
