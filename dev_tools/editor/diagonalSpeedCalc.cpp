#include <cstdio>
#include <cmath>

int main()
{
    unsigned char intPart = 0;
    unsigned char fraction = 0;
    printf("Enter integer part:\n");
    scanf("%u", &intPart);
    printf("Enter fraction in 1/256 units:\n");
    scanf("%u", &fraction);

    float speed = (1.f / 256.f) * fraction + intPart;

    float diagonalSpeed = sqrt(speed * speed / 2);
    float diagonalFrac = diagonalSpeed - (int)diagonalSpeed;
    unsigned char diagonalFraction = ceil(diagonalFrac / (1.f / 256.f));
    printf("diagonal speed: %f\n", diagonalSpeed);
    printf("in bytes: %u %u\n", (unsigned)diagonalSpeed, diagonalFraction);
}
