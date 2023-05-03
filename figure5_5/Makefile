figure5_5.pdf: figure5_5.gnuplot figure5_5.txt
	gnuplot figure5_5.gnuplot
	epstopdf figure5_5.eps
	rm figure5_5.eps
	mv figure5_5.tex figure5_5.pdf_tex

clean:
	rm -f figure5_5.pdf
	rm -f figure5_5.pdf_tex
	rm -f figure5_5.eps
	rm -f figure5_5.tex
