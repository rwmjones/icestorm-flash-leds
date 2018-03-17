# Build the bitstring.
all: flash.bin

%.bin: %.asc
	icepack $< $@

flash.asc: flash.blif
	arachne-pnr -d 8k -o $@ -p flash.pcf flash.blif

flash.blif: flash.v
	yosys -p 'synth_ice40 -top flash -blif $@' $<

# Program the bitstring to the board.
# NB for this to work as a non-root user, you must add this
# udev rule in file /etc/udev/rules.d/53-lattice-ftdi.rules
# ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6010", MODE="0660", GROUP="plugdev", TAG+="uaccess"
prog: flash.bin
	iceprog $<

clean:
	rm -f *.bin *.asc *.blif
	rm -f *~
