#include <stdio.h>
#include <math.h>

union{
    unsigned char byteVal[4];
    float floatVal;
    long longVal;
}val;

float give_my_mantissa(int mantissa) {
    float float_part = 0.0;
    int bit = 0;
    for (int i=0; i<23; i++) {
        bit = (mantissa >> i) & 1;
        float_part += bit / pow(2, 23 - i);
    }
    printf("float_part = %f\n", float_part);
    return float_part;
}

void main() {
    int sign;
    int exp;
    int s;
    int mant;
    float tot;
    for (int i=0; i<10; i++) {
        // val.floatVal = 5.2;
        val.floatVal = 0.2*i;
        printf("\n%.2f = 0x%02x\t0x%02x\t0x%02x\t0x%02x\n", val.floatVal, val.byteVal[0], val.byteVal[1], val.byteVal[2], val.byteVal[3]);
        sign = (val.byteVal[3] >> 7);
        exp = (((val.byteVal[3] & 127) << 1) - 127) + ((val.byteVal[2] & 128) >> 7); // 127 = 01111111
        //NO - KO ! exp = (val.byteVal[3] & 127) + ((val.byteVal[2] & 128) >> 7); // 127 = 01111111
        mant = val.byteVal[0] + (val.byteVal[1] << 8) + ((val.byteVal[2] & 127) << 16);

        s = pow(-1.0, sign);
        //NO - KO ! tot = s * (1+give_my_mantissa(mant)) * pow(2, (exp<<1)-128);
        tot = s * (1+give_my_mantissa(mant)) * pow(2, exp);
        printf("%.2f ==> sign=%d , exp=%d , mant=%d ==> tot = %f\n", val.floatVal, s, exp, mant, tot);
    }
}
