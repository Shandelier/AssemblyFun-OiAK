#include <stdio.h>
#include <time.h>

extern long long my_rtdsc();
int size = 512;
unsigned long long timeBegin, timeEnd, timeDiff;


int mulMatrix()
{
        int s=0;
        int matrixA[size][size];
        int matrixB[size][size];
        for(int i = 0; i < size; i++) {
                for(int j = 0; j < size; j++)
                {
                                timeBegin = my_rtdsc();
                                s = matrixA[i][j] * matrixB[i][j];
                                timeEnd = my_rtdsc();
                                timeDiff = timeEnd - timeBegin;
                                printf("1 %llu\n", timeDiff);
                }
        }
}

int mulMatrixT()
{
        int s=0;
        int matrixA[size][size];
        int matrixB[size][size];
        for(int i = 0; i < size; i++) {
                for(int j = 0; j < size; j++)
                {
                                timeBegin = my_rtdsc();
                                s = matrixA[i][j] * matrixB[j][i];
                                timeEnd = my_rtdsc();
                                timeDiff = timeEnd - timeBegin;
                                printf("2 %llu\n", timeDiff);
                }
        }

}


int main() {
        mulMatrix();
        mulMatrixT();

        return 0;
}
