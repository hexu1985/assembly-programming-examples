#include <stdio.h>
#include <sys/sysinfo.h>

int main() {
    struct sysinfo info;
    if (sysinfo(&info) != 0)
        perror("sysinfo error");

    printf("uptime %ld\nfreeram %ld\nmem_unit %d\n", info.uptime, info.freeram, info.mem_unit);
}
