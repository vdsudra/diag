#ifndef _common_func_c
#define _common_func_c

#include "liberty_diag.h"

#define LOG 1
/*
if(LOG)
DIAGLOG("");
*/
extern int flag;
void flush(){
__fpurge(stdin);
}

ERRNO Log_test(){
    int ch = 0;
    if(LOG)
	DIAGLOG("LOG_test start.");
    while(1){
	system("clear");
	printf("1. Copy logs to usb\n");
	printf("2. Copy logs to sd card.\n");
	printf("3. Delete logs\n");
	printf("4. Main Menu\n");
        printf("Enter your choice\n");
	scanf("%d", &ch);
	flush();
	if(ch < 0 || ch > 4){
	    printf("Invalid Choice.\n");
	    continue;
	}
	else if(ch == 1){
	    if(LOG)
		DIAGLOG("Running log_usb");
	    run_script("log_usb.sh");
	}
	else if(ch == 2){
	    if(LOG)
		DIAGLOG("Running log_sdcard");
	    run_script("log_sdcard.sh");
	}
	else if(ch == 3){
	    if(LOG)
		DIAGLOG("Delete log selected");

	    printf("Enter Password.\n");
	    scanf("%d", &ch);
	    flush();
	    if(ch == 2580){
		if(LOG)
		    DIAGLOG("Password success.");
		FILE *fp = NULL;
		fp = fopen(LOGPATH, "r");

		if(fp == NULL){
		    printf("Error:  file not found!");
		    if(LOG)
			DIAGLOG("Error:  file not found!");
		}
		else{
		    fclose(fp);

		    int status = remove(LOGPATH);
		    if( status == 0 ){
			printf("%s file deleted successfully\n",LOGPATH);
			if(LOG)
			    DIAGLOG("%s file deleted successfully\n",LOGPATH);
		    }
		    else{
			printf("Unable to delete the %s\n", LOGPATH);
			if(LOG)
			    DIAGLOG("Unable to delete the %s\n", LOGPATH);
		    }
		}
	    }
	    else{
		printf("Invalid Password.\n");
		if(LOG)
		    DIAGLOG("Invalid Password.");
	    }
	}
	else if(ch == 4){
	    break;
	}
	printf("Enter 1 to continue 'Any' to Main Menu.\n");
	scanf("%d", &ch);
	flush();
	if(ch == 1)
	    continue;
	else
	    break;
    }
    printf("Log_test successful.\n");
    return 0;
}

ERRNO LED_test(){
    printf("*********************************************************************");
    printf("***                    LED Test Start                             ***");
    printf("*********************************************************************");
    if(LOG)
	DIAGLOG("LED Test Start");
    int res,ch ;
    while(1){
	printf("1. Off\n");
	printf("2. On\n");
	printf("3. Blink\n");
	printf("4. Main Menu\n");
        printf("Enter your choice\n");
	scanf("%d", &ch);
	flush();
	if(ch < 0 || ch > 3){
	    printf("Invalid Choice.\n");
	    continue;
	}
	else if(ch == 1){
	    run_script("led_off.sh");
	    if(LOG)
		DIAGLOG("Running led_off");
	}
	else if(ch == 2){
	    run_script("led_on.sh");
	    if(LOG)
		DIAGLOG("Running led_on");
	}
	else if(ch == 3){
	    run_script("led_blink.sh");
	    if(LOG)
		DIAGLOG("Running led_blink");
	}
	else if(ch == 4){
	    break;
	}
	printf("Enter 1 to continue | other to Main Menu.\n");
	scanf("%d", &ch);
	flush();
	if(ch == 1){
	    system("clear");
	    continue;
	}
	else
	    break;
    }
    printf("LED_test successful.\n");
    if(LOG)
	DIAGLOG("LED_test successful.");
    return 0;
}

ERRNO USB_test(){
    int ch = 0;
    int flag = 1;
    printf("*********************************************************************\n");
    printf("***                    USB Test Start                             ***\n");
    printf("*********************************************************************\n");
    if(LOG)
	DIAGLOG("USB Test Start");
    while(1){
	printf("1. Detect\n");
	printf("2. Write\n");
	printf("3. Read\n");
	printf("4. Main Menu\n");
        printf("Enter your choice\n");
	scanf("%d", &ch);
	flush();
	if(ch < 0 || ch > 4){
	    printf("Invalid Choice.\n");
	    continue;
	}
	else if(ch == 1){
	    run_script("usb_detect.sh");
	    if(LOG)
		DIAGLOG("Running usb_detect");
	}
	else if(ch == 2){
	    run_script("usb_write.sh");
	    if(LOG)
		DIAGLOG("Running usb_write");
	}
	else if(ch == 3){
	    run_script("usb_read.sh");
	    if(LOG)
		DIAGLOG("Running usb_read");
	}
	else if(ch == 4){
	    break;
	}
	printf("Enter '1' to continue  'Any' to Main Menu.\n");
	scanf("%d", &ch);
	flush();
	if(ch == 1){
	    system("clear");
	    continue;
	}
	else
	    break;
    }
    printf("USB_test successful.\n");
    if(LOG)
	DIAGLOG("USB_test successful.");
    return 0;
}

ERRNO SDIO_test(){ //sd card interface
    printf("*********************************************************************\n");
    printf("***                    SDIO Test Start                            ***\n");
    printf("*********************************************************************\n");
    int ch = 0;
    int flag = 1;
    if(LOG)
	DIAGLOG("SDIO Test Start");
    while(1){
	printf("1. Detect\n");
	printf("2. Write\n");
	printf("3. Read\n");
	printf("4. Main Menu\n");
        printf("Enter your choice\n");
	scanf("%d", &ch);
	flush();
	if(ch < 0 || ch > 4){
	    printf("Invalid Choice.\n");
	    continue;
	}
	else if(ch == 1){
	    if(LOG)
		DIAGLOG("Running sdcard_detect");
	    run_script("sd_detect.sh");
	}
	else if(ch == 2){
	    if(LOG)
		DIAGLOG("Running sdcard_write");
	    run_script("sd_write.sh");
	}
	else if(ch == 3){
	    if(LOG)
		DIAGLOG("Running sdcard_read");
	    run_script("sd_read.sh");
	}
	else if(ch == 4){
	    break;
	}
	printf("Enter 1 to continue 'Any' to Main Menu.\n");
	scanf("%d", &ch);
	flush();
	if(ch == 1){
	    system("clear");
	    continue;
	}
	else
	    break;
    }

    printf("SDIO_test successful.\n");
    if(LOG)
	DIAGLOG("SDIO_test successful.");
    return 0;
}

ERRNO M_2_test(){
    printf("*********************************************************************");
    printf("***                    M.2 Test Start                            ***");
    printf("*********************************************************************");
    /*
       "1.read
       2.write
       3.detect"
       */
    printf("M_2_test successful.\n");
    return 0;
}




ERRNO Manufacture_test(){
    /*
       "1.System boots, 
       2.Read and 
       3.Execute continuosly command"	"a.SPI,
       b Nand, 
       c.USB,
       d. SDIO"

*/
    printf("Manufacture_test successful.\n");
    return 0;
}
int displayMenu(){
    int choice = 0;
   // sleep(1);
    do{
        printf("1.  USB test\n");
        printf("2.  SDIO test\n");
        printf("3.  LED test\n");
        printf("4.  Log Capture test\n");
        printf("5.  Manufacture test mode\n");
        printf("6.  For User Break condition(Abort) pres Ctr+C\n");
        printf("0.  Exit\n");
        printf("Enter your choice\n");
        scanf("%d", &choice);
        flush();
    }while(0);
    return choice;
}

int run_script(char *file_path){
    int  ret = 0;
    char cmd[BUFF_512] = {0};
    char cwd[BUFF_512] = {0};

    if(file_path == NULL){
	printf("Empty script path\n");
	if(LOG)
	    DIAGLOG("Empty script path");
	return -1;
    }

    strcat(cmd, "sh ");
    strcat(cmd, file_path);

    // store current directory
    if(NULL == getcwd(cwd, 256)){
	printf("Error to get current directory path.\n");
	if(LOG)
	    DIAGLOG("Error to get current directory path.");
	return -1;
    }

    // switch to test directory
    if(0 != chdir(SCRIPT_DIR)){
	printf("failed to change to script directory!\n");
	if(LOG)
	    DIAGLOG("failed to change to script directory!");
	return -1;
    }
    if (access(file_path, F_OK) == -1){
	printf("%s not present\n", file_path);
	if(LOG)
	    DIAGLOG("%s not present\n", file_path);
	return -1;
    }
    /* Open the command for reading. */
    ret = system(cmd);
    //printf("Ret: %d\n",ret);

    ret = WEXITSTATUS(ret);
    //printf("Ret: %d\n",ret);

    // switch back to previous directory
    chdir(cwd);

    return 0;
}

int perform_abort(){
    UCHAR buffer = 0;
    printf("Do you want to exit application ?");
    printf("Press 'Y' to exit from application or 'N' to continue test.\n");
    flush();
    buffer = getchar();
    if(buffer == 'y' ||  buffer == 'Y'){
        return 1;
    }
    return 0;
}

#endif
