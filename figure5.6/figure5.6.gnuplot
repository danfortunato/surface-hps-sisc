set terminal epslatex size 10cm,5.6cm color colortext
set size ratio 0.9

set logscale x 10
set logscale y 10
set style line 1 lc rgb '#0072BD' lw 4 pt 7  ps 1.5 # circle
set style line 2 lc rgb '#D95319' lw 4 pt 5  ps 1.5 # square
set style line 3 lc rgb '#EDB120' lw 4 pt 9  ps 2   # triangle
set style line 4 lc rgb '#7E2F8E' lw 4 pt 13 ps 2   # diamond
set style line 5 lc rgb '#77AC30' lw 4 pt 11 ps 2   # upside-down triangle
set border lw 3
set tics scale 1
set format x "\\footnotesize $10^{%L}$"
set format y "\\footnotesize $10^{%L}$"
set xtics offset 0, 0.2
set ytics offset 0.4, 0
set border behind

LMARGIN = "set lmargin at screen 0.06; set rmargin at screen 0.45"
RMARGIN = "set lmargin at screen 0.56; set rmargin at screen 0.95"
NOYTICS = "set format y ''; unset ylabel"

# Legend
set key reverse Left at screen 0.75, 0.985 maxrows 1 samplen 3 width -7
set obj 1 rect noclip from screen 0.125, 0.91 to screen 0.885, 0.99
set obj 1 fs empty border rgb "black" lw 2

set tmargin at screen 0.85

# Background grid lines
set grid xtics
set grid ytics
set grid back lt 1 lc rgb "#C8C8C8" lw 1.5

set output 'figure5.6.tex'
set multiplot layout 1,2

file = 'figure5.6.txt'
ext  = 'external.txt'
set xrange [32:2048]
set xlabel '$\nelem$' offset 0,0.3
set yrange [1e-1:1e3]
set ylabel 'Runtime (s)' offset 3.5,0
@LMARGIN
plot file i 0 using 1:2 w lp ls 1 title "Surface HPS",\
     ext  i 0 using 1:2 w lp ls 2 title "MFEM \\texttt{+} UMFPACK"

unset xrange
unset logscale x
set format x "\\footnotesize %g"
unset key
set xtics (4,8,12,16,20)
set xlabel '$p$'
@NOYTICS
@RMARGIN
plot file i 1 using 1:2 w lp ls 1 notitle,\
     ext  i 1 using 1:2 w lp ls 2 notitle
