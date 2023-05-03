set terminal epslatex size 11cm,7cm color colortext
set size ratio 0.9

set xlabel '$1/\Delta t$'
set ylabel '$L^\infty$ relative error' offset 3,0
set logscale x 2
set logscale y 10
set xrange [8:512]
set yrange [3e-9:1]
set style line 1 lc rgb '#0072BD' lw 4 pt 7  ps 1.5 # circle
set style line 2 lc rgb '#D95319' lw 4 pt 5  ps 1.5 # square
set style line 3 lc rgb '#EDB120' lw 4 pt 9  ps 2   # triangle
set style line 4 lc rgb '#7E2F8E' lw 4 pt 13 ps 2   # diamond
set border lw 3
set tics scale 1
set format x "\\footnotesize $2^{%L}$"
set format y "\\footnotesize $10^{%L}$"
set xtics offset 0, 0.2
set ytics offset 0.4, 0
set border behind

# Legend
set key outside reverse Left samplen 3 width -9
set obj 1 rect noclip from screen 0.745, screen 0.705 to screen 0.93, graph 1
set obj 1 fs empty border rgb "black" lw 2
set rmargin 12.6

# Asymptotic dashed lines
dashstart = 2**7
dashend   = 2**9
set samples 2
set style line 5 lc rgb '#000000' lw 4 dashtype (4,4)

# Background grid lines
set grid xtics
set grid ytics
set grid back lt 1 lc rgb "#C8C8C8" lw 1.5

set output 'figure5_8.tex'
file = 'figure5_8.txt'
plot file using 1:2 w lp ls 1 title "\\footnotesize \\hspace{-0.15cm} BDF1",\
     file using 1:3 w lp ls 2 title "\\footnotesize \\hspace{-0.15cm} BDF2",\
     file using 1:4 w lp ls 3 title "\\footnotesize \\hspace{-0.15cm} BDF3",\
     file using 1:5 w lp ls 4 title "\\footnotesize \\hspace{-0.15cm} BDF4",\
     [dashstart:dashend] 1.2/x**1  w l ls 5 notitle,\
     [dashstart:dashend] 7.5/x**2  w l ls 5 notitle,\
     [dashstart:dashend] 90/x**3   w l ls 5 notitle,\
     [dashstart:dashend] 1300/x**4 w l ls 5 notitle
