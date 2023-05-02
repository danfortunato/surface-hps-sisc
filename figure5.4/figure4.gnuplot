set terminal epslatex size 11.5cm,6cm color colortext
set size ratio 0.9

set logscale x 10
set logscale y 10
set style line 1 lc rgb '#0072BD' lw 4 pt 7  ps 1.5 # circle
set style line 2 lc rgb '#D95319' lw 4 pt 5  ps 1.5 # square
set style line 3 lc rgb '#EDB120' lw 4 pt 9  ps 2   # triangle
set style line 4 lc rgb '#7E2F8E' lw 4 pt 13 ps 2   # diamond
set style line 5 lc rgb '#77AC30' lw 4 pt 11 ps 2   # upside-down triangle
set border 31 behind lw 3
set tics scale 1
set format x "\\footnotesize $10^{%L}$"
set format y "\\footnotesize $10^{%L}$"
set xtics offset 0, 0.2
set ytics offset 0.4, 0

LMARGIN = "set lmargin at screen 0.06; set rmargin at screen 0.45"
RMARGIN = "set lmargin at screen 0.6; set rmargin at screen 0.95"
NEXTKEY = "unset tics; unset xtics; unset ytics; unset xlabel; unset ylabel; unset border"

# Legend
set key reverse Left at screen 0.57, 0.98 maxrows 1 samplen 3 width -5
set obj 1 rect noclip from screen 0.15, 0.91 to screen 0.83, 0.99
set obj 1 fs empty border rgb "black" lw 2

set tmargin at screen 0.83
set bmargin at screen 0.23

# Background grid lines
set grid xtics
set grid ytics
set grid back lt 1 lc rgb "#C8C8C8" lw 1.5

# Asymptotic dashed lines
set samples 2
set style line 6 lc rgb '#000000' lw 4 dashtype (4,4)

set output 'figure4.tex'
set multiplot layout 1,2
file = 'figure4.txt'

set xrange [3:1e4]
set yrange [1e-3:1e2]
set xlabel '$\nelem$' offset 0,0.3
set ylabel 'Runtime (s)' offset 3.5,0
@LMARGIN
set key reverse Left at screen 0.425, 0.98 maxrows 1 samplen 3
plot file using 1:($2+$3) w lp ls 1 title "Factorization",\
     [250:6400] 1e-2*x w l ls 6 notitle

@NEXTKEY
set key reverse Left at screen 0.54, 0.98 maxrows 1 samplen 3
plot file using 1:4 w lp ls 2 title "Solve"

@NEXTKEY
set key reverse Left at screen 0.74, 0.98 maxrows 1 samplen 3
plot file using 1:5 w lp ls 3 title "Update"

@RMARGIN
set xtics offset 0, 0.2
set ytics offset 0.4, 0
set border 31 behind lw 3
set yrange [1e-3:1e2]
set xlabel '$\nelem$' offset 0,0.3
set ylabel 'Memory (GB)' offset 3.7,0
plot file using 1:6 w lp ls 1 notitle,\
     [250:6400] 2e-3*x w l ls 6 notitle
