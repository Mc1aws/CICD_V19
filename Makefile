BINARY      = v19
SRC_DIR     = src
BUILD       = build
PKG         = $(BUILD)/v19-project
BIN_DIR     = $(PKG)/usr/local/bin
DEBIAN_DIR  = $(PKG)/DEBIAN
CONTROL     = DEBIAN/control
CC          = g++
CFLAGS      = -Wall -Wextra -std=c++17 -O2

.PHONY: all check build deb run test clean

all: check build

check:
	@which $(CC) > /dev/null || (echo "g++ not installed. Install build-essential" && exit 1)
	@which dpkg-deb > /dev/null || (echo "dpkg-deb not installed. Install dpkg-dev" && exit 1)
	@echo "All build dependencies are present."

build: $(BINARY)

$(BINARY): $(SRC_DIR)/main.cpp
	$(CC) $(CFLAGS) $(SRC_DIR)/main.cpp -o $(BINARY)
	@echo "Binary built: ./$(BINARY)"

deb: check $(BINARY)
	rm -rf $(BUILD)
	mkdir -p $(BIN_DIR)
	mkdir -p $(DEBIAN_DIR)
	cp $(BINARY) $(BIN_DIR)/
	cp $(CONTROL) $(DEBIAN_DIR)/
	chmod 755 $(DEBIAN_DIR)
	dpkg-deb --build $(PKG)
	@echo "Package created: $(PKG).deb"

run: $(BINARY)
	./$(BINARY)

test: $(BINARY)
	bash cicd/run_tests.sh

clean:
	rm -f $(BINARY)
	rm -rf $(BUILD)
