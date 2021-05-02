# recommend to build and link with commonlib statically but shared library is also possible too
# just that we *might* update such functionality in the future.
.PHONY: all static-debug static-release copy-pub-headers-release copy-pub-headers-debug create-output-dirs-release create-output-dirs-debug clean

OUT = libbitkub.a
OUT_DIR = bin
COMPILER = g++
SRC_DIR = src
CXXFLAGS_BASE = -g -std=c++17 -Wall -Wextra -pedantic -I.
SOURCES = $(SRC_DIR)/bitkub_commonlib.o

# We will output object files into src/ directory
OBJS_DEBUG = $(addprefix src/, $(addsuffix -debug.o, $(basename $(notdir $(SOURCES)))))
OBJS_RELEASE = $(addprefix src/, $(addsuffix -release.o, $(basename $(notdir $(SOURCES)))))

# default target
# NOTE: first target is the default target
all: static-debug static-release

static-release: CXXFLAGS_RELEASE = $(CXXFLAGS_BASE) -O2
static-release: create-output-dirs-release $(OUT_DIR)/release/$(OUT)

static-debug: CXXFLAGS_DEBUG = $(CXXFLAGS_BASE)
static-debug: create-output-dirs-debug $(OUT_DIR)/debug/$(OUT)

$(OUT_DIR)/release/$(OUT): $(OBJS_RELEASE) $(OUT_DIR) copy-pub-headers-release
	ar rcs $@ $(OBJS_RELEASE)
	@echo "Done"

$(OUT_DIR)/debug/$(OUT): $(OBJS_DEBUG) $(OUT_DIR) copy-pub-headers-debug
	ar rcs $@ $(OBJS_DEBUG)
	@echo "Done"

$(SRC_DIR)/%-release.o: $(SRC_DIR)/bitkub_commonlib.cpp $(SRC_DIR)/bitkub_commonlib.h $(SRC_DIR)/bitkub.h
	$(COMPILER) $(CXXFLAGS_RELEASE) -c $< -o $@

$(SRC_DIR)/%-debug.o: $(SRC_DIR)/bitkub_commonlib.cpp $(SRC_DIR)/bitkub_commonlib.h $(SRC_DIR)/bitkub.h
	$(COMPILER) $(CXXFLAGS_DEBUG) -c $< -o $@	

copy-pub-headers-release: $(OUT_DIR) create-output-dirs-release
	cp -av $(SRC_DIR)/bitkub.h $(OUT_DIR)/release/include/
	cp -av $(SRC_DIR)/bitkub_commonlib.h $(OUT_DIR)/release/include/

copy-pub-headers-debug: $(OUT_DIR) create-output-dirs-debug
	cp -av $(SRC_DIR)/bitkub.h $(OUT_DIR)/debug/include/
	cp -av $(SRC_DIR)/bitkub_commonlib.h $(OUT_DIR)/debug/include/

create-output-dirs-release: $(OUT_DIR)
	if [ ! -d "$(OUT_DIR)/release" ]; then \
		mkdir -p $(OUT_DIR)/release/include; \
	fi

create-output-dirs-debug: $(OUT_DIR)
	if [ ! -d "$(OUT_DIR)/debug" ]; then \
		mkdir -p $(OUT_DIR)/debug/include; \
	fi

$(OUT_DIR):
	if [ ! -d "$(OUT_DIR)" ]; then \
		mkdir $@; \
	fi

clean:
	rm -f $(SRC_DIR)/*.o
	rm -rf $(OUT_DIR)
	
