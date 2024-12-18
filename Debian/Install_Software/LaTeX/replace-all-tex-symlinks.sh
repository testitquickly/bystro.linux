#!/bin/bash

    # последовательно удаляем симлинки и хардлинки на основной LaTeX
    # и создаём симлинки на /opt/LaTeX/…

    # запускать через sudo

rm -f /usr/bin/tex
ln -s /opt/LaTeX/bin/x86_64-linux/tex /usr/bin/tex
ls -l /usr/bin/tex

rm -f /usr/bin/latex
ln -s /opt/LaTeX/bin/x86_64-linux/latex /usr/bin/latex
ls -l /usr/bin/latex

rm -f /usr/bin/pdftex
ln -s /opt/LaTeX/bin/x86_64-linux/pdftex /usr/bin/pdftex
ls -l /usr/bin/pdftex

rm -f /usr/bin/pdflatex
ln -s /opt/LaTeX/bin/x86_64-linux/pdflatex /usr/bin/pdflatex
ls -l /usr/bin/pdflatex

rm -f /usr/bin/makeindex
ln -s /opt/LaTeX/bin/x86_64-linux/makeindex /usr/bin/makeindex
ls -l /usr/bin/makeindex

rm -f /usr/bin/dvips
ln -s /opt/LaTeX/bin/x86_64-linux/dvips /usr/bin/dvips
ls -l /usr/bin/dvips

rm -f /usr/bin/dvipng
ln -s /opt/LaTeX/bin/x86_64-linux/dvipng /usr/bin/dvipng
ls -l /usr/bin/dvipng

rm -f /usr/bin/dvipdfmx
ln -s /opt/LaTeX/bin/x86_64-linux/dvipdfmx /usr/bin/dvipdfmx
ls -l /usr/bin/dvipdfmx

rm -f /usr/bin/bibtex
ln -s /opt/LaTeX/bin/x86_64-linux/bibtex /usr/bin/bibtex
ls -l /usr/bin/bibtex

rm -f /usr/bin/xelatex
ln -s /opt/LaTeX/bin/x86_64-linux/xelatex /usr/bin/xelatex
ls -l /usr/bin/xelatex

rm -f /usr/bin/biber
ln -s /opt/LaTeX/bin/x86_64-linux/biber /usr/bin/biber
ls -l /usr/bin/biber

rm -f /usr/bin/kpsepath
ln -s /opt/LaTeX/bin/x86_64-linux/kpsepath /usr/bin/kpsepath
ls -l /usr/bin/kpsepath

rm -f /usr/bin/kpsewhich
ln -s /opt/LaTeX/bin/x86_64-linux/kpsewhich /usr/bin/kpsewhich
ls -l /usr/bin/kpsewhich

rm -f /usr/bin/makeglossaries
ln -s /opt/LaTeX/bin/x86_64-linux/makeglossaries /usr/bin/makeglossaries
ls -l /usr/bin/makeglossaries

rm -f /usr/bin/updmap
ln -s /opt/LaTeX/bin/x86_64-linux/updmap /usr/bin/updmap
ls -l /usr/bin/updmap

rm -f /usr/bin/xetex
ln -s /opt/LaTeX/bin/x86_64-linux/xetex /usr/bin/xetex
ls -l /usr/bin/xetex

rm -f /usr/bin/eptex
ln -s /opt/LaTeX/bin/x86_64-linux/eptex /usr/bin/eptex
ls -l /usr/bin/eptex

rm -f /usr/bin/xdvipdfmx
ln -s /opt/LaTeX/bin/x86_64-linux/xdvipdfmx /usr/bin/xdvipdfmx
ls -l /usr/bin/xdvipdfmx

rm -f /usr/bin/pdfetex
ln -s /opt/LaTeX/bin/x86_64-linux/pdfetex /usr/bin/pdfetex
ls -l /usr/bin/pdfetex

rm -f /usr/bin/luatex
ln -s /opt/LaTeX/bin/x86_64-linux/luatex /usr/bin/luatex
ls -l /usr/bin/luatex

rm -f /usr/bin/lualatex
ln -s /opt/LaTeX/bin/x86_64-linux/lualatex /usr/bin/lualatex
ls -l /usr/bin/lualatex

rm -f /usr/bin/etex
ln -s /opt/LaTeX/bin/x86_64-linux/etex /usr/bin/etex
ls -l /usr/bin/etex
