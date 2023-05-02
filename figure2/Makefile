figure2.pdf: figure2.gnuplot figure2.txt
    gnuplot figure2.gnuplot
    epstopdf figure2.eps
    rm figure2.eps
    mv figure2.tex figure2.pdf_tex

clean:
    rm -f figure2.pdf
    rm -f figure2.pdf_tex
    rm -f figure2.eps
    rm -f figure2.tex
