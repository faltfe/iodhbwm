% ----------------------------------------------------------
% iodhbwm class
%
%   inofficial package for DHBW Mannheim to simplify writing
%   theses with the given requirements
% ----------------------------------------------------------
% Felix Faltin
% E-Mail: ffaltin91@gmail.com
% ----------------------------------------------------------
% Copyright 2017-2019 Felix Faltin
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

\newcommand*{\iodhbwm@cls@version}{v1.0.1}
\newcommand*{\iodhbwm@cls@date}{2019-01-27}
\newcommand*{\iodhbwm@cls@info}{Inoffical DHBW Mannheim thesis class}

\ProvidesClass{iodhbwm}[%
\iodhbwm@cls@date\space
\iodhbwm@cls@version\space
\iodhbwm@cls@info]

\RequirePackage{etoolbox, pgfopts, scrlfile, xstring}

\providecommand*{\iodhbwm@cls@baseclass}{scrreprt}
\providecommand*{\iodhbwm@cls@baseclass@options}{}
\let\iodhbwm@languages\@empty

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                           %
%                    OPTIONS AND FLAGS                      %
%                                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ----------------------------------------------------------
% Define booleans
% ----------------------------------------------------------
\newbool{iodhbwm@cls@if@preamble}\booltrue{iodhbwm@cls@if@preamble}
\newbool{iodhbwm@cls@if@templates}
\newbool{iodhbwm@cls@if@bib}
\newbool{iodhbwm@cls@if@bib@print}\booltrue{iodhbwm@cls@if@bib@print}
\newbool{iodhbwm@cls@if@tocstotoc}
\newbool{iodhbwm@cls@if@isdebug}
\newbool{iodhbwm@cls@if@print@minus}
\newbool{iodhbwm@cls@if@print}
\newbool{iodhbwm@cls@if@auto@intro@custom}
\newbool{iodhbwm@cls@if@auto@intro@default}
\newbool{iodhbwm@cls@if@auto@intro@all}
\newbool{iodhbwm@cls@if@appendix}

% ----------------------------------------------------------
% Define available options
% ----------------------------------------------------------
\pgfkeys{
    iodhbwm/.cd,
    language/.code                  = \appto{\iodhbwm@languages}{#1,},
    mainlanguage/.code              = {%
        \appto{\iodhbwm@languages}{main=#1,}%
        \def\iodhbwm@main@language{#1}%
    },
    load-preamble/.is if            = iodhbwm@cls@if@preamble,
    load-dhbw-templates/.is if      = iodhbwm@cls@if@templates,
    add-tocs-to-toc/.is if          = iodhbwm@cls@if@tocstotoc,
    add-bibliography/.is if         = iodhbwm@cls@if@bib,
    add-bibliography-/.code         = {%
        \booltrue{iodhbwm@cls@if@bib}%
        \boolfalse{iodhbwm@cls@if@bib@print}%
    },
    bib-file/.store in              = \iodhbwm@bib@file,
    bib-file                        = {},
    biblatex/bibstyle/.store in     = \iodhbwm@bib@bibstyle@opt,
    biblatex/citestyle/.store in    = \iodhbwm@bib@citestyle@opt,
    biblatex/style/.style           = {biblatex/bibstyle=#1,biblatex/citestyle=#1},
    biblatex/style                  = numeric-comp,
    debug/.is if                    = iodhbwm@cls@if@isdebug,
    print-/.is if                   = iodhbwm@cls@if@print@minus,
    print/.code                     = {%
        \booltrue{iodhbwm@cls@if@print}%
        \booltrue{iodhbwm@cls@if@print@minus}%
    },
    auto-intro-pages/.is choice,
    auto-intro-page/none/.code      = {},
    auto-intro-pages/custom/.is if  = iodhbwm@cls@if@auto@intro@custom,
    auto-intro-pages/default/.is if = iodhbwm@cls@if@auto@intro@default,
    auto-intro-pages/all/.is if     = iodhbwm@cls@if@auto@intro@all,
    auto-intro-pages/.default       = default,
    .unknown/.code                  = \edef\iodhbwm@cls@baseclass@options{\pgfkeyscurrentname}
}

\ProcessPgfOptions{/iodhbwm}

% ----------------------------------------------------------
% Default class option
% ----------------------------------------------------------

% If unknown options are passed prepend a comma (,)
% before prepend again and always the predefind options.
\ifcsempty{iodhbwm@cls@baseclass@options}{}%
{%
    \preto{\iodhbwm@cls@baseclass@options}{,}%
}
\preto{\iodhbwm@cls@baseclass@options}{%
    fontsize=12pt,%
    parskip=half-%
}%

\LoadClass[\iodhbwm@cls@baseclass@options]{\iodhbwm@cls@baseclass}

% ----------------------------------------------------------
% Set KOMA options
% ----------------------------------------------------------
\ifbool{iodhbwm@cls@if@tocstotoc}{%
    \KOMAoptions{%
        listof  = totoc
    }%
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                           %
%                          LANGUAGE                         %
%                                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ----------------------------------------------------------
% Defining language
% ----------------------------------------------------------
\ifcsempty{iodhbwm@languages}{}{%
    % Delete trailing comma
    \IfEndWith{\iodhbwm@languages}{,}{%
        \StrGobbleRight{\iodhbwm@languages}{1}[\iodhbwm@languages@list]
    }{\let\iodhbwm@languages@list\iodhbwm@languages}
    
    % If no main language was set use last language
    % as main language
    \ifundef{\iodhbwm@main@language}{%
        \StrCount{\iodhbwm@languages@list}{,}[\numofelem]
        \ifnum\numofelem>0\relax
        \StrBehind[\numofelem]{\iodhbwm@languages@list}{,}[\iodhbwm@main@language]%
        \else
        \let\iodhbwm@main@language\iodhbwm@languages@list%
        \fi
    }{}
    \RequirePackage[\iodhbwm@languages@list]{babel}
    \RequirePackage[autostyle]{csquotes}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                           %
%                          PACKAGES                         %
%                                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ----------------------------------------------------------
% Load default packages
% ----------------------------------------------------------
\ifbool{iodhbwm@cls@if@preamble}{%
    \RequirePackage{lmodern}
    \RequirePackage{microtype}
    \RequirePackage{scrhack}
    \RequirePackage{setspace}
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
%    \RequirePackage{multirow}
}{}

\ifbool{iodhbwm@cls@if@templates}{%
    \RequirePackage{iodhbwm-templates}
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                           %
%                           DESIGN                          %
%                                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ----------------------------------------------------------
% Defining custom colors
% ----------------------------------------------------------
\@ifpackageloaded{xcolor}{}{\RequirePackage{xcolor}}

%https://tex.stackexchange.com/questions/419842/compile-error-illegal-unit-only-with-texlive-2015
\patchcmd{\@hex@@Hex}{f\else}{F\else}{\typeout{Patching xcolor for TL15}}{}
\definecolor{DHBW-red}{HTML}{e2001a}
\definecolor{DHBW-blue}{HTML}{026f93}
\definecolor{DHBW-darkblue}{HTML}{23527c}
\definecolor{DHBW-light}{HTML}{ffffff}
\definecolor{DHBW-font}{HTML}{5c6971}
\definecolor{DHBW-dark-font}{HTML}{333333}

% ----------------------------------------------------------
% Page settings
% ----------------------------------------------------------
\@ifpackageloaded{geometry}{}{\RequirePackage{geometry}}
\geometry{%
    top           = 3cm,    % Seitenabstand oben
    right         = 2.5cm,  % Seitenabstand recht
    bottom        = 3cm,    % Seitenabstand unten
    left          = 2.5cm,  % Seitenabstand links
    bindingoffset = 1cm,    % Bindekorrektur
    includeheadfoot
}

% ----------------------------------------------------------
% Header and Footer
% ----------------------------------------------------------
\@ifpackageloaded{scrlayer-scrpage}{}{%
    \RequirePackage[%
        headsepline,
        footsepline,
        plainfootsepline,
        clines,
        automark,
    ]{scrlayer-scrpage}
}%
\automark[section]{chapter}
\automark*{section}
\clearpairofpagestyles                          % Leeren von Kopf- und Fußzeile
%\ohead{\pagemark}                              % Kopfzeile außen: Seitenzahl
\ihead{\headmark}                               % Kopfzeile innen: chapter und section Titel
\cfoot[-~\pagemark~-]{-~\pagemark~-}            % Fußzeile mitte: Seitenzahl

% ----------------------------------------------------------
% Numbers and units
% ----------------------------------------------------------
\ifbool{iodhbwm@cls@if@preamble}{%
    \@ifpackageloaded{siunitx}{}{\RequirePackage{siunitx}}%
    \sisetup{%
        %    mode = math, % text is printed using a math font
        detect-all,
        separate-uncertainty = true,
        locale               = DE,
        per-mode             = fraction,
        range-phrase= -,
        range-units=single
    }%
}{}%

% ----------------------------------------------------------
% Enable references and links
% ----------------------------------------------------------
\AfterPackage!{hyperref}{%
    \ifdef{\iodhbwm@main@language}{%
        \PassOptionsToPackage{\iodhbwm@main@language}{cleveref}
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
    \ifdef{\iodhbwm@main@language}{%
        \PassOptionsToPackage{\iodhbwm@main@language}{hyperref}
    }{}
    \RequirePackage{hyperref}
    \hypersetup{
        pdftitle       = {\ifdef{\getThesisTitle}{\getThesisTitle}{undefined}},
        pdfsubject     = {\ifdef{\getThesisTitle}{\getThesisTitle}{undefined}},
        pdfauthor      = {\ifdef{\getAuthor}{\getAuthor}{undefined}},
        pdfcreator     = {pdf\LaTeX},
        pdfproducer    = {pdf\LaTeX},
        pdftoolbar     = true,
        pdfmenubar     = false,
        bookmarksopen  = false,                 % bookmarksopen ODER bookmarksopenlevel!
    }%
    \ifbool{iodhbwm@cls@if@print@minus}{%
        \hypersetup{hidelinks}
    }{%
        \hypersetup{%
            colorlinks,
            allcolors=DHBW-red,
            urlcolor=DHBW-blue%
        }%
    }%
}
% hyperref loads auxhook, which does not work correctly if it is loaded
% via \AtEndPreamble. So we load it immediately to avoid problems:
\RequirePackage{auxhook}

% ----------------------------------------------------------
% Format captions and listings
% ----------------------------------------------------------

\@ifpackageloaded{caption}{}{\RequirePackage{caption}}
% All captions
\captionsetup{%
    format=hang,
    % singlelinecheck=false,
    font=small,
    labelfont=bf
}

\ifbool{iodhbwm@cls@if@templates}{%
    \@ifpackageloaded{listings}{}{\RequirePackage{listings}}
    % Default settings, color depend on options
    \lstset{
        numbers=left,
        showstringspaces=false,
        tabsize=2,
        breaklines=true,
        xleftmargin=17pt,
        framexleftmargin=17pt,
    }

    \DeclareCaptionFont{DHBWlisting}{\color{DHBW-light}}
    \DeclareCaptionFont{print}{\color{black}}
    \DeclareCaptionFormat{listing}{%
        \colorbox{DHBW-red}{%
            \parbox{\dimexpr\textwidth-2\fboxsep\relax}{#1#2#3}%
        }%
    }

    \DeclareCaptionFormat{listingprint}{%
        \colorbox{white}{%
            \parbox{\dimexpr\textwidth-2\fboxsep\relax}{#1#2#3}%
        }%
    }

    \captionsetup[lstlisting]{%
        format=listing,
        singlelinecheck=false,
        margin=0pt
    }%
    
    \ifbool{iodhbwm@cls@if@print}{%
        \captionsetup[lstlisting]{%
            format=listingprint,
            singlelinecheck=false,
            margin=0pt,
            font={print,sf},
        }%
    
        \lstset{
            basicstyle=\footnotesize\ttfamily\color{DHBW-dark-font},
            backgroundcolor=\color{DHBW-light},
            rulecolor=\color{black},
            commentstyle=\color{DHBW-font},
            keywordstyle=\color{DHBW-dark-font},
            numberstyle=\scriptsize\color{DHBW-font},
            stringstyle=\color{DHBW-dark-font},
            frame=tb,
            captionpos=b,
            aboveskip=\baselineskip
        }%
    }{%
        \captionsetup[lstlisting]{%
            format=listing,
            singlelinecheck=false,
            margin=0pt,
            font={DHBWlisting,sf},
        }%
        
        \lstset{
            basicstyle=\footnotesize\ttfamily\color{DHBW-dark-font},
            backgroundcolor=\color{DHBW-light},
            rulecolor=\color{DHBW-red},
            commentstyle=\color{DHBW-font},
            keywordstyle=\color{DHBW-darkblue},
            numberstyle=\scriptsize\color{DHBW-font},
            stringstyle=\color{purple},
            frame=b,
            captionpos=t,
        }
    }
}{}

% ----------------------------------------------------------
% Auto import titlepage, tocs, ...
% ----------------------------------------------------------
\ifboolexpr{bool {iodhbwm@cls@if@templates} and (bool {iodhbwm@cls@if@auto@intro@custom} or bool {iodhbwm@cls@if@auto@intro@default} or bool {iodhbwm@cls@if@auto@intro@all})}{%
    \ifbool{iodhbwm@cls@if@auto@intro@default}{%
        \dhbwsetup{%
            intro/print all,
            intro/print abstract = false
        }%
    }{}
    \ifbool{iodhbwm@cls@if@auto@intro@all}{%
        \dhbwsetup{intro/print all}%
    }{}
    \AfterEndPreamble{%
        \dhbwprintintro%
    }%
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                           %
%                        BIBLIOGRAPHY                       %
%                                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\iodhbwm@printbibliography}{%
    \ifboolexpr{bool {iodhbwm@cls@if@tocstotoc} and bool {iodhbwm@cls@if@bib@print}}{%
        \printbibliography[heading=bibintoc]%
    }{%
        \ifbool{iodhbwm@cls@if@bib@print}{%
            \printbibliography%
        }{}%
    }%
}

% Load biblatex if option add-bibliography is set
% The bibliography is printed at the end of the document. If the option bib-file is set then
% the class is searching for the given file. Otherwise it try to load dhbw-source.bib.
% If no file is found a warning is thrown.
\ifbool{iodhbwm@cls@if@bib}{%
    \AtEndDocument{%
        \singlespacing%
        
        % Don't print the bibliography again.
        % The appendix takes care about the printing
        % The congiguration is still required
        \ifbool{iodhbwm@cls@if@appendix}{}{%
            \iodhbwm@printbibliography
        }
    }%
    \ifbool{iodhbwm@cls@if@bib@print}{}{\PassOptionsToPackage{hyperref=false}{biblatex}}
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                           %
%                            DEBUG                          %
%                                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\ifbool{iodhbwm@cls@if@isdebug}{%
    \RequirePackage{blindtext, lipsum}
}{}


\endinput
