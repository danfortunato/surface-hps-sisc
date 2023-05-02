figure5.pdf: figure5.gnuplot figure5.txt
    gnuplot figure5.gnuplot
    epstopdf figure5.eps
    rm figure5.eps
    mv figure5.tex figure5.pdf_tex

clean:
    rm -f figure5.pdf
    rm -f figure5.pdf_tex
    rm -f figure5.eps
    rm -f figure5.tex
