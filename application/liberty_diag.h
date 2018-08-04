//liberty_diag.h file
#ifndef _liberty_diag_h
#define _liberty_diag_h
/* 
    printf(": %s  %s  %d\n", temp_sensor.dev_path, __func__, __LINE__);
*/
#include <stdio.h>
#include <errno.h>                                                     
#include <stdlib.h>                                                    
#include <string.h>                                                    
#include <unistd.h>                                                    
#include <linux/i2c-dev.h>                                             
#include <linux/i2c.h>                                             
#include <sys/ioctl.h> 
#include <signal.h>
#include <linux/rtc.h>
#include <sys/time.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdio_ext.h>
#include <linux/ioctl.h>
#include <sys/stat.h>
#include <linux/types.h>
#include <linux/spi/spidev.h>
#include <getopt.h>

#define MAXTEST 18
#define MINTEST 1
#define EXITCOND 99
#define BUFF_512 512
#define BUFF_128 128
#define BUFF_56 56
#define PATHSIZE 128
#define MAXUART 32

#define SCRIPT_DIR "./scripts"

/*
 * I2C Temp declarations
 * */

#define TEMP_BUS_PATH "/dev/i2c-"
#define TEMP_BUS_NUM 0
#define TEMP_DEV_ADD 0x48
#define TEMP_DEV_REG 0x00   //2 Byte data(11 Useful)

/*
 * RTC declarations
 * */

#define RTC_BUS_PATH "/dev/rtc0"
/*PCF8563
I2C ADDR = 0x51    
Read = 0xA3
Write = 0xA2
*/


/*
 *EEPROM
 I2C ADDR = 0x54-57
 * */
#define EEPROM_I2C_BUS_PATH "/dev/i2c-" 
#define EEPROM_I2C_BUS_NUM 1
#define EEPROM_I2C_DEV_ADD 0x54
#define EEPROM_TYPE_8BIT_ADDR   1
#define EEPROM_TYPE_16BIT_ADDR  2
#define EEPROM_I2C_SIZE 128

/*
 *LED I2C
 * */

#define LED_I2C_BUS_PATH "/dev/i2c-" 
#define LED_I2C_BUS_NUM 0
#define LED_I2C_DEV_ADD 0x20


typedef unsigned char UCHAR;
typedef unsigned int UINT;
typedef unsigned long int ULINT;


typedef enum __ERRNO{
    DIAG_SUCC = 0,
    DIAG_FAIL = -1
} ERRNO;


// Device info structs
struct i2c_dev_info{
    UCHAR path[PATHSIZE];
    int fd;
    UINT add;
    UINT mode;
};

struct uart_dev_info{
    UCHAR path[PATHSIZE];
    UCHAR no;
    ULINT baud_rate;
};
struct usb_dev_info{
    UCHAR connected;
    UCHAR path[PATHSIZE];
};

struct led_info{
    UCHAR connected;
    UCHAR path[PATHSIZE];
};

// Test structs


struct spi_eeprom_test{
    UCHAR path_sh[PATHSIZE];
};

struct rtc_test{
    UCHAR connected;
    char path_sh[PATHSIZE];
    char dev_path[PATHSIZE];
    int fd;
    struct rtc_time *gettime;
    struct rtc_time *settime;
};

struct i2c_eeprom_test{
    UCHAR connected;
    char path_sh[PATHSIZE];
    char dev_path[PATHSIZE];   // device file i.e. /dev/i2c-N
    int fd; 
    UINT add;   // i2c address
    unsigned char  reg;   // i2c address
    int type;  // eeprom type
    char data[1024];
};

struct temp_test{
    UCHAR connected;
    char path_sh[PATHSIZE];
    char dev_path[PATHSIZE];
    int fd;
    UINT add;
    UINT mode;
    float temperature;
};

struct uart_test{
    UCHAR path_sh[PATHSIZE];
    struct uart_dev_info uart;
};

struct nand_test{
    UCHAR path_sh[PATHSIZE];
};

struct app_data{
    UCHAR test_nos;
    struct temp_test temp_sensor;
    struct rtc_test rtc;
    struct i2c_eeprom_test i2c_eeprom;
    //struct spi_eeprom_test spi_eeprom;
    //struct uart_test uart;
    //struct nand_test nand;
};

void flush();
ERRNO uart_init();
ERRNO Log_test();
ERRNO SPI_test();
ERRNO NAND_test();
ERRNO Temp_test(struct temp_test *temp_sensor);
ERRNO RTC_test();
ERRNO SDIO_test();
ERRNO USB_test();
ERRNO LED_test();
ERRNO ConsoleUART_test();
ERRNO M_2_test();
ERRNO DDR_test();
ERRNO XUART_test();
ERRNO GigPort_test();
ERRNO Abort_test();
ERRNO GPIO_test();
ERRNO Reset_test();
ERRNO Boot_test();
ERRNO Manufacture_test();
int displayMenu();
void signalHandlerDiag(int sig_num);
ERRNO diag_init( struct app_data *diag_data);
/* Temperature */
int init_temp_test(struct temp_test *temp_sensor);
int detect_temp_sensor(struct temp_test *temp_sensor);
int i2c_temperature_read(int file, int location);
int temp_get(struct temp_test *temp_sensor);
/* RTC */
ERRNO init_rtc_test(struct rtc_test *rtc);
ERRNO set_rtc_time(struct rtc_test *rtc);
ERRNO get_rtc_time(struct rtc_test *rtc);
/*I2C EEPROM*/
ERRNO init_i2c_eeprom_test(struct i2c_eeprom_test *);
ERRNO I2C_EEPROM_test(struct i2c_eeprom_test *eeprom);
ERRNO read_i2c_eeprom(struct i2c_eeprom_test *i2c_eeprom);
ERRNO write_i2c_eeprom(struct i2c_eeprom_test *i2c_eeprom);
/* LED */
ERRNO do_led_test();


int perform_abort();
int run_script(char *file_path);

#endif
