set terminal epslatex size 8cm,5.6cm color colortext
set size ratio 0.9

set xlabel '$1/h$'
set ylabel '\small $L^\infty$ relative error' offset 4,0
set logscale x 2
set logscale y 10
set xrange [2:64]
set yrange [1e-12:1]
set style line 1 lc rgb '#0072BD' lw 4 pt 7  ps 1.5 # circle
set style line 2 lc rgb '#D95319' lw 4 pt 5  ps 1.5 # square
set style line 3 lc rgb '#EDB120' lw 4 pt 9  ps 2   # triangle
set style line 4 lc rgb '#7E2F8E' lw 4 pt 13 ps 2   # diamond
set style line 5 lc rgb '#77AC30' lw 4 pt 11 ps 2   # upside-down triangle
set border lw 3
set tics scale 1
set format x "\\footnotesize $2^{%L}$"
set format y "\\footnotesize $10^{%L}$"
set xtics offset 0, 0.2
set ytics offset 0.4, 0
set lmargin 0
set border behind

# Legend
set key outside reverse Left samplen 3 width -14.7
set obj 1 rect noclip from screen 0.7, screen 0.5 to screen 0.985, graph 1
set obj 1 fs empty border rgb "black" lw 2
set rmargin 6.5

# Asymptotic dashed lines
set samples 2
set style line 6 lc rgb '#000000' lw 4 dashtype (4,4)

# Background grid lines
set grid xtics
set grid ytics
set grid back lt 1 lc rgb "#C8C8C8" lw 1.5

set output 'figure1.tex'
file = 'figure1.txt'
plot file using 1:2 w lp ls 1 title "\\footnotesize \\hspace{-0.15cm} $p=4$",\
     file using 1:3 w lp ls 2 title "\\footnotesize \\hspace{-0.15cm} $p=8$",\
     file using 1:4 w lp ls 3 title "\\footnotesize \\hspace{-0.15cm} $p=12$",\
     file using 1:5 w lp ls 4 title "\\footnotesize \\hspace{-0.15cm} $p=16$",\
     file using 1:6 w lp ls 5 title "\\footnotesize \\hspace{-0.15cm} $p=20$",\
     [25:64] 4e3/x**(4-1) w l ls 6 title "\\footnotesize \\hspace{-0.15cm} $\\mathcal{O}(h^{p-1})$",\
     [27:64] 5e5/x**(8-1) w l ls 6 notitle,\
     [17:39] 4e6/x**(12-1) w l ls 6 notitle,\
     [9:17] 5e6/x**(16-1) w l ls 6 notitle,\
     [4.5:8] 5e4/x**(20-1) w l ls 6 notitle
