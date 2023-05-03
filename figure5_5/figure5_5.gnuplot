set terminal epslatex size 9.7cm,6.7cm color colortext
set size ratio 0.9

set xlabel '\small Runtime (s)' offset 0,0.2
set ylabel '\small $L^\infty$ relative error' offset 4,0
set logscale x 10
set logscale y 10
set xrange [1e-2:1.2e2]
set yrange [1e-12:1]
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
set lmargin 8
set rmargin 3
set tmargin 3.4

# Legend
set key reverse Left at screen 0.82, 0.985 maxrows 2 samplen 3 width -8.5
set obj 1 rect noclip from screen 0.15, 0.855 to screen 0.92, 0.99
set obj 1 fs empty border rgb "black" lw 2

# Background grid lines
set grid xtics
set grid ytics
set grid back lt 1 lc rgb "#C8C8C8" lw 1.5

set output 'figure5_5.tex'
file = 'figure5_5.txt'
ext  = 'external.txt'
plot file using 1:2 w lp ls 1 title "\\footnotesize Surface HPS",\
     ext  using 3:4 w lp ls 3 title "\\footnotesize Pseudospectral",\
     ext  using 1:2 w lp ls 2 title "\\footnotesize MFEM \\texttt{+} UMFPACK",\
     ext  using 5:6 w lp ls 4 title "\\footnotesize Layer potential",\
