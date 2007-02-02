#ifndef _ENUMS_H_
#define _ENUMS_H_

/* First, a couple enumerated types we want to discover */

typedef enum {
    FOO_0, FOO_1, FOO_2, FOO_3,
    FOO_4, FOO_5, FOO_6, FOO_7,
    FOO_MAX
} foo_e;

typedef enum {
    alpha, beta, gamma, delta, epsilon,
    omega=24
} greek_letters_e;


/* Then some typedefs we want to ignore */

typedef int dont_want_this_one;
typedef char * dont_want_this_one_either;
typedef struct {
   int foo;
   unsigned long bar;
   unsigned char *baz;
} should_also_not_see_this_t;

#endif /* _ENUMS_H_ */
