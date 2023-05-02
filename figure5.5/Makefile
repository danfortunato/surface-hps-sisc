figure5.5.pdf: figure5.5.gnuplot figure5.5.txt
	gnuplot figure5.5.gnuplot
	epstopdf figure5.5.eps
	rm figure5.5.eps
	mv figure5.5.tex figure5.5.pdf_tex

clean:
	rm -f figure5.5.pdf
	rm -f figure5.5.pdf_tex
	rm -f figure5.5.eps
	rm -f figure5.5.tex
