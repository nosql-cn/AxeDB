
#include <cstdint>
#include <iostream>
#include <string>

#include "my_dbug.h"

using namespace std;

extern struct settings init_settings;

void testC() { DBUG_TRACE; }

void testB() {
  DBUG_TRACE;
  testC();
}
void testA() {
  DBUG_TRACE;
  testB();

  testC();
}

int main(int argc, char** argv) {
  bool retd = debug_thread_init();
  cout << "debug thread init:" << retd << ",argv[1]:" << argv[1] << endl;
  DBUG_SET_INITIAL(argv[1]);
  testA();

  return 0;
}

