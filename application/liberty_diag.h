//liberty_diag.h file
#ifndef _liberty_diag_h
#define _liberty_diag_h
/* 
    printf(":%s  %d\n", __func__, __LINE__);
*/

#include <stdio.h>
#include <errno.h>                                                     
#include <stdlib.h>                                                    
#include <string.h>                                                    
#include <unistd.h>                                                    
#include <signal.h>
#include <stdio_ext.h>
#include <time.h>

#define BUFF_512 512
#define BUFF_128 128
#define BUFF_56 56
#define PATHSIZE 128
#define MAXUART 32

#define SCRIPT_DIR "./scripts"

#define LOGPATH "./diag_logs"
//#define LOGPATH "/var/tmp/diag_logs"

/*
 *Get current date-time value from system
 * */

#define get_curr_date_time(date_time) \
{ \
    time_t t; \
    time(&t); \
    char *strtime = ctime(&t); \
    strncpy(date_time, strtime, strlen(strtime) - 1); \
}

/*
 * Function to save diagnostic log
 * */

#define DIAGLOG(x,arg...) \
{\
    char current_time[32] = {0}; \
    FILE *fp = NULL;\
    get_curr_date_time(current_time); \
    fp =fopen(LOGPATH, "a+");\
    if(NULL != fp)\
    {\
	fprintf(fp,"[%s] : "x"\n", current_time, ##arg);\
	fclose(fp);\
	fp = NULL;\
    }\
}

typedef unsigned char UCHAR;
typedef unsigned int UINT;
typedef unsigned long int ULINT;


typedef enum __ERRNO{
    DIAG_SUCC = 0,
    DIAG_FAIL = -1
} ERRNO;

void flush();
ERRNO Log_test();
ERRNO SDIO_test();
ERRNO USB_test();
ERRNO LED_test();
ERRNO M_2_test();
ERRNO Abort_test();
ERRNO Manufacture_test();
int displayMenu();
void signalHandlerDiag(int sig_num);
int perform_abort();
int run_script(char *file_path);

#endif
