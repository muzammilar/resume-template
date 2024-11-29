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
	pdflatex.exe -job-name=${PREFIX} ${VAR_DECL} ${VAR_NAME}=10 ${FILE_NAME}
	pdflatex.exe -job-name=${PREFIX}-short ${VAR_DECL} ${VAR_NAME}=0 ${FILE_NAME}

clean:
	rm ./*.log ./${PREFIX}*.aux ./${PREFIX}*.out
