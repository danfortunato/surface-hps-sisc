figure3.pdf: figure3.gnuplot figure3.txt
    gnuplot figure3.gnuplot
    epstopdf figure3.eps
    rm figure3.eps
    mv figure3.tex figure3.pdf_tex

clean:
    rm -f figure3.pdf
    rm -f figure3.pdf_tex
    rm -f figure3.eps
    rm -f figure3.tex
