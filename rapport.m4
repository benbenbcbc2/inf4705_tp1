changequote(`<', `>')

\documentclass[letterpaper,12pt,final]{article}

\usepackage{datatool}

%% For the lab, we want to number the subsections in roman numerals to
%% follow the assignment
\renewcommand{\thesubsection}{\thesection.\roman{subsection}}
\renewcommand{\thesubsubsection}{\thesubsection.\alph{subsubsection}}

%%%%%%%%%%%%%%%%%%%%%%%%
%tmp
\usepackage{color}
\newcommand{\hilight}[1]{\colorbox{yellow}{\parbox{\dimexpr\linewidth-2\fboxsep}{#1}}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Détails de langue pour bien supporter le français
%  Accepte les caractères accentués dans le document (UTF-8).
\usepackage[utf8]{inputenc}
% Police de caractères plus complète et généralement indistinguable
% visuellement de la police standard de LaTeX (Computer Modern).
\usepackage{lmodern}
% Bon encodage des caractères pour que les lecteurs de pdf
% reconnaissent les accents et les ligatures telles que ffi.
\usepackage[T1]{fontenc}
% Règles typographiques et d' "hyphenation" propres aux langues
\usepackage[english,frenchb]{babel}


%%%% Packages pour les références
\usepackage{hyperref}
\usepackage[numbers]{natbib}


%%%% Packages pour l'affichage graphique
% Charge le module d'affichage graphique.
\usepackage{graphicx}
% Recherche des images dans les répertoires.
\graphicspath{{./dia}}
% Un float peut apparaître seulement après sa définition, jamais avant.
\usepackage{flafter}
% Hyperlien vers la figure plutôt que son titre.
\usepackage{caption}
\usepackage{subcaption}
\usepackage{gnuplottex}
\usepackage{geometry}

%% Exemple de figure:
% \begin{figure}[h]
%   \centering
%     \includegraphics[width=\linewidth]{./dia/diagramme.png}
%   \caption{Diagramme de classes du projet}\label{fig:dia_classes}
% \end{figure}



%%%% Packages pour l'affichage de différents types de texte
% Code source:
\usepackage{listings} % Code inline: \lstinline|<code here>|
\lstset{basicstyle=\ttfamily\itshape}
% Symboles mathématiques
\usepackage{amssymb}
% Manipulation de l'espace (page titre)
\usepackage{setspace}
%
% Ligne horizontale pour l'affichage du titre
\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}


%%%% Variables pour le document
% Type de rapport
\newcommand{\monTypeDeRapport}{Rapport de laboratoire}
% Titre du document
\newcommand{\monTitre}{TP1}
% Auteurs
\newcommand{\mesAuteurs}{Premier Auteur, Second Auteur}
\newcommand{\mesAuteursX}{Premier Auteur, XXXXXXX \\ Second Auteur, XXXXXXX}
% Sigle du cours
\newcommand{\monCoursX}{INF4705}
% Nom du cours
\newcommand{\monCours}{Analyse et conception d’algorithmes}


%%%% Informations qui sont stockées dans un fichier PDF.
\hypersetup{
  pdftitle={\monTitre},
  pdfsubject={\monCours},
  pdfauthor={\mesAuteurs},
  bookmarksnumbered,
  pdfstartview={FitV},
  hidelinks,
  linktoc=all
}



\begin{document}
    %% Page titre du rapport
    \begin{titlepage}
      \begin{center}

        \begin{doublespace}

          \vspace*{\fill}
          \textsc{ \large \monTypeDeRapport}
          \vspace*{\fill}

          \HRule \\ [5mm]
          {\huge \bfseries \monTitre}\\ [3mm]
          \HRule \\
          \vspace*{\fill}

          \begin{onehalfspace} \large
            \mesAuteursX
          \end{onehalfspace}

          \vfill
          { \Large Cours \monCoursX \\ \monCours } \\

          \today

        \end{doublespace}
      \end{center}
    \end{titlepage}

\newpage

%% Insertion d'une table des matières
%  Cette ligne peut être enlevée si l'on ne 
%  veut pas de table des matières.
\tableofcontents\newpage

define(bucketit, \textit{bucketsort})
define(Bucketit, \textit{Bucketsort})
define(mergeit, \textit{mergesort})
define(Mergeit, \textit{Mergesort})

\DTLloaddb{thresh}{"./results/thresholds.csv"}

\dtlgetrowindex{\buckrow}{thresh}{1}{bucket}
\DTLgetvalue{\buckthresh}{thresh}{\buckrow}{2}
\dtlgetrowindex{\mergrow}{thresh}{1}{merge}
\DTLgetvalue{\mergthresh}{thresh}{\mergrow}{2}

\section{Introduction}

Dans le but d'apprendre à décider quel algorithme utiliser dans
différentes situations, il est primordial de s'exercer à l'analyse de
ceux-cis.  L'objectif de ce laboratoire est donc de faire l'analyse
selon plusieurs techniques vues en classe d'algorithmes de tri que
nous implémentons nous-mêmes.  Suivant l'introduction de ces
algorithmes ainsi que le cadre expérimental et les données, notre
analyse de ceux-cis sera exposée en utilisant les approches empirique,
théorique et hybride pour finalement décider des situations où chacun
est avantageux.

\section{Algorithmes implémentés}

Les algorithmes implémentés sont deux algorithmes récursifs, soit le
tri par paquets (bucketit) et le tri par fusion (mergeit).  Aussi, on
analyse leur version hybride qui emploie le tri par insertion pour les
exemplaires de petite taille.  En effet, malgré la complexité
supérieure du tri par insertion, ses facteurs constants généralement
inférieurs en font un choix plus rapide pour les petites listes.  Le
seuil auquel on passe de l'algorithme principal au tri par insertion
et l'influence de ce choix seront également étudiés.

Ces algorithmes ne sont pas écrits dans leur version \textit{in~situ},
mais plutôt dans la version qui retourne un nouveau tableau trié, ce
qui rend leur écriture plus simple. (Les versions populaires du
bucketit et du mergeit ne sont pas \textit{in~situ}, mais celles du
tri par insertion le sont souvent.) On ne cherche donc pas à en
particulier à minimiser l'utilisation de la mémoire.

\hilight{Expliquer le layout du projet maybe?}

\section{Cadre expérimental}

Les algorithmes sont implémentés dans le langage \textit{Python 3}.
L'exécution est faite sur les ordinateurs du laboratoire.  En
particulier, les informations concernant le matériel utilisé sont
présentées à la figure~\ref{lst:hardware}.

\begin{figure}[htbp]
  \centering
  \lstinputlisting[breaklines=true]{results/hardware.txt}
  \caption{Matériel utilisé pour l'exécution des chronométrages}\label{lst:hardware}
\end{figure}

Afin d'améliorer la précision des mesures de temps, il pourrait être
préférable de changer la politique de changement de fréquence des
processeurs pour qu'elle assure une fréquence constante.  En effet, on
utilise la fonction \lstinline|time.process_time()| de Python, qui
donne la somme du temps du côté utilisateur et noyau et ainsi ce temps
est obtenu en prenant le compte des \textit{ticks} de processeur
divisé par la fréquence actuelle \cite{PEP418}.  Alors, si cette
fréquence change entre les mesures, cela peut avoir un effet sur les
temps mesurés.  Cependant, les permissions accordées aux étudiants
dans les laboratoires ne permettent pas de changer cette
configuration.

% see https://wiki.archlinux.org/index.php/CPU_frequency_scaling

\section{Jeux de données}

\hilight{TODO}

\section{Résultats}

Les résultats sont présentés dans la figure~\ref{lst:results}.  Ils
montrent les fichiers obtenus par nos bancs d'essais.  La première
colonne donne la taille des exemplaires utilisés pour le
chronométrage, et les colonnes suivantes correspondent aux moyennes de
temps d'exécution (en secondes) pour les différents groupes
d'exemplaires de la taille donnée.  Il y a un fichier de résultats par
algorithme et seuil de récursivité.

\begin{figure}[p]
  \centering
  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/bucket.dat}
    \caption{bucketit}
  \end{subfigure}

  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/bucketSeuil.dat}
    \caption{bucketit avec seuil de récursivité}
  \end{subfigure}

  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/merge.dat}
    \caption{mergeit}
  \end{subfigure}

  \begin{subfigure}[htbp]{\textwidth}
    \centering
    \lstinputlisting[breaklines=true]{results/mergeSeuil.dat}
    \caption{mergeit avec seuil de récursivité}
  \end{subfigure}
  \caption{Fichiers de résultats}\label{lst:results}
\end{figure}

\section{Analyse}

Les résultats obtenus à la section précédente sont analysés ici selon
les diverses méthodes vues en cours.

\subsection{Tests de puissance}

Les tests de puissance nous permettent d'estimer le degré de la
fonction de complexité s'il s'agit d'un polynôme ou bien de constater
que la complexité est super-polynômiale ou sub-linéaire.

%define(<powertest>, <
\subsubsection{$3}
\begin{figure}[htbp]
  \centering
  \begin{gnuplot}[terminal=epslatex, terminaloptions=color dashed]
    set print $2
    print "Série, m, b"
    g(x) = 10**b*x**m
    fit g(x) $1 u 1:2 via m,b
    print "0-9,",m,",", b
    fit g(x) $1 u 1:3 via m,b
    print "10-19,",m,",", b
    fit g(x) $1 u 1:4 via m,b
    print "20-29,",m,",", b

    set grid
    set xlabel "Taille des exemplaires à trier [-]"
    set ylabel "Temps d'exécution [s]"
    set logscale xy
    set key center top
    plot $1 u 1:2 w linesp t "Série [ 0- 9]",\
    $1 u 1:3 w linesp t "Série [10-19]",\
    $1 u 1:4 w linesp t "Série [20-29]",\
    g(x) w l t "Régression"
  \end{gnuplot}
  \caption{Tests de puissance pour $3}\label{fig:$4}
\end{figure}

\DTLloaddb{powerdb}{$2}

\begin{table}[htbp]
  \centering
  \DTLdisplaydb{powerdb}
  \caption{Résultats des tests de puissance pour $3}\label{tbl:$4}
\end{table}

\DTLmeanforcolumn{powerdb}{m}{\meanm}
\DTLmeanforcolumn{powerdb}{b}{\meanb}
\DTLdeletedb{powerdb}

Le graphique log-log des temps d'exécution pour l'algorithme $3 est
affiché à la figure \ref{fig:$4}. En faisant une régression linéaire
sur les points en coordonnées log-log, ou, autrement dit, en faisant
une régression avec une fonction de la forme $f(x) = 10^b \cdot x^m$,
on obtient les valeurs consignées au tableau \ref{tbl:$4}.

La fonction trouvée est donc (en prenant les moyennes) :
$$f(x) = 10^{\meanb} \cdot x^{\meanm}$$.
%>)

powertest("./results/bucket.dat", "./results/bucket_fit.csv", <bucketit>, powbuck)

Le degré est donc très près de 1 et on peut s’attendre à ce que la
complexité s’approche de $O(n)$.

powertest("./results/bucketSeuil.dat", "./results/bucketSeuil_fit.csv", <bucketit avec seuil de \buckthresh{} >, powbucks)

Les résultats sont similaires à ceux du bucketit sans récursivité,
mais le coefficient constant est inférieur et la puissance est un peu
supérieure.  Cela suggère toujours une complexité $O(n)$, cependant
avec un coefficient constant plus bas.

powertest("./results/merge.dat", "./results/merge_fit.csv", <mergeit>, powmerg)

On a obtenu un $m$ un peu supérieur encore, mais toujours proche de 1.
Étant donné que l'exposant est inférieur à 2, on se doute que la
complexité est bornée supérieurement avec $O(n^2)$.  On peut se douter
qu'elle doit être supérieure à $O(n)$ et qu'elle est peut-être près de
$O(n\cdot{}log(n))$.

powertest("./results/mergeSeuil.dat", "./results/mergeSeuil_fit.csv", <mergeit avec seuil de \mergthresh{} >, powmergs)

Similairement au cas avec seuil du bucketit, le mergeit avec seuil a
une constante multiplicative inférieure et un exposant très semblable
à son équivalenet sans seuil de récursivité.  Ainsi, il doit être de
la même complexité et généralement plus rapide.

\subsection{Complexités théoriques}

Pour le bucketit, la consommation théorique en meilleur cas et en cas
moyen (pour un tableau uniformément distribué) est de $\Theta(n+k)$ où
$k$ est le nombre de récipients. Dans notre code, le nombre de
récipients est égal au nombre d’éléments, et donc on a $\Theta(n)$. Le
pire cas est de $O(n^2)$ dans le cas où la plupart des élément se
retrouvent toujours dans le même récipient.

Pour le mergeit, la consommation théorique en meilleure cas, en pire
cas et en cas moyen est de $\Theta(n*log(n))$.

\subsection{Test du rapport}

%define(<ratiotest>, <
\begin{figure}[htbp]
  \centering
  \begin{gnuplot}[scale=0.8, terminal=epslatex, terminaloptions=color dashed]
    f(x) = $5
    set grid
    set xlabel "Taille des exemplaires à trier [-]"
    set ylabel "Rapport du $y/f(x)$ pour $f(x) = $6$ [-]"
    set key center top
    set format y '%g'
    set xtics 1e5
    plot $1 u 1:($<>2/f($<>1)) w linesp t "Série [ 0- 9]",\
    $1 u 1:($<>3/f($<>1)) w linesp t "Série [10-19]",\
    $1 u 1:($<>4/f($<>1)) w linesp t "Série [20-29]"
  \end{gnuplot}
  \caption{Tests du rapport pour $3}\label{fig:$4}
\end{figure}
%>)

\subsubsection{bucketit}

Comme on peut le voir à la figure \ref{fig:ratiobuckba}, pour toutes
les séries, le ratio du temps d'exécution à la fonction d'ordre de
complexité au meilleur et moyen cas semble converger à une valeur plus
grande que $0$.  Cette fonction paraît être une bonne estimation.
Cependant, pour ce qui est du pire cas, le ratio converge vers $0$, ce
qui est clair à la figure \ref{fig:ratiobuckw}. C'est alors une
surestimation.

ratiotest("./results/bucket.dat", ,<bucketit au meilleur cas et au cas moyen>, <ratiobuckba>, <x>, <x>)

ratiotest("./results/bucket.dat", ,<bucketit au pire cas>, <ratiobuckw>, <x**2>, <x^2>)

\subsubsection{bucketit avec seuil de \buckthresh}

Comme le montre la figure \ref{fig:ratiobucksba}, le ratio pour
bucketit avec seuil au meilleur et moyen cas paraît éventuellement
converger à une valeur supérieure à $0$.  Cette fonction paraît être
une bonne estimation.  Cependant, pour ce qui est du pire cas, le
ratio converge vers $0$, cela est visible à la figure
\ref{fig:ratiobucksw}. Cette fonction est une surestimation.

ratiotest("./results/bucketSeuil.dat", ,<bucketit avec seuil de \buckthresh{} au meilleur cas et au cas moyen>, <ratiobucksba>, <x>, <x>)

ratiotest("./results/bucketSeuil.dat", ,<bucketit avec seuil de \buckthresh{} au pire cas>, <ratiobucksw>, <x**2>, <x^2>)

\subsubsection{mergeit}

Le graphe à la figure \ref{fig:ratiomerg} montre la convergence du
rapport pour le mergit.  L'estimation est sensée.

ratiotest("./results/merge.dat", ,<mergeit au meilleur cas, au cas moyen et au pire cas>, <ratiomerg>, <x*log(x)>, <x*log(x)>)

\subsubsection{mergeit avec seuil de \mergthresh}

L'estimation est probablement correcte puisque le graphe du rapport
pour l'algorithme mergeit avec seuil converge, comme on le constate à
la figure \ref{fig:ratiomergs}.

ratiotest("./results/mergeSeuil.dat", ,<mergeit avec seuil de \mergthresh{} au meilleur cas, au cas moyen et au pire cas>, <ratiomergs>, <x*log(x)>, <x*log(x)>)

\subsection{Test des constantes}

%define(<constest>, <
\subsubsection{$3}
\begin{figure}[htbp]
  \centering
  \begin{gnuplot}[scale=0.8, terminal=epslatex, terminaloptions=color dashed]
    f(x) = $5
    g(x) = a*f(x) + b

    set print $2
    print "Série, a, b"
    fit g(x) $1 u 1:2 via a,b
    print "0-9,",gprintf('%.10f',a),",", b
    fit g(x) $1 u 1:3 via a,b
    print "10-19,",gprintf('%.10f',a),",", b
    fit g(x) $1 u 1:4 via a,b
    print "20-29,",gprintf('%.10f',a),",", b
    h(x) = a*x + b

    set grid
    set xlabel "$f(x)$ avec $f(x) = $6$ [-]"
    set ylabel "Temps d'exécution moyen de l'algorithme [s]"
    set key center top
    set format y '%g'
    set format x '%g'
    plot $1 u (f($<>1)):2 w linesp t "Série [ 0- 9]",\
    $1 u (f($<>1)):3 w linesp t "Série [10-19]",\
    $1 u (f($<>1)):4 w linesp t "Série [20-29]",\
    h(x) w l t "Régression (série [20-29])"
  \end{gnuplot}
  \caption{Tests des constantes pour $3}\label{fig:$4}
\end{figure}

\DTLloaddb{constdb}{$2}

\begin{table}[htbp]
  \centering
  \DTLdisplaydb{constdb}
  \caption{Résultats des tests de constante pour $3}\label{tbl:$4}
\end{table}

\DTLmeanforcolumn{constdb}{a}{\meana}
\DTLmeanforcolumn{constdb}{b}{\meanb}
\DTLdeletedb{constdb}

La figure \ref{fig:$4} montre les courbes du test et le tableau
\ref{tbl:$4} donne les valeurs de pente $a$ et d'ordonnée à l'origine
$b$ pour chaque régression linéaire. En moyenne, on obtient la
fonction de coût en secondes selon la grandeur du tableau d'entrée
$C$: $$C(x) = \meana \cdot{} ($6) + (\meanb)$$
%>)

constest("./results/bucket.dat","./results/bucket_constfit.csv",<bucketit au meilleur cas et au cas moyen>, <constbuck>, <x>, <x>)

\hilight{Discutez des résultats obtenus}

constest("./results/bucketSeuil.dat","./results/bucketSeuil_constfit.csv",<bucketit avec seuil de \buckthresh{} au meilleur cas et au cas moyen>, <constbucks>, <x>, <x>)

\hilight{Discutez des résultats obtenus}

constest("./results/merge.dat","./results/merge_constfit.csv",<mergeit au meilleur cas, au cas moyen et au pire cas>, <constmerg>, <x*log(x)>, <x*log(x)>)

\hilight{Discutez des résultats obtenus}

constest("./results/mergeSeuil.dat","./results/mergeSeuil_constfit.csv",<mergeit avec seuil de \mergthresh{} au meilleur cas, au cas moyen et au pire cas>, <constmergs>, <x*log(x)>, <x*log(x)>)

\hilight{Discutez des résultats obtenus}

\subsection{Choix du seuil de récursivité}



\section{Discussion}

\section{Conclusion}


\bibliographystyle{plainnat} %% or perhaps IEEEtranN
\bibliography{rapport}

\end{document}
