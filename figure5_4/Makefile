figure5_4.pdf: figure5_4.gnuplot figure5_4.txt
	gnuplot figure5_4.gnuplot
	epstopdf figure5_4.eps
	rm figure5_4.eps
	mv figure5_4.tex figure5_4.pdf_tex

clean:
	rm -f figure5_4.pdf
	rm -f figure5_4.pdf_tex
	rm -f figure5_4.eps
	rm -f figure5_4.tex
