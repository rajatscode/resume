% intro options
\ProvidesClass{resume-rajatscode}[2020/11/12 resume class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}
\pagenumbering{gobble}
\setlength{\topsep}{0pt}
\setlength{\partopsep}{0pt}
\setlength{\parskip}{0pt}

% Misc. package Imports
\usepackage[hmargin=0.5in, vmargin=0.5in]{geometry}
\usepackage{verbatim} % to enable multiline comments
\usepackage[hidelinks]{hyperref}

% Table setup
\usepackage{tabularx,tabulary}
\newcolumntype{s}{>{\raggedright\hsize=2\hsize}l} % section column

% Color definitions
\usepackage[usenames, dvipsnames]{xcolor} 
% \definecolor{NAME}{HTML}{HEXHEX}
\definecolor{primary}{HTML}{000000}

% Set main fonts
\usepackage{fontspec}
% extra-explicit below for ease of editing later
\setmainfont[Color=primary,
             Scale=MatchLowercase,
             Ligatures=TeX,
             Path=resources/fonts/Alegreya_Sans/,
             BoldItalicFont=AlegreyaSans-BoldItalic,
             BoldFont=AlegreyaSans-Bold,
             ItalicFont=AlegreyaSans-Italic]{AlegreyaSans-Regular}
\setsansfont[Color=primary,
             Scale=MatchLowercase,
             Ligatures=TeX,
             Path=resources/fonts/Oxygen/,
             BoldFont=Oxygen-Bold]{Oxygen-Light}

% Commands
%% variables
%%% entryspace
\newcommand{\entryspace}{5pt}

%%% labeltab
\newcommand{\labeltab}{1.5in}

%%% datetab
\newcommand{\datetab}{6.2in}

%%% desctab - description tab
\newcommand{\desctab}{6.05in}

%% font specifications
%%% site
\newcommand{\site}[3]{
    \fontsize{8pt}{9pt}
    \fontspec[Path=resources/fonts/Alegreya_Sans/]{AlegreyaSans-Bold}\selectfont
    \MakeUppercase{#1}
    \fontsize{10pt}{10pt}
    \fontspec[Path=resources/fonts/Oxygen/]{Oxygen-Light}\selectfont
    \href{#3}{#2}
}

%%% section header
\newcommand{\sechead}[1]{
    \fontsize{10pt}{11pt}
    \fontspec[Path=resources/fonts/Oxygen/]{Oxygen-Light}\selectfont #1
}

%%% section subheader
\newcommand{\secsub}[1]{
    \fontsize{10pt}{11pt}
    \fontspec[Path=resources/fonts/Oxygen/]{Oxygen-Regular}\selectfont #1
}

%%% short description
\newcommand{\shortdesc}[1]{
    \fontsize{11pt}{11pt}
    \fontspec[Path=resources/fonts/Alegreya_Sans/]
    {AlegreyaSans-Regular}\selectfont{#1}
}

%%% content
\newcommand{\content}{
    \fontsize{11pt}{11pt}
    \fontspec[Path=resources/fonts/Alegreya_Sans/]{AlegreyaSans-Light}\selectfont
}

%% makeheader
\newcommand{\makeheader}[1]{
	\centering{
		\color{primary}
		\fontsize{60pt}{65pt}
		\fontspec[Path=resources/fonts/Oxygen/]{Oxygen-Bold}\selectfont #1
        \\[0.2ex]
	}
}

%% entry
\newcommand{\entry}[4]{
    \>\secsub{#1} \> \content{#2} \' \\
    \>\shortdesc{#3}\\[\entryspace]
    \>\ 
    \begin{minipage}{\desctab}
    \content{#4} \\
    \end{minipage}\\
}

%% skillset
\newcommand{\skillset}[2]{
    \> \content{#1: #2} \\
}

%% honor
\newcommand{\honor}[2]{
    \> \content{#1} \> \content{#2} \'
}

% Environments
%% entrytab - tabbing with modified spacing
\newenvironment{entrytab}{
    \setlength{\topsep}{2pt}%
    \setlength{\partopsep}{0pt}%
    \tabbing
}{
    \endtabbing
}

%% subheader
\newenvironment{subheader}[1]{
     \centering
     \hrulefill\\[1ex]
}{
     \hrulefill\\[1ex]
}

%% topic
\newenvironment{topic}[1]{
    \begin{entrytab}
        \hspace*{\labeltab}\= \hspace*{\datetab}\= \kill
        \sechead{#1}\\[-\baselineskip]
}{
    \\[-6.5ex]
    \end{entrytab}
}
