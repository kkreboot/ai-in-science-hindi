#!/usr/bin/perl
# Usage: perl preprocess.pl <chapnum> < in.tex > out.tex
use strict; use warnings;
my $chap = shift @ARGV // "00";
local $/; my $t = <STDIN>;

# --- strip layout / no-op commands ---
$t =~ s/\\thispagestyle\{[^}]*\}//g;
$t =~ s/\\pagestyle\{[^}]*\}//g;
$t =~ s/\\markboth\{[^}]*\}\{[^}]*\}//g;
$t =~ s/\\addcontentsline\{[^}]*\}\{[^}]*\}\{[^}]*\}//g;
$t =~ s/\\cleardoublepage//g; $t =~ s/\\clearpage//g; $t =~ s/\\newpage//g;
$t =~ s/\\null//g; $t =~ s/\\vfill//g;
$t =~ s/\\vspace\*?\{[^}]*\}//g;
$t =~ s/\\setlength\{[^}]*\}\{[^}]*\}//g;

# --- tikz figures -> rendered PNG (per-chapter counter, same order as extraction) ---
my $idx = 0;
$t =~ s/\\begin\{tikzpicture\}.*?\\end\{tikzpicture\}/"\\includegraphics[width=0.8\\linewidth]{epub\/img\/fig-$chap-".(++$idx).".png}"/sge;

# --- code listings ---
$t =~ s/\\begin\{lstlisting\}/\\begin{verbatim}/g;
$t =~ s/\\end\{lstlisting\}/\\end{verbatim}/g;

# --- \term{hi}{en} -> bold hi (en) ---
$t =~ s/\\term\{([^{}]*)\}\{([^{}]*)\}/\\textbf{$1} ($2)/g;
$t =~ s/\\eterm\{([^{}]*)\}/\\textbf{$1}/g;
# --- image source credit ---
$t =~ s/\\imgsrc\{([^{}]*)\}/ \\textit{(स्रोत: $1)}/g;
# --- chapter-objectives heading ---
$t =~ s/\\lakshyaheading/\\subsection*{इस अध्याय में आप सीखेंगे}/g;
# --- fill-in-the-blank rules -> visible blank ---
$t =~ s/\\rule\{[^}]*\}\{[^}]*\}/＿＿＿＿＿＿/g;
# --- drop labels & cross-refs (no auto numbering in epub) ---
$t =~ s/\\label\{[^}]*\}//g;
$t =~ s/~?\\ref\{[^}]*\}//g;
$t =~ s/~?\\pageref\{[^}]*\}//g;

# --- coloured boxes -> blockquote with a bold label ---
$t =~ s/\\begin\{jante\}/\\begin{quote}\n\\textbf{क्या आप जानते हैं?}\\\\\n/g;
$t =~ s/\\end\{jante\}/\n\\end{quote}/g;
$t =~ s/\\begin\{sochiye\}/\\begin{quote}\n\\textbf{सोचिए}\\\\\n/g;
$t =~ s/\\end\{sochiye\}/\n\\end{quote}/g;
$t =~ s/\\begin\{padhe\}/\\begin{quote}\n\\textbf{अग्रिम पठन एवं स्रोत}\\\\\n/g;
$t =~ s/\\end\{padhe\}/\n\\end{quote}/g;
$t =~ s/\\begin\{gatividhi\}\[([^\]]*)\]/\\begin{quote}\n\\textbf{गतिविधि — $1}\\\\\n/g;
$t =~ s/\\begin\{gatividhi\}/\\begin{quote}\n\\textbf{गतिविधि}\\\\\n/g;
$t =~ s/\\end\{gatividhi\}/\n\\end{quote}/g;
$t =~ s/\\begin\{pariyojana\}\[([^\]]*)\]/\\begin{quote}\n\\textbf{परियोजना — $1}\\\\\n/g;
$t =~ s/\\begin\{pariyojana\}/\\begin{quote}\n\\textbf{परियोजना}\\\\\n/g;
$t =~ s/\\end\{pariyojana\}/\n\\end{quote}/g;

# --- new feature boxes -> blockquote with label ---
$t =~ s/\\begin\{mukhyashabd\}/\\begin{quote}\n\\textbf{मुख्य शब्द (Key Terms)}\\\\\n/g;
$t =~ s/\\end\{mukhyashabd\}/\n\\end{quote}/g;
$t =~ s/\\begin\{bharatai\}/\\begin{quote}\n\\textbf{भारत में AI (AI in India)}\\\\\n/g;
$t =~ s/\\end\{bharatai\}/\n\\end{quote}/g;
# self-check quiz + colab links -> a simple labelled line with the URL
$t =~ s/\\selfcheckqr\{([^{}]*)\}/\\par\\textbf{स्वयं जाँचें (Self-check Quiz):} \\url{$1}\\par/g;
$t =~ s/\\colabnb\{([^{}]*)\}/\\par\\textbf{Colab notebook:} \\url{$1}\\par/g;

# --- MCQ / choices -> nested lists ---
$t =~ s/\\begin\{mcq\}/\\begin{enumerate}/g;
$t =~ s/\\end\{mcq\}/\\end{enumerate}/g;
$t =~ s/\\begin\{choices\}/\\begin{itemize}/g;
$t =~ s/\\end\{choices\}/\\end{itemize}/g;

print $t;
