% ----------------------------------------------------------
% iodhbwm class
%
%   inofficial package for DHBW Mannheim to simplify writing
%   theses with the given requirements
% ----------------------------------------------------------
% Felix Faltin
% E-Mail: ffaltin91@gmail.com
% ----------------------------------------------------------
% Copyright 2017 Felix Faltin
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Felix Faltin.
%
% ----------------------------------------------------------

\newcommand*{\iodhbwm@cls@version}{v0.3-alpha}
\newcommand*{\iodhbwm@cls@date}{2018-02-14}
\newcommand*{\iodhbwm@cls@info}{Inoffical DHBW Mannheim thesis class}

\ProvidesClass{iodhbwm}[%
\iodhbwm@cls@date\space
\iodhbwm@cls@version\space
\iodhbwm@cls@info]

\RequirePackage{etoolbox, pgfopts, scrlfile, xstring}

\providecommand*{\iodhbwm@cls@baseclass}{scrreprt}
\newcommand*{\iodhbwm@cls@baseclass@options}{}
\let\iodhbwm@languages\@empty
\let\iodhbwm@main@languages\@empty

% ----------------------------------------------------------
% Define booleans
% ----------------------------------------------------------
\newbool{iodhbwm@cls@if@preamble}\booltrue{iodhbwm@cls@if@preamble}
\newbool{iodhbwm@cls@if@templates}
\newbool{iodhbwm@cls@if@bib}
\newbool{iodhbwm@cls@if@print@bib}\booltrue{iodhbwm@cls@if@print@bib}
\newbool{iodhbwm@cls@if@tocstotoc}
\newbool{iodhbwm@cls@if@isdebug}

% ----------------------------------------------------------
% Define available options
% ----------------------------------------------------------
\pgfkeys{
    iodhbwm/.cd,
    language/.code              = \appto{\iodhbwm@languages}{#1,},
    mainlanguage/.code          = {%
        \appto{\iodhbwm@languages}{main=#1,}%
        \def\iodhbwm@main@languages{#1}%
    },
    load-preamble/.is if        = iodhbwm@cls@if@preamble,
    load-dhbw-templates/.is if  = iodhbwm@cls@if@templates,
    add-tocs-to-toc/.is if      = iodhbwm@cls@if@tocstotoc,
    add-bibliography/.is if     = iodhbwm@cls@if@bib,
    add-bibliography-/.code    = {%
        \booltrue{iodhbwm@cls@if@bib}%
        \boolfalse{iodhbwm@cls@if@print@bib}%
    },
    bib-file/.store in          = \iodhbwm@bib@file,
    bib-file = {},
    biblatex/bibstyle/.store in  = \iodhbwm@bib@bibstyle@opt,
    biblatex/citestyle/.store in = \iodhbwm@bib@citestyle@opt,
    biblatex/style/.style       = {biblatex/bibstyle=#1,biblatex/citestyle=#1},
    biblatex/style = numeric-comp,
    debug/.is if                = iodhbwm@cls@if@isdebug,
    unknown/.code               = \edef\iodhbwm@cls@baseclass@options{\iodhbwm@cls@baseclass@options,\pgfkeyscurrentname}
}

\ProcessPgfOptions{/iodhbwm}

\PassOptionsToClass{%
    fontsize=12pt,
    a4paper,
    parskip=half-
}{\iodhbwm@cls@baseclass}

\LoadClass[\iodhbwm@cls@baseclass@options]{\iodhbwm@cls@baseclass}

\ifbool{iodhbwm@cls@if@tocstotoc}{%
    \KOMAoptions{%
        listof  = totoc
    }%
}{}

\ifbool{iodhbwm@cls@if@preamble}{%
    \RequirePackage{lmodern}
    \RequirePackage{microtype}
    \RequirePackage{scrhack}
    \RequirePackage{setspace}
    \RequirePackage[%
        headsepline,
        footsepline,
        plainfootsepline,
        clines,
        automark,
    ]{scrlayer-scrpage}
    \RequirePackage{geometry}
    \RequirePackage{siunitx}
    \PassOptionsToPackage{intlimits}{amsmath}
    \RequirePackage{mathtools}
    \PassOptionsToPackage{
        table,
        dvipsnames
    }{xcolor}
    \RequirePackage{graphicx}
    \RequirePackage[most]{tcolorbox}
    \RequirePackage{tabularx}
    \RequirePackage{booktabs}
    \RequirePackage{multirow}
    \RequirePackage{listings}
    \RequirePackage{caption}
}{}

% Pass language to package
\ifcsempty{iodhbwm@languages}{}{%
    % Delete trailing comma
    \IfEndWith{\iodhbwm@languages}{,}{%
        \StrGobbleRight{\iodhbwm@languages}{1}[\iodhbwm@languages@list]
    }{\let\iodhbwm@languages@list\iodhbwm@languages}

    % If no main language was set use last language
    % as main language
    \ifundef{\iodhbwm@main@languages}{%
        \StrCount{\iodhbwm@languages@list}{,}[\numofelem]
        \ifnum\numofelem>0\relax
            \StrBehind[\numofelem]{\iodhbwm@languages@list}{,}[\iodhbwm@main@languages]%
        \else
            \let\iodhbwm@main@languages\iodhbwm@languages@list%
        \fi
    }{}
    \RequirePackage[\iodhbwm@languages@list]{babel}
    \AfterPackage{inputenc}{\RequirePackage[autostyle]{csquotes}}%
}

% Package settings
\@ifpackageloaded{geometry}{%
    \geometry{%
        top           = 3cm,    % Seitenabstand oben
        right         = 2.5cm,  % Seitenabstand recht
        bottom        = 3cm,    % Seitenabstand unten
        left          = 2.5cm,  % Seitenabstand links
        bindingoffset = 1cm,    % Bindekorrektur
        includeheadfoot
    }
}{}

\@ifpackageloaded{siunitx}{%
    \sisetup{
        %    mode = math, % text is printed using a math font
        detect-all,
        separate-uncertainty = true,
        locale               = DE,
        per-mode             = fraction,
        range-phrase= -,
        range-units=single
    }
}{}

\@ifpackageloaded{scrlayer-scrpage}{%
    \automark[section]{chapter}
    \automark*{section}
    \clearpairofpagestyles                          % Leeren von Kopf- und Fußzeile
    %\ohead{\pagemark}                              % Kopfzeile außen: Seitenzahl
    \ihead{\headmark}                               % Kopfzeile innen: chapter und section Titel
    \cfoot[-~\pagemark~-]{-~\pagemark~-}            % Fußzeile mitte: Seitenzahl
}{}

% Load cleveref after hyperref package
\AfterPackage!{hyperref}{%
    \ifdef{\iodhbwm@main@languages}{%
        \PassOptionsToPackage{\iodhbwm@main@languages}{cleveref}
    }{}
    \RequirePackage[%
    noabbrev,
    nameinlink
    ]{cleveref}
    
}
% Load hyperref always at the end of the preambel
% To avoid a race condition with biblatex
% hyperref have to be placed before biblatex
% when \AtEndPreamble is used
% https://tex.stackexchange.com/questions/417556/hyperref-doesnt-highlight-cites
\AtEndPreamble{%
    \RequirePackage{hyperref}
    \hypersetup{
        pdftitle       = {\ifdef{\getTitel}{\getTitel}{undefined}},
        pdfsubject     = {\ifdef{\getTitel}{\getTitel}{undefined}},
        pdfauthor      = {\ifdef{\getAuthor}{\getAuthor}{undefined}},
        pdfcreator     = {pdf\LaTeX},
        pdfproducer    = {pdf\LaTeX},
        pdftoolbar     = true,
        pdfmenubar     = false,
        bookmarksopen  = false,                 % bookmarksopen ODER bookmarksopenlevel!
        colorlinks
    }
}

% Load biblatex if option add-bibliography is set
% The bibliography is printed at the end of the document. If the option bib-file is set then
% the class is searching for the given file. Otherwise it try to load dhbw-source.bib.
% If no file is found a warning is thrown.
\ifbool{iodhbwm@cls@if@bib}{%
    \AtEndDocument{%
        \singlespacing%
        
        \ifboolexpr{bool {iodhbwm@cls@if@tocstotoc} and bool {iodhbwm@cls@if@print@bib}}{%
            \printbibliography[heading=bibintoc]%
        }{%
            \ifbool{iodhbwm@cls@if@print@bib}{%
                \printbibliography%
            }{}%
        }%
    }%

    \RequirePackage[%
        backend      = biber,           % bibtex oder biber [default]
        bibstyle     = \iodhbwm@bib@bibstyle@opt,
        citestyle    = \iodhbwm@bib@citestyle@opt,
        sorting      = nty,             % Sortierung (Name, Titel, Jahr)
        natbib       = true,            % Kompatibilität mit Natbib-Bibliothek
        block        = space,           % kleiner horizontaler Platz zwischen den Feldern
        backrefstyle = three+,          % fasst Seiten zusammen, z.B. S. 2f, 6ff, 7-10
        date         = short,           % Datumsformat
        bibwarn      = true,
        texencoding  = auto,            % auto-detect the input encoding
        bibencoding  = auto,            % (auto (equal to tex), <encoding>)
        isbn         = false
    ]{biblatex}%
    \ifdefempty{\iodhbwm@bib@file}{%
        \IfFileExists{dhbw-source.bib}{%
            \pgfkeys{/iodhbwm/bib-file = dhbw-source.bib}%
        }{%
            \ClassWarning{iodhbwm}{Cannot find default dbhw-source.bib file.}%
        }%
    }{%
        \IfFileExists{\iodhbwm@bib@file}{}{%
            \ClassWarning{iodhbwm}{Couldn't find passed bib file \iodhbwm@bib@file}
        }%
    }%
    \addbibresource{\iodhbwm@bib@file}%
}{\AtEndDocument{}}%

\ifbool{iodhbwm@cls@if@templates}{%
    \RequirePackage{iodhbwm-templates}
}{}

\ifbool{iodhbwm@cls@if@isdebug}{%
    \RequirePackage{blindtext, lipsum}
}{}

% ----------------------------------------------------------
% Defining custom colors
% ----------------------------------------------------------
\definecolor{DHBW-red}{HTML}{e2001a}
\definecolor{DHBW-blue}{HTML}{026f93}
\definecolor{DHBW-darkblue}{HTML}{23527c}
\definecolor{DHBW-light}{HTML}{ffffff}
\definecolor{DHBW-font}{HTML}{5c6971}
\definecolor{DHBW-dark-font}{HTML}{333333}

% ----------------------------------------------------------
% Generial design settings
% ----------------------------------------------------------

% All captions
\captionsetup{%
    format=hang,
    % singlelinecheck=false,
    font=small,
    labelfont=bf
}

\ifbool{iodhbwm@cls@if@templates}{%
    % Listing format
    \DeclareCaptionFont{DHBWwhite}{\color{DHBW-light}}
    \DeclareCaptionFormat{listing}{%
        \colorbox{DHBW-red}{%
            \parbox{\dimexpr\textwidth-2\fboxsep\relax}{#1#2#3}%
        }%
    }
    
    \captionsetup[lstlisting]{%
        format=listing,
        singlelinecheck=false,
        margin=0pt,
        font={DHBWwhite,sf},
%        labelsep=space,
    }
    
    \lstset{
        basicstyle=\footnotesize\ttfamily\color{DHBW-dark-font},
        backgroundcolor=\color{DHBW-light},
        rulecolor=\color{DHBW-red},
        commentstyle=\color{DHBW-font},
        keywordstyle=\color{DHBW-darkblue},
        numberstyle=\scriptsize\color{DHBW-font},
        stringstyle=\color{purple},
%        identifierstyle=\color{red},
        numbers=left,
        captionpos=t,
        showstringspaces=false,
        tabsize=2,
        frame=b,
        breaklines=true,
        xleftmargin=17pt,
        framexleftmargin=17pt,
    }
}{}


\endinput