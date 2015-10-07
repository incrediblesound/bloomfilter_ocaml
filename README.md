# bloomfilter_ocaml

bloom filter implementation in OCaml

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
