figure5.4.pdf: figure5.4.gnuplot figure5.4.txt
	gnuplot figure5.4.gnuplot
	epstopdf figure5.4.eps
	rm figure5.4.eps
	mv figure5.4.tex figure5.4.pdf_tex

clean:
	rm -f figure5.4.pdf
	rm -f figure5.4.pdf_tex
	rm -f figure5.4.eps
	rm -f figure5.4.tex
