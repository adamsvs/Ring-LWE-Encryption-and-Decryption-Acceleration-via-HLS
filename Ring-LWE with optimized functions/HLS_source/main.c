#include "lwe.h"
//#include "luts.h"
#include "stdlib.h"
#include "global.h"
#include <assert.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#define logm  7 // log2(M)-1

void fwd_inv_NTT_test(){//fwd and inv NTT test for 256 and 512 points
	int j,res,i;
	uint16_t large1[M];
	uint16_t large2[M];
	uint16_t large20[M];
	res=1;
	res = 1;
	for (i=0; (i<100) && (res==1); i++)
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
				large1[j]=rand()%12289;
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
}
int main()
{
	fwd_inv_NTT_test();

	return 0;
}
