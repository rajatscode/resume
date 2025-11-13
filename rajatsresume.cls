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
    Ligatures=TeX,
    Path=assets/fonts/Alegreya_Sans/,
    BoldItalicFont=AlegreyaSans-BoldItalic,
    BoldFont=AlegreyaSans-Bold,
    ItalicFont=AlegreyaSans-Italic
]{AlegreyaSans-Regular}

\setsansfont[
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
%% Parameters: {label}{value}{url (empty for no link)}
\newcommand{\site}[3]{%
    \if\relax\detokenize{#1}\relax%
        \PackageError{rajatsresume}{Site label (first argument) cannot be empty}{}%
    \fi%
    \if\relax\detokenize{#2}\relax%
        \PackageError{rajatsresume}{Site value (second argument) cannot be empty}{}%
    \fi%
    \usesitelabelfont\MakeUppercase{#1}~%
    \usesitevaluefont\href{#3}{#2}%
}

%% makeheader - main name header with dynamic sizing
%% Parameter: {name}
\newcommand{\makeheader}[1]{%
    \if\relax\detokenize{#1}\relax%
        \PackageError{rajatsresume}{Header name cannot be empty}{}%
    \fi%
    \begin{center}
        \color{primary}%
        \useheaderfont #1\\[0.2ex]%
    \end{center}%
}

%% entry - main content entry (role/project with dates and description)
%% Parameters: {title}{dates}{subtitle}{description}
\newcommand{\entry}[4]{%
    \if\relax\detokenize{#1}\relax%
        \PackageError{rajatsresume}{Entry title (first argument) cannot be empty}{}%
    \fi%
    \if\relax\detokenize{#2}\relax%
        \PackageError{rajatsresume}{Entry dates (second argument) cannot be empty}{}%
    \fi%
    \item[\usesubheadfont{#1}]%
    \hfill\usecontentfont{#2}\par%
    \useshortdescfont{#3}\par%
    \vspace{2pt}%
    \usecontentfont{#4}%
}

%% skillset - skill category and items
%% Parameters: {category}{items}
\newcommand{\skillset}[2]{%
    \if\relax\detokenize{#1}\relax%
        \PackageError{rajatsresume}{Skillset category (first argument) cannot be empty}{}%
    \fi%
    \item[]\usecontentfont{#1: #2}%
}

%% honor - award/title entry
%% Parameters: {title}{date}
\newcommand{\honor}[2]{%
    \if\relax\detokenize{#1}\relax%
        \PackageError{rajatsresume}{Honor title (first argument) cannot be empty}{}%
    \fi%
    \item[]\usecontentfont{#1}\hfill\usecontentfont{#2}%
}

% Environments

%% subheader - contact information below name
\newenvironment{subheader}{%
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

% Minimum header size (safety bound)
\newlength{\minheadersize}
\setlength{\minheadersize}{25pt}

% Create a flag to track if we've had overflow
\newif\ifhadoverflow
\hadoverflowfalse

% Counter to track compilation attempts
\newcounter{resizecount}
\setcounter{resizecount}{0}

% At end of document, check if we had more than one page
\AtEndDocument{%
    \ifthenelse{\pageref{LastPage}>1}{%
        % Check if we're below minimum size
        \ifdim\headersize<\minheadersize%
            \PackageError{rajatsresume}{%
                Header size reached minimum (\the\minheadersize) but content still
                overflows to \pageref{LastPage} pages.\MessageBreak
                Your resume has too much content to fit on one page.\MessageBreak
                Please remove some entries or reduce descriptions%
            }{Remove content to fit on one page}%
        \else%
            % Write a flag to aux file indicating overflow
            \immediate\write\@auxout{%
                \string\global\string\hadoverflowtrue%
            }%
            \immediate\write\@auxout{%
                \string\stepcounter{resizecount}%
            }%
            % Improved warning with actionable guidance
            \PackageWarning{rajatsresume}{%
                Document overflowed to \pageref{LastPage} pages
                (\number\numexpr\pageref{LastPage}-1\relax\space over target).\MessageBreak
                Auto-adjusting header size from \the\headersize\space
                (minimum: \the\minheadersize).\MessageBreak
                Recompile 2-3 more times until this message disappears.\MessageBreak
                If problem persists after 5 compilations, reduce content%
            }%
        \fi%
    }{%
        % Single page - success!
        \immediate\write\@auxout{%
            \string\global\string\hadoverflowfalse%
        }%
        \ifnum\value{resizecount}>0%
            \PackageInfo{rajatsresume}{%
                Success! Resume fits on one page at header size \the\headersize%
            }%
        \fi%
    }%
}

% At beginning of document, adjust header size if needed
\AtBeginDocument{%
    \ifhadoverflow%
        % Check if we're already at minimum
        \ifdim\headersize<\dimexpr\minheadersize+1pt\relax%
            \PackageError{rajatsresume}{%
                Cannot reduce header size below \the\minheadersize.\MessageBreak
                Content is too large to fit on one page.\MessageBreak
                Remove some entries or reduce text%
            }{Remove content to fit on one page}%
        \else%
            % Reduce header size by 10% on each iteration
            \setlength{\headersize}{0.9\headersize}%
            \PackageInfo{rajatsresume}{%
                Auto-resize attempt \number\value{resizecount}:
                reducing header to \the\headersize\space
                (min: \the\minheadersize)%
            }%
        \fi%
    \fi%
}

% Command to manually reset header size if user wants to start over
\newcommand{\resetheadersize}{%
    \setlength{\headersize}{60pt}%
    \global\hadoverflowfalse%
    \setcounter{resizecount}{0}%
}

% Command to manually set header size
\newcommand{\setheadersize}[1]{%
    \setlength{\headersize}{#1}%
}

% Command to help debug page fitting
\newcommand{\checkpagefit}{%
    \message{^^JPage fit check:}%
    \message{^^J  Current page: \thepage}%
    \message{^^J  Text height: \the\textheight}%
    \message{^^J  Header size: \the\headersize}%
    \message{^^J  Minimum size: \the\minheadersize}%
    \message{^^J  Resize attempts: \number\value{resizecount}}%
}
