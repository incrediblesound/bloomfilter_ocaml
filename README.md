# bloomfilter_ocaml

bloom filter implementation in OCaml

## To Build (MAC OS)
Install the OCaml package manager
```shell
brew install opam
```
Then install ocamlfind
```shell
opam install ocamlfind
```
Run the shell script in this repository to build and run the tests
```shell
./build.sh
./test
```

##API

```ocaml
(* make a new bloom filter *)
let my_filter = Bloomfltr.make;;

(* insert data *)
Bloomfltr.insert my_filter "Some data"

(* check for data *)
Bloomfltr.contains my_filter "Some data"  (* returns true *)
Bloomfltr.contains my_filter "Something else" (* returns false *)

(* write the data of this filter to a new file "filter.txt" *)
Bloomfltr.write_to_file my_filter "filter.txt"

(* load a saved bloom filter *)
let loaded_filter = Bloomfltr.load_from_file "filter.txt"
