% -------------------------------- identification ------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hoflet}[2025-10-14]


% -------------------------------- initial code -------------------------



% --------------------------- declaration of options --

% \DeclareOption{cropmarks}{\setboolean{cropmarks}{true}}
% \DeclareOption{bind} {\AtEndOfClass{\addtolength\oddsidemargin{.5in}%
% \addtolength\evensidemargin{-.5in}}}
% \DeclareOption* {\PassOptionsToClass{\CurrentOption}{article}}

% ---------------------------- execution of options ---------------------

% \ProcessOptions \relax % cf. hint on p.700!

% --------------------------------package loading ------------------------

\LoadClass{article} % the real code

\RequirePackage{geometry}
\geometry{letterpaper,driver=luatex,top=2in,bottom=1.5in,hmargin=1in}

\RequirePackage{ragged2e}

% -------------------------------- main code ----------------------------

\AtBeginDocument{%
  \setlength{\parindent}{0pt}%
  \setlength{\parskip}{1em}%
  \RaggedRight%
}

\def\recipient#1{\gdef\@recipient{#1}}
\def\salutation#1{\gdef\@salutation{#1}}
\def\mailingaddress#1{\gdef\@mailingaddress{#1}}

\def\makepreamble{
\noindent \today\par
\vspace{1.5em}
\@mailingaddress\par
\vspace{1em}
Dear~\@salutation{,}\par
\vspace{1em}
}

\def\makesignature{
\vspace{1.5em}
Christopher H.~Eliot
}

\AtBeginDocument{\makepreamble}
\AtEndDocument{\makesignature}