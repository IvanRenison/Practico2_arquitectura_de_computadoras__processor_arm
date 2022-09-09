ARMGNU ?= aarch64-linux-gnu

AOPS = --warn --fatal-warnings

file = main

all: rom

asm: $(file).list

clean:
	rm -f *.o
	rm -f *.img
	rm -f *.hex
	rm -f *.list
	rm -f *.elf
	rm -f memory_map.txt
	rm -f *_rom

$(file).o: $(file).s
	$(ARMGNU)-as $(AOPS) $(file).s -o $(file).o


$(file).list: memmap $(file).o 
	$(ARMGNU)-ld $(file).o -T memmap -o $(file).elf -M > memory_map.txt
	$(ARMGNU)-objdump -D $(file).elf > $(file).list

rom: asm process.sh
	sh process.sh $(file) > $(file)_rom


