figure6.pdf: figure6.gnuplot figure6.txt
    gnuplot figure6.gnuplot
    epstopdf figure6.eps
    rm figure6.eps
    mv figure6.tex figure6.pdf_tex

clean:
    rm -f figure6.pdf
    rm -f figure6.pdf_tex
    rm -f figure6.eps
    rm -f figure6.tex
