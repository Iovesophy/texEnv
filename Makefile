FILES:=hello
IMAGE:=paperist/alpine-texlive-ja
WORK_DIR:=/workdir
TARGETS=$(foreach file, $(FILES), $(file).pdf)

.PHONY: all
all: $(TARGETS)

.PHONY: clean
clean:
	$(RM) *.aux *.log *.dvi

.PHONY: distclean
distclean: clean
	$(RM) $(TARGETS)

%.pdf: %.dvi
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) dvipdfmx $<

%.dvi: %.tex
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) uplatex -interaction=batchmode $<
	docker run --rm -v $(PWD):$(WORK_DIR) $(IMAGE) uplatex -interaction=batchmode $<
