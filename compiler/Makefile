# ==========================================
# Makefile for c0computer compiler toolchain
# Builds and tests .c files in _data/
# ==========================================

CLANG = /opt/homebrew/opt/llvm/bin/clang-21
RV_CFLAGS = --target=riscv64 -march=rv64g -mabi=lp64d
RV0AS = ./rv0/rv0as
RV0VM = ./rv0/rv0vm
DATA_DIR = _data

# Get list of .c files
C_FILES := $(wildcard $(DATA_DIR)/*.c)
TARGETS := $(C_FILES:.c=.o)

# Disable built-in rules
.SUFFIXES:

# Default target - build and test all
all test: $(TARGETS)
	@echo ""
	@echo "=========================================="
	@echo "Testing all compiled programs"
	@echo "=========================================="
	@echo "Running fact (entry=0x6c)..."
	$(RV0VM) -e 0x6c $(DATA_DIR)/fact.o
	@echo "Exit code: $$?"
	@echo ""
	@echo "Running test (entry=0x0)..."
	$(RV0VM) -e 0x0 $(DATA_DIR)/test.o
	@echo "Exit code: $$?"

# Build rule for each .c file
$(DATA_DIR)/%.o: $(DATA_DIR)/%.c
	@echo "Building $*..."
	$(CLANG) $(RV_CFLAGS) -S $(DATA_DIR)/$*.c -o $(DATA_DIR)/$*.s
	$(RV0AS) $(DATA_DIR)/$*.s -o $(DATA_DIR)/$*.o

# Run a specific program: make run name=fact
run:
	@if [ "$(name)" = "fact" ]; then \
		$(RV0VM) -e 0x6c $(DATA_DIR)/$(name).o; \
	else \
		$(RV0VM) -e 0x0 $(DATA_DIR)/$(name).o; \
	fi

# Build specific file: make fact
%:
	@if [ -f $(DATA_DIR)/$@.c ]; then \
		echo "Building $@..."; \
		$(CLANG) $(RV_CFLAGS) -S $(DATA_DIR)/$@.c -o $(DATA_DIR)/$@.s; \
		$(RV0AS) $(DATA_DIR)/$@.s -o $(DATA_DIR)/$@.o; \
	else \
		echo "No such file: $(DATA_DIR)/$@.c"; \
		exit 1; \
	fi

# Clean generated files
clean:
	rm -f $(DATA_DIR)/*.ll $(DATA_DIR)/*.s $(DATA_DIR)/*.o

.PHONY: all test run clean
