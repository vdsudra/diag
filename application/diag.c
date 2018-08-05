//#include "common_func.c"
#include "liberty_diag.h"
int flag = 1;
#define LOG 1
/*
if(LOG)
DIAGLOG("");
*/
void signalHandlerDiag(int sig_num){
    if(sig_num == SIGINT){
	printf("Ctr + c Recived..\n");
	if(LOG)
	    DIAGLOG("Ctr + c Recived..");
	if(1 == perform_abort()){
	    printf("Exiting Diagnostic Application.....\n");
	    if(LOG)
		DIAGLOG("Exiting diag app..");
	    exit(0);
	}
	printf("Exiting Handler\n");
	if(LOG)
	    DIAGLOG("Exiting HandlerExiting Handler");
    }     
}

int main(int argc, char *argv[]){
    int testNo = 0;
    char ch = 0;
    int ret = -1;
    if(LOG)
	DIAGLOG("Diagnostic Application Start.....");

    signal(SIGINT, signalHandlerDiag);
    do{
	system("clear");
	testNo = displayMenu();
	switch(testNo){
	    case 1: {
			ret = USB_test();
			if(ret == DIAG_SUCC){
			    printf("Test Success.\n");
			}
			else{
			    printf(" Test Fail.: %s %d\n",  __func__, __LINE__);
			}
			sleep(1);
			break;
		    } 
	    case 2: {
			ret = SDIO_test();
			if(ret == DIAG_SUCC){
			    printf("Test Success.\n");
			}
			else{
			    printf(" Test Fail.: %s %d\n",  __func__, __LINE__);
			}
			sleep(1);
			break;
		    }

	    case 3: {
			ret = LED_test();
			if(ret == DIAG_SUCC){
			    printf("Test Success.\n");
			}
			else{
			    printf(" Test Fail.: %s %d\n",  __func__, __LINE__);
			}
			sleep(1);
			break;
		    }
	    case 4: {
			ret = Log_test();
			if(ret == DIAG_SUCC){
			    printf("Test Success.\n");
			}
			else{
			    printf(" Test Fail.: %s %d\n",  __func__, __LINE__);
			}
			sleep(1);
			break;
		    }
	    case 5: {
			ret = Manufacture_test();
			if(ret == DIAG_SUCC){
			    printf("Test Success.\n");
			}
			else{
			    printf(" Test Fail.: %s %d\n",  __func__, __LINE__);
			}
			sleep(1);
			break;
		    }
		    /*
		       case 8: {
		       ret = M_2_test();
		       if(ret == DIAG_SUCC){
		       printf("Test Success.\n");
		       }
		       else{
		       printf(" Test Fail.: %s %d\n",  __func__, __LINE__);
		       }
		       break;
		       }
		     */
	    case 0: { //Exit
			flag = 0;
			break;
		    }
	    default:{
			printf("Invalid Choice\n");
			sleep(1);
		    }
	}
    }while(flag);
    if(LOG)
	DIAGLOG("Exiting diag app..");
	return 0;
}
