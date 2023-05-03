figure5_8.pdf: figure5_8.gnuplot figure5_8.txt
	gnuplot figure5_8.gnuplot
	epstopdf figure5_8.eps
	rm figure5_8.eps
	mv figure5_8.tex figure5_8.pdf_tex

clean:
	rm -f figure5_8.pdf
	rm -f figure5_8.pdf_tex
	rm -f figure5_8.eps
	rm -f figure5_8.tex
