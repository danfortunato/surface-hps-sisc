figure5_3.pdf: figure5_3.gnuplot figure5_3.txt
	gnuplot figure5_3.gnuplot
	epstopdf figure5_3.eps
	rm figure5_3.eps
	mv figure5_3.tex figure5_3.pdf_tex

clean:
	rm -f figure5_3.pdf
	rm -f figure5_3.pdf_tex
	rm -f figure5_3.eps
	rm -f figure5_3.tex
