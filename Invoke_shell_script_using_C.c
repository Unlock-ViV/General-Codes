#include<stdio.h>
#include<stdlib.h> 

int main(int argc, char *argv[])
{
  char command[1000];  /* Array to hold the length of command */
  sprintf(command, "%s %s %s", "sh /path/to/shell/script/shell.sh", argv[1], argv[2]); /* shell script and the command-line parameters need to be passed */ 
  system(command); /* To execute shell/any linux command */
}
