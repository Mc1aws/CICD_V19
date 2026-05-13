BINARY  = v19
SRC_DIR = src
CC      = g++
CFLAGS  = -Wall -Wextra -std=c++17 -O2

.PHONY: all build run clean

all: build

build: $(BINARY)

$(BINARY): $(SRC_DIR)/main.cpp
	$(CC) $(CFLAGS) $(SRC_DIR)/main.cpp -o $(BINARY)
	@echo "Binary built: ./$(BINARY)"

run: $(BINARY)
	./$(BINARY)

clean:
	rm -f $(BINARY)
