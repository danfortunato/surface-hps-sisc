figure8.pdf: figure8.gnuplot figure8.txt
    gnuplot figure8.gnuplot
    epstopdf figure8.eps
    rm figure8.eps
    mv figure8.tex figure8.pdf_tex

clean:
    rm -f figure8.pdf
    rm -f figure8.pdf_tex
    rm -f figure8.eps
    rm -f figure8.tex
