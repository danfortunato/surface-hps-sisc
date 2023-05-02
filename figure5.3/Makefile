figure5.3.pdf: figure5.3.gnuplot figure5.3.txt
	gnuplot figure5.3.gnuplot
	epstopdf figure5.3.eps
	rm figure5.3.eps
	mv figure5.3.tex figure5.3.pdf_tex

clean:
	rm -f figure5.3.pdf
	rm -f figure5.3.pdf_tex
	rm -f figure5.3.eps
	rm -f figure5.3.tex
