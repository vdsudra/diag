#include "liberty_diag.h"

int  do_led_test(){
    int file;
    char filename[PATHSIZE] = {0};
    unsigned int size;
    char buf[5] = {0};
    int res,ch ;
    unsigned char  data_read, data, reg;
    while(1){
	printf("1. Off\n");
	printf("2. On\n");
	printf("3. Blink\n");
	printf("4. Main Menu\n");
	scanf("%d", &ch);
	flush();
	if(ch < 0 || ch > 3){
	    printf("Invalid Choice.\n");
	    continue;
	}
	else if(ch == 1){
	    run_script("led_off.sh");
	}
	else if(ch == 2){
	    run_script("led_on.sh");
	}
	else if(ch == 3){
	    run_script("led_blink.sh");
	}
	else if(ch == 4){
	    break;
	}
	printf("Enter 1 to continue | other to Main Menu.\n");
	scanf("%d", &ch);
	flush();
	if(ch == 1)
	    continue;
	else
	    break;
    }
    return 0;
    /*
       sprintf(filename,"%s-%d", LED_I2C_BUS_PATH, LED_I2C_BUS_NUM);
       printf("Device File: %s\n",filename);
       printf("Device Address(I2C): 0x%x\n",LED_I2C_DEV_ADD);
       if ((file = open(filename,O_RDWR)) < 0){
       printf("LED opening fail. %s %d\n",  __func__, __LINE__ );
       return -1;
       }
       if( ioctl(file,I2C_SLAVE,,LED_I2C_DEV_ADD) < 0){
       printf("LED ioctl fail. %s %d\n",  __func__, __LINE__ );
       return -1;
       }
       */
}
