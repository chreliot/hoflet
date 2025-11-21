% -------------------------------- identification ------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{hoflet}[2025-10-14]


% -------------------------------- initial code -------------------------



% --------------------------- declaration of options --

% \DeclareOption{12pt}{\PassOptionsToClass{12pt}{article}}

\DeclareKeys {
  report.if = @hoflet@report 
}

% \DeclareOption{nosignature}{code}

% ---------------------------- execution of options ---------------------

\ProcessKeyOptions

% \ProcessOptions \relax

% --------------------------------package loading ------------------------

\LoadClass{article} % the real code

\RequirePackage{ifthen}

\RequirePackage{geometry}
\geometry{letterpaper,driver=luatex,top=1.5in,bottom=1.5in,hmargin=1.13in}

\RequirePackage{ragged2e}

\RequirePackage{url}

\RequirePackage{graphicx}
\graphicspath{ {../images/} }
\RequirePackage{tikz}

% -------------------------------- main code ----------------------------


% format paragraphs: ragged right, no indenting, and 1 em inter-paragraph spacing

\AtBeginDocument{%
  \setlength{\parindent}{0pt}%
  \setlength{\parskip}{1em}%
  \RaggedRight%
}

% create input commands for the user to store letter information

\def\recipient#1{\gdef\@recipient{#1}}   % e.g., Professor Barbara McClintock
\def\salutation#1{\gdef\@salutation{#1}} % e.g., Dr. McClintock
\def\mailingaddress#1{\gdef\@mailingaddress{#1}} % e.g.,  Cold Spring Harbor Laboratory\\ 1 Bungtown Rd\\ Cold Spring Harbor, NY 11724
\def\myfullname#1{\gdef\@myfullname{#1}} % e.g., Christopher H. ELiot
\def\myposition#1{\gdef\@myposition{#1}} % e.g., Associate Professor

% define two versions opening: date, recipient address, salutation
% first version is with the `report` class option active
% second version is a regular letter with no options

\if@hoflet@report      % `report` class action active
\def\makeopening{%
  \par                          % end any previous paragraph
  \begingroup
   \leftskip=0pt\rightskip=0pt % remove any horizontal glue
   \parindent=0pt           % no first-line indent
   \RaggedRight                % make text flush left
   \noindent\today\par         % the date, flush with left margin
   \vspace{1.5em}
   % \noindent\@recipient\\
   % \noindent\@mailingaddress\par
   % \medskip%
   %  \noindent Dear~\@salutation,\par
   % \medskip%
   \bigskip
  \endgroup
}
\else  
\def\makeopening{%       % without `report` class active — regular letter
  \par                          % end any previous paragraph
  \begingroup
   \leftskip=0pt\rightskip=0pt % remove any horizontal glue
   \parindent=0pt           % no first-line indent
   \RaggedRight                % make text flush left
   \noindent\today\par         % the date, flush with left margin
   \vspace{1.5em}
   \noindent\@recipient\\
   \noindent\@mailingaddress\par
   % \medskip%
   \noindent Dear~\@salutation,\par
   % \medskip%
  \endgroup
}
\fi

% define closing: signature, name affiliation

\def\makeclosing{
\par \vspace{1.5em}
\setlength{\parindent}{0pt}%
\setlength{\parskip}{0pt}%
Respectfully submitted,\par
\includegraphics[alt={the sender's signature},height=2cm]{signature.png}\par
\@myfullname \\ \@myposition
}

% overlay letterhead

\def\makeheader{
\begin{tikzpicture}[remember picture, overlay]
	\node[anchor=north west,inner sep=0,outer sep=0] (header) at (current page.north west) {\includegraphics[alt={Hofstra University letterhead header},width=\paperwidth]{../images/department-header.png}};
\end{tikzpicture}	
}

\def\makefooter{
\begin{tikzpicture}[remember picture, overlay]
	\node[anchor=south west,inner sep=0,outer sep=0] (header) at (current page.south west) {\includegraphics[alt={Hofstra University letterhead footer},width=\paperwidth]{../images/department-footer.png}};
\end{tikzpicture}	
}

\thispagestyle{empty}

\AtBeginDocument{\makeheader}
\AtBeginDocument{\makefooter}
\AtBeginDocument{\makeopening}
\AtEndDocument{\makeclosing}