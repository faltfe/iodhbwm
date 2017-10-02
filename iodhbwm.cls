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

\newbool{iodhbwm@cls@if@preamble}
\newbool{iodhbwm@cls@if@toc}
\newbool{iodhbwm@cls@if@bib}

\pgfkeys{
    iodhbwm/.cd,
        load-preamble/.is if = iodhbwm@cls@if@preamble,
        add-toc/.is if = iodhbwm@cls@if@toc,
        add-bib/.is if = iodhbwm@cls@if@bib
}

\ProcessPgfOptions{/iodhbwm}

\PassOptionsToClass{%
        fontsize=12pt,
        a4paper,
        parskip=half-
}{\iodhbwm@cls@baseclass}
\LoadClass{\iodhbwm@cls@baseclass}

\ifbool{iodhbwm@cls@if@preamble}{%
    \RequirePackage{lmodern}
    \RequirePackage{microtype}
}{}

\ifbool{iodhbwm@cls@if@bib}{%
    \RequirePackage{csquotes}
    \RequirePackage[backend=biber]{biblatex}
%    \addbibresource{bibliographic resource}
}{}

\endinput