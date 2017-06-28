#include <iostream>
#include <map>
#include <string>
#include <unordered_set>
using namespace std;

typedef unordered_set<string> stringset;
stringset s;
stringset::hasher fn = s.hash_function();


int main(int argc, char const *argv[]) {
map<string,int> hashtable;
map<string,int>::iterator it;
hashtable["apple"]=fn("apple");
hashtable["banana"]=fn("banana");
hashtable["orange"]=fn("orange");
hashtable["pineapple"]=fn("pineapple");
hashtable["grape"]=fn("grape");
hashtable["melon"]=fn("melon");
hashtable["lemon"]=fn("lemon");
hashtable["watermelon"]=fn("watermelon");
hashtable["peach"]=fn("peach");
hashtable["pear"]=fn("pear");
hashtable["mongo"]=fn("mongo");
hashtable["cherish"]=fn("cherish");
it = hashtable.find("apple");
cout<<hashtable.at("banana");
return 0;
}
