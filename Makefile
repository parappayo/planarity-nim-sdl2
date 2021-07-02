
all:
	nim c -o:planarity.exe src/planarity.nim

test:
	nim c -r src/*test.nim
