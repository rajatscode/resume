# resume

[![GitHub Release](https://img.shields.io/github/tag/rajatscode/resume.svg)](https://github.com/rajatscode/resume/releases)
[![License](https://img.shields.io/github/license/rajatscode/resume.svg)](https://github.com/rajatscode/resume/blob/master/LICENSE)

A simple, single-column XeTeX resume template with a top-down, left-right
hierarchy

## Example

An example resume with can be found in
[resume.pdf](https://github.com/rajatscode/resume/blob/master/resume.pdf). This is
the resume generated using resume.tex.

![example resume](https://github.com/rajatscode/resume/blob/master/resources/images/resume.png)

## Installation

Either clone the latest version of this repository or download and extract an
archive from [releases](https://github.com/rajatscode/resume/releases).

## Usage

This package provides a class file and a .tex template filled with lipsum. You
can change the content in the template to suit your needs and/or use the class
definition elsewhere to get similar formatting capabilities.

To simply re-create the example resume:
```
xelatex resume.tex
```

## Dependencies

To build files using this template, you will need
[XeTeX](https://ctan.org/pkg/xetex?lang=en) and
[LaTeX2e](https://www.ctan.org/pkg/latex).

This resume template uses the
[Alegreya Sans](https://fonts.google.com/specimen/Alegreya+Sans?selection.family=Alegreya+Sans)
and [Oxygen](https://fonts.google.com/specimen/Oxygen?selection.family=Oxygen)
typefaces, redistributed under the Open Font License. A copy of the Open Font
License (labeled 'OFL.txt') can be found within each typeface's directory in
the /resources/fonts subdirectory.
