
all:
	nim c -o:planarity.exe src/planarity.nim

test:
	nim c -r src/geometry2d_test.nim
	nim c -r src/level_generator_test.nim
