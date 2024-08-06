#include<stdio.h>
#include<stdint.h>


typedef struct 
{
    uint8_t BootJumpInstruction[3];
    uint8_t OemIdentifier[8];
    uint16_t BytesPerSector;
    uint8_t SectorsPerCluster;
    uint16_t ReservedSectors;
    uint8_t FatCount;
    uint16_t DirEntryCount;
    uint16_t TotalSectors;
    uint8_t MediaDescriptorType;
    uint16_t SectorsPerFat;
    uint16_t SectorsPerTrack;
    uint16_t Heads;
    uint32_t HiddenSectors;
    uint32_t LargeSectorCount;

    // extended boot record
    uint8_t DriveNumber;
    uint8_t _Reserved;
    uint8_t Signature;
    uint32_t VolumeId;          // serial number, value doesn't matter
    uint8_t VolumeLabel[11];    // 11 bytes, padded with spaces
    uint8_t SystemId[8];

    // ... we don't care about code ...

} __attribute__((packed)) BootSector;

typedef uint8_t bool;
#define true 0
#define false 1

bool readBootSector(FILE* disk){
    
    return true;
}
int main(int argc, char* argv[]){
    if (argc < 3){
        printf("Syntax: %s <disk image> <filename>\n",argv[0]);
        return -1;
    }

    FILE* disk = fopen(argv[0], "rb");
    return 0;
}