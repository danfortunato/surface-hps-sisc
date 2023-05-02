figure5.1.pdf: figure5.1.gnuplot figure5.1.txt
	gnuplot figure5.1.gnuplot
	epstopdf figure5.1.eps
	rm figure5.1.eps
	mv figure5.1.tex figure5.1.pdf_tex

clean:
	rm -f figure5.1.pdf
	rm -f figure5.1.pdf_tex
	rm -f figure5.1.eps
	rm -f figure5.1.tex
