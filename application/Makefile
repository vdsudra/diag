all: diag

diag: diag.c common_func.c
	$(CC) $(CFLAGS) $< -o $@

clean: 
	rm -rf diag
	rm -rf *.o
