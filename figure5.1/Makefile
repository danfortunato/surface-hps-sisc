figure1.pdf: figure1.gnuplot figure1.txt
    gnuplot figure1.gnuplot
    epstopdf figure1.eps
    rm figure1.eps
    mv figure1.tex figure1.pdf_tex

clean:
    rm -f figure1.pdf
    rm -f figure1.pdf_tex
    rm -f figure1.eps
    rm -f figure1.tex
