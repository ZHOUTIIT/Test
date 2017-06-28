package class

const (
	//Tablesize tablesize
	Tablesize = 33
)

type hashentry struct {
	key   int
	value int
}

//HashMap hash map
type HashMap struct {
	table [Tablesize]*hashentry
}

//Get get value frotable hashtable
func (h *HashMap) Get(key int) int {
	hash := key % Tablesize
	for h.table[hash] != nil && (*h.table[hash]).key != key {
		hash = (hash + 1) % Tablesize
	}
	if h.table[hash] == nil {
		return -1
	}
	return (*h.table[hash]).value
}

//Put put value in hashtable
func (h *HashMap) Put(key int, value int) {
	hash := key % Tablesize
	for h.table[hash] != nil && (*h.table[hash]).key != key {
		hash = (hash + 1) % Tablesize
	}
	if h.table[hash] != nil {
		h.table[hash] = nil
	}
	entry := hashentry{key, value}
	h.table[hash] = &entry
}
