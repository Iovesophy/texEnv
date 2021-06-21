FILES:=hello
IMAGE:=paperist/alpine-texlive-ja
WORK_DIR:=/workdir
TARGETS=$(foreach FILE, $(FILES), $(FILE).pdf)

.PHONY: all clean distclean
all: clean distclean $(TARGETS)
clean:
	$(RM) *.aux *.log *.dvi
distclean: clean
	$(RM) $(TARGETS)

%.pdf: %.dvi
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) dvipdfmx $<

%.dvi: %.tex
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) uplatex -interaction=batchmode $<
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) uplatex -interaction=batchmode $<
