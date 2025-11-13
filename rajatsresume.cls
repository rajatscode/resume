% intro options
\ProvidesClass{rajatsresume}[2020/11/12 resume class]
\NeedsTeXFormat{LaTeX2e}
\DeclareOption{print}{\def\@cv@print{}}
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}
\pagenumbering{gobble}

% Page geometry
\usepackage[hmargin=0.5in, vmargin=0.5in]{geometry}
\usepackage{verbatim} % to enable multiline comments
\usepackage[hidelinks]{hyperref}

% Modern color support (removed obsolete usenames/dvipsnames)
\usepackage{xcolor}
\definecolor{primary}{HTML}{000000}

% Typography enhancements
\usepackage{microtype}

% Set main fonts - DEFINE ONCE, USE MANY TIMES
\usepackage{fontspec}

% Define font families (loaded once, not on every command call)
\newfontfamily\headerfont[
    Path=assets/fonts/Oxygen/,
    BoldFont=Oxygen-Bold
]{Oxygen-Bold}

\newfontfamily\oxygenfont[
    Path=assets/fonts/Oxygen/,
    BoldFont=Oxygen-Bold
]{Oxygen-Light}

\newfontfamily\alegreyafont[
    Path=assets/fonts/Alegreya_Sans/,
    BoldItalicFont=AlegreyaSans-BoldItalic,
    BoldFont=AlegreyaSans-Bold,
    ItalicFont=AlegreyaSans-Italic
]{AlegreyaSans-Regular}

\newfontfamily\alegreyalightfont[
    Path=assets/fonts/Alegreya_Sans/
]{AlegreyaSans-Light}

\newfontfamily\alegreyaboldfont[
    Path=assets/fonts/Alegreya_Sans/
]{AlegreyaSans-Bold}

% Set document defaults
\setmainfont[
    Color=primary,
    Ligatures=TeX,
    Path=assets/fonts/Alegreya_Sans/,
    BoldItalicFont=AlegreyaSans-BoldItalic,
    BoldFont=AlegreyaSans-Bold,
    ItalicFont=AlegreyaSans-Italic
]{AlegreyaSans-Regular}

\setsansfont[
    Color=primary,
    Ligatures=TeX,
    Path=assets/fonts/Oxygen/,
    BoldFont=Oxygen-Bold
]{Oxygen-Light}

% Spacing parameters (no more magic numbers!)
\setlength{\topsep}{0pt}
\setlength{\partopsep}{0pt}
\setlength{\parskip}{0pt}
\setlength{\parindent}{0pt}

% Layout dimensions
\newlength{\labeltab}
\setlength{\labeltab}{1.5in}

\newlength{\datetab}
\setlength{\datetab}{6.2in}

\newlength{\desctab}
\setlength{\desctab}{6.05in}

\newlength{\entryspace}
\setlength{\entryspace}{5pt}

\newlength{\sectionspace}
\setlength{\sectionspace}{2pt}

\newlength{\topicendspace}
\setlength{\topicendspace}{6.5ex}

% Dynamic header sizing - user can override with \setHeaderSize{size}
\newlength{\headersize}
\setlength{\headersize}{60pt}

\newcommand{\setHeaderSize}[1]{%
    \setlength{\headersize}{#1}%
}

% Semantic font commands (efficient - no repeated fontspec calls!)
\newcommand{\usesitelabelfont}{%
    \fontsize{8pt}{9pt}\alegreyaboldfont\selectfont%
}

\newcommand{\usesitevaluefont}{%
    \fontsize{10pt}{10pt}\oxygenfont\selectfont%
}

\newcommand{\usesecheadfont}{%
    \fontsize{10pt}{11pt}\oxygenfont\selectfont%
}

\newcommand{\usesubheadfont}{%
    \fontsize{10pt}{11pt}\oxygenfont\bfseries\selectfont%
}

\newcommand{\useshortdescfont}{%
    \fontsize{11pt}{11pt}\alegreyafont\selectfont%
}

\newcommand{\usecontentfont}{%
    \fontsize{11pt}{11pt}\alegreyalightfont\selectfont%
}

\newcommand{\useheaderfont}{%
    \fontsize{\headersize}{\dimexpr\headersize+5pt}\headerfont\selectfont%
}

% LaTeX logo in document font (no more font family hacks in content!)
\newcommand{\doctex}{\LaTeX\xspace}

% Modern list-based layout (replacing archaic tabbing environment)
\usepackage{enumitem}
\usepackage{calc}
\usepackage{xspace}

% Custom list for entries
\newlist{resumelist}{description}{1}
\setlist[resumelist]{
    labelwidth=\labeltab,
    leftmargin=\labeltab,
    itemsep=\entryspace,
    parsep=0pt,
    topsep=\sectionspace,
    partopsep=0pt
}

% User-facing commands

%% site - for contact information in subheader
\newcommand{\site}[3]{%
    \usesitelabelfont\MakeUppercase{#1}~%
    \usesitevaluefont\href{#3}{#2}%
}

%% makeheader - main name header with dynamic sizing
\newcommand{\makeheader}[1]{%
    \begin{center}
        \color{primary}%
        \useheaderfont #1\\[0.2ex]%
    \end{center}%
}

%% entry - main content entry (role/project with dates and description)
\newcommand{\entry}[4]{%
    \item[\usesubheadfont{#1}]%
    \hfill\usecontentfont{#2}\par%
    \useshortdescfont{#3}\par%
    \vspace{2pt}%
    \usecontentfont{#4}%
}

%% skillset - skill category and items
\newcommand{\skillset}[2]{%
    \item[]\usecontentfont{#1: #2}%
}

%% honor - award/title entry
\newcommand{\honor}[2]{%
    \item[]\usecontentfont{#1}\hfill\usecontentfont{#2}%
}

% Environments

%% subheader - contact information below name
\newenvironment{subheader}[1]{%
    \begin{center}
    \hrulefill\par\vspace{1ex}%
}{%
    \par\vspace{1ex}\hrulefill
    \end{center}
}

%% topic - main section (Education, Experience, etc.)
\newenvironment{topic}[1]{%
    \vspace{1ex}%
    {\usesecheadfont #1}\par%
    \vspace{-\baselineskip}%
    \begin{resumelist}%
}{%
    \end{resumelist}%
    \vspace{-\topicendspace}%
}

% Automatic one-page fitting system
% Uses lastpage package to detect overflow and auto-adjust header size
\usepackage{lastpage}
\usepackage{ifthen}

% Create a flag to track if we've had overflow
\newif\ifhadoverflow
\hadoverflowfalse

% At end of document, check if we had more than one page
\AtEndDocument{%
    \ifthenelse{\pageref{LastPage}>1}{%
        % Write a flag to aux file indicating overflow
        \immediate\write\@auxout{%
            \string\global\string\hadoverflowtrue%
        }%
        % Also warn the user
        \PackageWarning{rajatsresume}{%
            Document overflowed to \pageref{LastPage} pages.
            Recompile to auto-adjust header size%
        }%
    }{%
        % Single page - write success flag
        \immediate\write\@auxout{%
            \string\global\string\hadoverflowfalse%
        }%
    }%
}

% At beginning of document, adjust header size if needed
\AtBeginDocument{%
    \ifhadoverflow%
        % Reduce header size by 10% on each iteration
        \setlength{\headersize}{0.9\headersize}%
        \PackageInfo{rajatsresume}{%
            Auto-reducing header size to \the\headersize\space due to overflow%
        }%
    \fi%
}

% Command to manually reset header size if user wants to start over
\newcommand{\resetHeaderSize}{%
    \setlength{\headersize}{60pt}%
    \global\hadoverflowfalse%
}

% Command to help debug page fitting
\newcommand{\checkpagefit}{%
    \message{^^JPage fit check:}%
    \message{^^J  Current page: \thepage}%
    \message{^^J  Text height: \the\textheight}%
    \message{^^J  Header size: \the\headersize}%
}
