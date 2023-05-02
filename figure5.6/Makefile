figure5.6.pdf: figure5.6.gnuplot figure5.6.txt
	gnuplot figure5.6.gnuplot
	epstopdf figure5.6.eps
	rm figure5.6.eps
	mv figure5.6.tex figure5.6.pdf_tex

clean:
	rm -f figure5.6.pdf
	rm -f figure5.6.pdf_tex
	rm -f figure5.6.eps
	rm -f figure5.6.tex
