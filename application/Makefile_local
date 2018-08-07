CC=gcc
CFLAGS=
#CFLAGS=-Wall

diag: diag.c common_func.c
	$(CC) $(CFLAGS) -o diag_app common_func.c  diag.c 
#######	$(CC)  $(CFLAGS) -o diag_app common_func.c  diag.c  i2c_temp.c rtc_dev.c

clean:
	rm -f a.out diag_app
