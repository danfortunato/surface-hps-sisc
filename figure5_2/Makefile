figure5_2.pdf: figure5_2.gnuplot figure5_2.txt
	gnuplot figure5_2.gnuplot
	epstopdf figure5_2.eps
	rm figure5_2.eps
	mv figure5_2.tex figure5_2.pdf_tex

clean:
	rm -f figure5_2.pdf
	rm -f figure5_2.pdf_tex
	rm -f figure5_2.eps
	rm -f figure5_2.tex
