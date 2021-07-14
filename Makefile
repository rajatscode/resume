TITLE="resume"
AUTHOR="jan doe"
SUBJECT="a resume"

build:
	xelatex resume.tex
	exiftool -Title=${TITLE} -Author=${AUTHOR} -Subject=${SUBJECT} resume.pdf

view:
	${MAKE} build
	zathura resume.pdf
