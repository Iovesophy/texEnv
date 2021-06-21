FILES:=hello
IMAGE:=paperist/alpine-texlive-ja
WORK_DIR:=/workdir
TARGETS=$(foreach VAL, FILES, $(FILES).pdf)

.PHONY: all clean distclean
all: clean distclean $(TARGETS)
clean:
	$(RM) *.aux *.log *.dvi
distclean: clean
	$(RM) $(TARGET)

$(FILES).pdf: $(FILES).dvi
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) dvipdfmx $<

$(FILES).dvi: $(FILES).tex
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) uplatex -interaction=batchmode $< 
