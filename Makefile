build:

install: install-${DEB_HOST_ARCH}

install-linux-amd64:
	mkdir -p ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc
	cp -RL arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf/* ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/

	cp config/compiler.txt ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/compiler.txt
	chmod -R 0755 ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/bin/*
	chmod -R 0755 ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/arm-linux-gnueabihf/bin/*

install-linux-i386:
	mkdir -p ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc
	cp -RL arm-bcm2708/gcc-linaro-arm-linux-gnueabihf-raspbian/* ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/

	cp config/compiler.txt ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/compiler.txt
	chmod -R 0755 ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/bin/*
	chmod -R 0755 ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/arm-linux-gnueabihf/bin/*

install-windows-i386:
	mkdir -p ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc
	cp -RL arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf-win32/* ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/

	cp config/compiler.txt ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/compiler.txt
	chmod -R 0755 ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/bin/*
	chmod -R 0755 ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/arm-linux-gnueabihf/bin/*

install-windows-amd64:
	mkdir -p ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc
	cp -RL arm-bcm2708/arm-rpi-4.9.3-linux-gnueabihf-win32/* ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/

	cp config/compiler.txt ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/compiler.txt
	chmod -R 0755 ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/bin/*
	chmod -R 0755 ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/arm-linux-gnueabihf/bin/*

install-darwin-amd64:
	mkdir -p ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc
	cp -RL arm-bcm2708/arm-none-linux-gnueabi-darwin/* ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/

	cp config/compiler.txt ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/compiler.txt
	chmod -R 0755 ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/bin/*
	chmod -R 0755 ${DESTDIR}/compilers/arm-linux-gnueabihf-gcc/arm-none-linux-gnueabi/bin/*


packages:
	upkg-buildpackage -B -alinux-amd64 -ematt@majenko.co.uk
	upkg-buildpackage -B -alinux-i386 -ematt@majenko.co.uk
	upkg-buildpackage -B -awindows-i386 -ematt@majenko.co.uk
	upkg-buildpackage -B -awindows-amd64 -ematt@majenko.co.uk
	upkg-buildpackage -B -adarwin-amd64 -ematt@majenko.co.uk
