figure4.pdf: figure4.gnuplot figure4.txt
    gnuplot figure4.gnuplot
    epstopdf figure4.eps
    rm figure4.eps
    mv figure4.tex figure4.pdf_tex

clean:
    rm -f figure4.pdf
    rm -f figure4.pdf_tex
    rm -f figure4.eps
    rm -f figure4.tex
