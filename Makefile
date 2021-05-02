# recommend to build and link with commonlib statically but shared library is also possible too
# just that we *might* update such functionality in the future.
.PHONY: static-debug static-release clean

OUT = libbitkub.a
OUT_DIR = bin
COMPILER = g++
CXXFLAGS = -g -std=c++17 -Wall -Wextra -pedantic -I.
SRC_DIR = src
SOURCES = $(SRC_DIR)/bitkub_commonlib.o

# We will output object files into src/ directory
OBJS = $(addprefix src/, $(addsuffix .o, $(basename $(notdir $(SOURCES)))))

# default target
# NOTE: first target is the default target
static-release: CXXFLAGS += -O2
static-release: $(OUT_DIR)/$(OUT)

static-debug: $(OUT_DIR)/$(OUT)

$(OUT_DIR)/$(OUT): $(OBJS) $(OUT_DIR)
	ar rcs $@ $(OBJS)

$(SRC_DIR)/%.o: $(SRC_DIR)/bitkub_commonlib.cpp $(SRC_DIR)/bitkub_commonlib.h $(SRC_DIR)/bitkub.h
	$(COMPILER) $(CXXFLAGS) -c $< -o $@

$(OUT_DIR):
	@mkdir $@

clean:
	rm -f $(SRC_DIR)/*.o
	rm -rf $(OUT_DIR)
	
