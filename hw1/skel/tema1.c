#include <unistd.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_CIFRE 1000000
static int write_stdout(const char *token, int length)
{
	int rc;
	int bytes_written = 0;

	do {
		rc = write(1, token + bytes_written, length - bytes_written);
		if (rc < 0)
			return rc;

		bytes_written += rc;
	} while (bytes_written < length);

	return bytes_written;
}
//mutam pointerul de la inceput ,respectiv sfarsit si i interschimbam
// char *s = stringul de inversat 
static void order(char *s,int len){
	int st = 0, end = len -1;
	while(st < end){
		char c = s[st];
		s[st] = s[end];
		s[end] = c;
		st++;
		end--;
	}
}
//return digits if succsessfully addded int to string
// 0 otherwise 
static int intToString(int no,char *str,int base){
	int sign = 1;
	int i = strlen(str);
	char *result;
	int digit = 0;
	if(!no){
		str[i++] = '0';
		str[i] = '\0';
		
	}
	else{
		result = malloc(MAX_CIFRE);
		if(!result)
			return 0;
	
		if(no < 0 && base == 10){
			no = (-1)*no;
			sign = 0;
		}
		//pentru baza 10
		//luam fiecare cifra
		while(no){
			int rest = no % base;
			result[digit++] = (rest > 9 )? (rest - 10 ) + 'a' : rest + '0';
			no /= base;
		}
		if(!sign)
			result[digit++] = '-';
		result[digit] = '\0';
		order(result,digit);
		strcat(str,result);
	}
	free(result);
	return digit;
}

static  int uintToString(unsigned int no,char *str,int base){
	int sign = 1;
	int i = strlen(str);
	char *result;
	int digit = 0;
	if(!no){
		str[i++] = '0';
		str[i] = '\0';
	}
	else{
		result = malloc(MAX_CIFRE);
		if(!result)
			return 0;
	
		if(no < 0 && base == 10){
			no = (-1)*no;
			sign = 0;
		}
		//pentru baza 10
		//luam fiecare cifra
		while(no){
			int rest = no % base;
			result[digit++] = (rest > 9 )? (rest - 10 ) + 'a' : rest + '0';
			no /= base;
		}
		if(!sign){
			result[digit++] = '-';
		}
		result[digit] = '\0';
		order(result,digit);
		strcat(str,result);
	}
	free(result);
	return digit;
}

int iocla_printf(const char *format, ...)
{
	va_list args;
	va_start(args,format);//am pus in args stringul de afisat
	char *show = calloc(400000000,sizeof(char));
	if(!show)
		return -1;
	int carac = 0;
	char c = format[0];
	int i = 0;
	
	for( i = 0; i < strlen(format); i++)
	{
		c = format[i];
		if(c != '%')
			show[carac++] = c;
		else
		{
			i++;
			c = format[i];
			if(c == 'd')
			{
				int d = va_arg(args,int);
				//converting decimal to string 
				//then adding to string
				int digits = intToString(d,show,10);
				carac += digits; 
			}
			else if(c == 's')
			{
				char *s = va_arg(args,char*);
				strcat(show,s);
				carac += strlen(s);//se aduna atatea carac cate au fost adaugate la show ca sa nu le suprascriem
			}
			else if(c == '%')
				show[carac++] = '%';
			else if(c == 'c'){
				char ascii = va_arg(args,int) ;
				show[carac++] = ascii;
			}
			else if(c == 'x'){
				int d = va_arg(args,int);
				int digits = intToString(d,show,16);
				carac += digits;
			}
			else if(c == '\\')
			{
				i++;
				c = format[i];
				if(c == 'n')
					printf("da\n");
			}
			else if(c == 'u'){
				int d = va_arg(args, int);
				//converting decimal to string 
				//then adding to string
				unsigned int k = d;
				int digits = uintToString(d,show,10);
				carac += digits; 
			}

		}

	}
	
	write_stdout(show,strlen(show));
	
	va_end(args);
	return carac;
}

int main(int argc, char *argv[])
{
	//trebuie citit din fisier care se afla la
	// ../checker/input/test*
	int a = -130;
	unsigned int b = (unsigned int)a;
	
	printf("%u\n",b);
	iocla_printf("%s%x%u%d\n\t%c","Bob\n",-130,-131,-132);
	//printf("%s%x%u%d\n\t%c","Bob\n",-130,-131,-132);
	
	return 0;
}

