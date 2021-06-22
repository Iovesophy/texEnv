FILES:=hello
IMAGE:=paperist/alpine-texlive-ja
TARGETS=$(foreach file, $(FILES), $(file).pdf)
WORK_DIR:=/workdir

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	$(RM) *.aux *.dvi *.log

.PHONY: distclean
distclean: clean
	$(RM) $(TARGETS)

%.pdf: %.dvi
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) dvipdfmx $<

%.dvi: %.tex
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) uplatex -interaction=batchmode $<
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) uplatex -interaction=batchmode $<
