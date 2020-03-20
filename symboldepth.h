
typedef struct symbol_t symbol;


int add_symbol( char* id, int constant,int initialized, int type);
unsigned int find_symbol(char* id);
void increasedepth();
void decreasedepth();
