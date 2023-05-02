figure5.2.pdf: figure5.2.gnuplot figure5.2.txt
	gnuplot figure5.2.gnuplot
	epstopdf figure5.2.eps
	rm figure5.2.eps
	mv figure5.2.tex figure5.2.pdf_tex

clean:
	rm -f figure5.2.pdf
	rm -f figure5.2.pdf_tex
	rm -f figure5.2.eps
	rm -f figure5.2.tex
