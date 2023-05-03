figure5_6.pdf: figure5_6.gnuplot figure5_6.txt
	gnuplot figure5_6.gnuplot
	epstopdf figure5_6.eps
	rm figure5_6.eps
	mv figure5_6.tex figure5_6.pdf_tex

clean:
	rm -f figure5_6.pdf
	rm -f figure5_6.pdf_tex
	rm -f figure5_6.eps
	rm -f figure5_6.tex
