figure5_1.pdf: figure5_1.gnuplot figure5_1.txt
	gnuplot figure5_1.gnuplot
	epstopdf figure5_1.eps
	rm figure5_1.eps
	mv figure5_1.tex figure5_1.pdf_tex

clean:
	rm -f figure5_1.pdf
	rm -f figure5_1.pdf_tex
	rm -f figure5_1.eps
	rm -f figure5_1.tex
