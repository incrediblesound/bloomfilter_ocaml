#!/bin/bash
ocamlopt -c bloomfltr.ml
ocamlopt -c test.ml
ocamlfind ocamlopt -o test -package Str -linkpkg bloomfltr.cmx test.cmx
