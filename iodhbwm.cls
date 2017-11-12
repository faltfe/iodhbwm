% ----------------------------------------------------------
% iodhbwm class
%
%   inofficial package for DHBW Mannheim to simplify writing
%   theses with the given requirements
% ----------------------------------------------------------
% Felix Faltin
% E-Mail:
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

\newcommand*{\iodhbwm@cls@version}{v0.1}
\newcommand*{\iodhbwm@cls@date}{2017-09-01}
\newcommand*{\iodhbwm@cls@info}{Inoffical DHBW Mannheim thesis class}

\ProvidesClass{iodhbwm}[%
    \iodhbwm@cls@date\space
    \iodhbwm@cls@version\space
    \iodhbwm@cls@info]
    
\RequirePackage{etoolbox, pgfopts, scrlfile}

\newcommand*{\iodhbwm@cls@baseclass}{scrreprt}
\newcommand*{\iodhbwm@cls@baseclass@options}{}

% ----------------------------------------------------------
% Define booleans
% ----------------------------------------------------------
\newbool{iodhbwm@cls@if@preamble}\booltrue{iodhbwm@cls@if@preamble}
\newbool{iodhbwm@cls@if@templates}
%\newbool{iodhbwm@cls@if@toc}
\newbool{iodhbwm@cls@if@bib}
\newbool{iodhbwm@cls@if@tocstotoc}
\newbool{iodhbwm@cls@if@isdebug}

% ----------------------------------------------------------
% Define available options
% ----------------------------------------------------------
\pgfkeys{
    iodhbwm/.cd,
        load-preamble/.is if        = iodhbwm@cls@if@preamble,
        load-dhbw-templates/.is if  = iodhbwm@cls@if@templates,
%        add-toc/.is if              = iodhbwm@cls@if@toc,
        add-tocs-to-toc/.is if      = iodhbwm@cls@if@tocstotoc,
        add-bibliography/.is if     = iodhbwm@cls@if@bib,
        bib-file/.store in          = \iodhbwm@bib@file,
        bib-file = {},
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
    \RequirePackage{babel}
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
}{}

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

\ifbool{iodhbwm@cls@if@bib}{%
    \AfterPackage{inputenc}{\RequirePackage[autostyle]{csquotes}}%
    \AtEndDocument{%
        \singlespacing%
        \ifbool{iodhbwm@cls@if@tocstotoc}{%
            \printbibliography[heading=bibintoc]%
        }{%
            \printbibliography%
        }%
    }%
    \RequirePackage[%
        backend      = biber,           % bibtex oder biber [default]
        style        = numeric-comp,    % Zitierstil
        %            bibstyle     = authortitle,
        %            citestyle    = authoryear,
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
            \ClassWarning{iodhbwm}{Couldn't find passed bib file}
        }%
    }%
    \addbibresource{\iodhbwm@bib@file}%
}{}%

\ifbool{iodhbwm@cls@if@templates}{%
    \RequirePackage{iodhbwm-templates}
}{}

\ifbool{iodhbwm@cls@if@isdebug}{%
    \RequirePackage{blindtext, lipsum}
}{}

\AfterPackage!{hyperref}{%
    \RequirePackage[%
        noabbrev,
        nameinlink
    ]{cleveref}
}
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

\endinput

% ----------------------------------------------------------
% CHANCELOG
% ----------------------------------------------------------