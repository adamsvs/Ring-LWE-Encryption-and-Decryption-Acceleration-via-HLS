#include "global.h"
#include "lwe.h"
#include "stdio.h"
#include "lwe_original.h"
#include "xparameters.h"
#include "xtime_l.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xil_exception.h"
#include "stdlib.h"
#define	BTNS_DEVICE_ID XPAR_AXI_GPIO_0_DEVICE_ID
XGpio BTN_LED;
unsigned int * EncDec_core = (unsigned int *)0x43C00000;
unsigned int * on_chip_core = (unsigned int *)0x00000000;
double sw,hw;

int main()
{
	int count=0;
	XTime tStart, tEnd;
	int status;
	int push_buttons_check;
	status=XGpio_Initialize(&BTN_LED,BTNS_DEVICE_ID);
	if(status != XST_SUCCESS) return XST_FAILURE;
	XGpio_SetDataDirection(&BTN_LED,1,0xFF);
	XGpio_SetDataDirection(&BTN_LED,2,0x00);
	while(1){
	push_buttons_check = XGpio_DiscreteRead(&BTN_LED, 1);
	if(push_buttons_check != 0 ){
	XGpio_DiscreteWrite(&BTN_LED,2,0);
	break;
			}
			}
	int i;
	int j;
	int res;
	static uint16_t large_m[M],large_a[M],large_p[M],large_r2[M],large_c1[M],large_c2[M],large1[M],large2[M];
	uint32_t a_0[M/2],a_1[M/2];
	//XTime_GetTime(&tStart);
	/*printf("knuth_yao_smaller_tables2: ");
	res = 1;
	for (i=0; i<0x4FF; i++)
	{
		if ((i%100)==0)
			printf(".");
		srand(i*i);
#ifdef	USE_KNUTH_YAO_ORIGINAL
		knuth_yao_original(a_0,a_1);
#else
		knuth_yao(a_0,a_1);
#endif

		srand(i*i);
		knuth_yao_smaller_tables2(large1);

		if (compare2(a_1,a_0,large1)==0)
		{
			res=0;
			printf("i=%d\n",i);
			break;
		}
	}
	if (res==0)
		printf("BAD!\n");
	else
		printf("OK!\n");



#ifdef USE_FAKE_GET_RAND
	printf("knuth_yao_asm_fake_get_rand:");
	i=0xFFFFF0FF;
	//for (i=0xFFFFF0FF; i<0xffffffff; i++)
	{
		g_fake_rand=i;

		srand(i);
		knuth_yao2(large2);

		printf("i=%d num=%x\n",i,large1[0]>>16);
		return;
	}
#endif

	res = 1;
	for (i=0; i<32767; i++)
	{
		srand(i*i);
#ifdef	USE_KNUTH_YAO_ORIGINAL
		knuth_yao_original(a_0,a_1);
#else
		knuth_yao(a_0,a_1);
#endif

		srand(i*i);
		knuth_yao2(large1);

		if (compare2(a_0,a_1,large1)==0)
		{
			res=0;
			break;
		}
	}
	printf("knuth_yao2: ");
	if (res==0)
		printf("BAD!\n");
	else
		printf("OK!\n");
	int sample_in_table;


	for (i=0; i<327670; i++)
	{
		srand(i*i);
		uint32_t rnd = get_rand();
		uint32_t num1 = knuth_yao_single_number(&rnd,&sample_in_table);

		srand(i*i);
		rnd = get_rand();
		uint32_t num2 = knuth_yao_smaller_tables_single_number(&rnd);

		if (num1!=num2)
		{
			res=0;
			printf("i=%d\n",i);
			break;
		}
	}
	printf("knuth_yao_smaller_tables_single_number: ");
	if (res==0)
		printf("BAD!\n");
	else
		printf("OK!\n");

	res=1;
	res = 1;

	for (i=0; (i<1000) && (res==1); i++)
	{
		srand(i);
		if (i==0)
		{
			//All ones for first test case
			for (j=0; j<M; j++)
			{
				large1[j]=1;
			}
		}
		else
		{
			//Random values for other test cases
			for (j=0; j<M; j++)
			{
				large1[j]=rand()%16;
			}
		}

		for (j=0; j<M; j++)
		{
			large2[j]=large1[j];
		}

		fwd_ntt2(large2);
		rearrange2(large2);
		inv_ntt2(large2);
		rearrange2(large2);


		for (j=0; j<M; j++)
		{
			if (large2[j]!=large1[j])
			{
				res=0;
				break;
			}
		}
	}
	printf("fwd/inv_ntt2: ");
	if (res==0)
		printf("BAD!\n");
	else
		printf("OK!\n");
*/
	res = 0;
	printf("Enc/Dec:\n");
	for(i=0; i<2; i++)
	{
		if ((i%1000)==0)
		{
			//printf(".");
			fflush(stdout);
		}
		srand(i);
		if (i==0)
		{
			for (j=0; j<M; j++)
			{
				if (j<M/2)
				{
					large_m[j]=1;
				}
				else
				{
					large_m[j]=0;
				}
				large_a[j]=1;
				large_p[j]=1;
				large_r2[j]=1;
			}
			bitreverse2(large_m);
		}
		else
		{
			message_gen2(large_m);

			bitreverse2(large_m);

			key_gen2(large_a,large_p,large_r2); //a=large, p=large2, r2=large3
		}



		if(count==0){
			printf("Pure Software implementation of Ring-LWE Encryption/Decryption: \n");
			sleep(2);
			XTime_GetTime(&tStart);
		RLWE_enc2(large_a,large_c1,large_c2,large_m,large_p);
		RLWE_dec2(large_c1,large_c2,large_r2);
		XTime_GetTime(&tEnd);
				printf("Output took %llu clock cycles.\n", 2*(tEnd - tStart));
				printf("Output took %.2f us.\n",1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000));
				sw = 1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000);
		}
		else{
			sleep(1);
			printf("Hardware Accelerated implementation of Ring-LWE Encryption/Decryption: \n");
			sleep(2);
			XTime_GetTime(&tStart);
			//Data transfer PS TO PLS
		for(int ii=0;ii<128;ii++){
			EncDec_core[128+ii] = ((large_a[ii*2+1])<<16) | large_a[ii*2];
									}

								  for(int ii=0;ii<128;ii++){
									  EncDec_core[512+ii] = ((large_m[ii*2+1])<<16) | large_m[ii*2];
								  	  	  		}
								  for(int ii=0;ii<128;ii++){
									  EncDec_core[640+ii] = ((large_p[ii*2+1])<<16) | large_p[ii*2];
								  	  	  	  		}
								  for(int ii=0;ii<128;ii++){
									  EncDec_core[768+ii] = ((large_r2[ii*2+1])<<16) | large_r2[ii*2];
								  				  	  	  	  		}
		EncDec_core[4]=1024;
		// start the core
	    EncDec_core[0] |=0x1;
	    // checks whether it finishes or not
	    while((EncDec_core[0] & 0x2) !=  0x2);
		
		//Data transfer PL to PS when our accelerator is done.
		for(int ii=0;ii<128;ii++){
			large_c1[ii*2] =(uint16_t)on_chip_core[256+ii];
			large_c1[ii*2+1]=(uint16_t)(on_chip_core[256+ii]>>16);

		}
		XTime_GetTime(&tEnd);
				printf("Output took %llu clock cycles.\n", 2*(tEnd - tStart));
				printf("Output took %.2f us.\n",1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000));
		}
		hw = 1.0 * (tEnd - tStart) / (COUNTS_PER_SECOND/1000000);


		//Xil_L1DCacheFlush();
count++;

		for(j=0; j<M; j++)
		{
			if ((large_c1[j]>QBY4) && (large_c1[j]<QBY4_TIMES3))
				large_c1[j] = 1;
			else
				large_c1[j] = 0;
		}

		//Determine if the decryption was correct
		bitreverse2(large_m);
		rearrange_for_final_test(large_c1,large1);
		for (j=0; j<M; j++)
		{
			if (large_m[j]!=large1[j])
			{
				res=1;
				break;
			}
		}
		if (res==1)
			break;

	if (res==1){
		printf("BAD!\n");

	}
	else{
		printf("OK!\n");


	}
	}
	double speedup = sw/hw;
	printf("Achieved Speedup : %.2f \n",speedup);
	XGpio_DiscreteWrite(&BTN_LED,2,15);
	return 0;
}
