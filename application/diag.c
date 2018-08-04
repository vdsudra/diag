//#include "common_func.c"
#include "liberty_diag.h"
int flag = 1;

void signalHandlerDiag(int sig_num){
    if(sig_num == SIGINT){
        printf("Ctr + c Recived..\n");
        if(1 == perform_abort()){
            printf("Exiting diag app..\n");
            exit(0);
        }
        printf("Exiting Handler\n");
    }     
}

int main(int argc, char *argv[]){
    int testNo = 0;
    char ch = 0;
    int ret = -1;
    struct app_data diag_data;
    memset(&diag_data, 0x00, sizeof(struct app_data));

    signal(SIGINT, signalHandlerDiag);
    //ret = diag_init(&diag_data);
    //system("clear");
    do{
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
		    }
	}
    }while(flag);
}
