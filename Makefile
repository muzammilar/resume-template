


# Use the kernel version to differentiate between linux and WSL since the kernel version of WSL ends with `microsoft-standard-WSL2`
KERNEL_VERSION := $(shell uname -r)

# or and findstring operates on the principle of non-empty string being returned (i.e. string is returned if it's found otherwise empty string is returned)
res_ms := $(findstring microsoft,$(KERNEL_VERSION))
res_wsl := $(findstring WSL,$(KERNEL_VERSION))
res_exists := $(or ${res_ms}, ${res_wsl})

# These can be changed via command line
PDFLATEX := pdflatex

# if we're on WSL
ifneq (,${res_exists})
PDFLATEX := pdflatex.exe
endif

# file prefix for generation
PREFIX := "main"

# latex variables
VAR_NAME := "\passedresumelength"
VAR_DECL := "\newcount\passedresumelength"
FILE_NAME := "\input{main.tex}"

.PHONY: all clean pdf

default: pdf clean

all: pdf clean

# Example: pdflatex.exe -job-name="${PREFIX}" "\newcount\passedresumelength \passedresumelength=10 \input{main.tex}"
# Generate Resume Versions
pdf:
	${PDFLATEX} -job-name=${PREFIX} ${VAR_DECL} ${VAR_NAME}=10 ${FILE_NAME}
	${PDFLATEX} -job-name=${PREFIX}-short ${VAR_DECL} ${VAR_NAME}=0 ${FILE_NAME}

clean:
	rm ./*.log ./${PREFIX}*.aux ./${PREFIX}*.out
