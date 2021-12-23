#include <stddef.h>

typedef struct ZigString {
  const unsigned char *ptr;
  size_t len;
} ZigString;

ZigString gimme(void *out, ZigString in) { return in; }

ZigString gimme_no_ptr(ZigString in) { return in; }