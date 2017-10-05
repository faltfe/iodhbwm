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
    
\RequirePackage{etoolbox, pgfopts}

\newcommand*{\iodhbwm@cls@baseclass}{scrreprt}
\newcommand*{\iodhbwm@cls@baseclass@options}{}

\newbool{iodhbwm@cls@if@preamble}
\newbool{iodhbwm@cls@if@templates}
\newbool{iodhbwm@cls@if@nodefaultsettings}
%\newbool{iodhbwm@cls@if@toc}
\newbool{iodhbwm@cls@if@bib}
\newbool{iodhbwm@cls@if@tocstotoc}
\newbool{iodhbwm@cls@if@isdebug}

\pgfkeys{
    iodhbwm/.cd,
        load-preamble/.is if        = iodhbwm@cls@if@preamble,
        load-dhbw-templates/.is if  = iodhbwm@cls@if@templates,
%        add-toc/.is if              = iodhbwm@cls@if@toc,
        add-bibliography/.is if     = iodhbwm@cls@if@bib,
        add-tocs-to-toc/.is if      = iodhbwm@cls@if@tocstotoc,
        bib-file/.store in          = \iodhbwm@bib@file,
        bib-file = \relax,
        no-default-settings/.is if  = iodhbwm@cls@if@nodefaultsettings,
        debug/.is if                = iodhbwm@cls@if@isdebug,
        unknown/.code               = \edef\iodhbwm@cls@baseclass@options{\iodhbwm@cls@baseclass@options,\pgfkeyscurrentname}
}

\ProcessPgfOptions{/iodhbwm}

\ifbool{iodhbwm@cls@if@nodefaultsettings}{}{%
    \PassOptionsToClass{%
            fontsize=12pt,
            a4paper,
            parskip=half-
    }{\iodhbwm@cls@baseclass}
}

\LoadClass[\iodhbwm@cls@baseclass@options]{\iodhbwm@cls@baseclass}

\ifbool{iodhbwm@cls@if@preamble}{%
    \RequirePackage{lmodern}
    \RequirePackage{microtype}
}{}

\ifbool{iodhbwm@cls@if@bib}{%
    \RequirePackage{csquotes}
    \RequirePackage[backend=biber]{biblatex}
    \IfFileExists{\iodhbwm@bib@file}{}{}
}{}

\ifbool{iodhbwm@cls@if@templates}{%
    \RequirePackage{iodhbwm}
}{}

\endinput

% ----------------------------------------------------------
% CHANCELOG
% ----------------------------------------------------------