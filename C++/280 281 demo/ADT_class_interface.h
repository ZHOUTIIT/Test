#ifndef ADT_CLASS_INTERFACE_H
#define ADT_CLASS_INTERFACE_H value
class intsetfull {};
class intset {
public:
  virtual void insert(int v) = 0;
  virtual int get_value() = 0;
  virtual void remove(int v) = 0;
  virtual bool query(int v) = 0;
  virtual int size() = 0;
};
#endif
