
#ifndef __LOG_H_
#define __LOG_H_

/****************
 * Include Files
 ****************/
#include <sys/vfs.h>
#include <syslog.h>
#include <signal.h>
#include <error.h>
#include <time.h>
#include <string.h>
#include <stdio.h> 
#include <stdlib.h>

#define LOGPATH "./diag_logs"
//#define LOGPATH "/var/tmp/diag_logs"

/*! \def get_curr_date_time
 \brief Get current date-time value from system
 */
#define get_curr_date_time(date_time) \
{ \
    time_t t; \
    time(&t); \
	char *strtime = ctime(&t); \
    strncpy(date_time, strtime, strlen(strtime) - 1); \
}


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
#endif
