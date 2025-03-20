CC=gcc
NVCC=nvcc  # CUDA Compiler
CFLAGS= -O1 -g -pg
NVCCFLAGS= -O1 -g -pg -arch=sm_50
LDFLAGS= -lm -pg
CUDA_LDFLAGS= -lcudart


SOURCE_DIR= .
BIN_DIR= .
EXEC= canny

# CUDA source file (now contains all code)
CUSRC= $(SOURCE_DIR)/canny_edge.cu  

# Object file
CUOBJS=$(CUSRC:.cu=.o)

all: $(EXEC)

$(EXEC): $(CUOBJS)
	$(NVCC) $(NVCCFLAGS) -o $@ $(CUOBJS) $(CUDA_LDFLAGS) $(LDFLAGS)

%.o: %.cu
	$(NVCC) $(NVCCFLAGS) -c $< -o $@

run: $(EXEC)
	./$(EXEC) pics/pic_large.pgm 2.5 0.25 0.5
#                sigma tlow  thigh

clean:
	rm -f $(EXEC) $(CUOBJS)

.PHONY: clean all run
