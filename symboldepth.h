
typedef struct symbol_t symbol;


int add_symbol( char* id, int constant,int initialized, int type);
unsigned int find_symbol(char* id);
void increasedepth();
void decreasedepth();
int exist_symbol_curdepth(char* id);
int init(int maxsize);
int exist_symbol_alldepth(char* id);
void initalize_var(char* id);
int add_temp_var(int type);