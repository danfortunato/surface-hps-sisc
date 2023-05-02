figure5.8.pdf: figure5.8.gnuplot figure5.8.txt
	gnuplot figure5.8.gnuplot
	epstopdf figure5.8.eps
	rm figure5.8.eps
	mv figure5.8.tex figure5.8.pdf_tex

clean:
	rm -f figure5.8.pdf
	rm -f figure5.8.pdf_tex
	rm -f figure5.8.eps
	rm -f figure5.8.tex
