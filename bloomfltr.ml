open Hashtbl;;
open Printf;;

(* utility function for printing the output of contains *)
let print_bool b =
	if !b then print_string "True" else print_string "False";;

(* The make function just returns an array of zeros, a more full
  featured bloom filter would probably be a record or class, but I
  took a simple approach here *)
let make = Array.make 1000 0;;

(* this function takes a value and returns a list of int indexes
   that will be flipped (to 1) in the bloom filter,
   the bloom filter has 1000 bits so I mod 1000 the hash *)
let rec indexes v n = 
	if n < 1 then [] 
	else (seeded_hash (n*10) v) mod 1000 :: indexes v (n-1);;

(* simply sets an integer of the int array to 1 *)
let check_bit (bf: int array) (idx: int) =
	Array.set bf idx 1;;

(* retrieves a bit at a given index and returns true
	 if that bit is checked, used in fold_left so takes a
	 bool ref accumulator *)
let is_checked (bf:int array) (b: bool ref) (i: int) : bool ref =
	let bt = Array.get bf i in
	if bt = 1 then b else (b := false; b);;

(* inserts a value of any type into the bloom filter *)
let insert (bf: int array) (v: 'a) =
	let idxs = indexes v 20 in
	let check_bf_bit = check_bit bf in
	List.iter (fun i -> check_bf_bit i) idxs;;

(*  checks whether or not a bloom filter contains
	a given value, takes a bloom filter (int array) and
	a value of any type as input and returns a boolean
 *)
let contains bf v : bool ref =
	let hash_idxs = indexes v 20 in
	let stored = ref true in
	List.fold_left (is_checked bf) stored hash_idxs

(* writes the flipped indexes of the bloom filter to a file with name fn *)
let write_to_file (bf: int array) (fn:string) =
	let oc = open_out fn in
	for x = 0 to (Array.length bf) -1 do
		let result = ref true in
		let checked = is_checked bf result x in
		if !checked then fprintf oc "%d," x else ();
	done;
	fprintf oc "\n";
	close_out oc;;

(* fetches a line of flipped indices from a file and 
   converts it to a list of integers, used in load_from_file
 *)
let get_flipped_array fn =
	try
		let ic = open_in fn in
		let line = input_line ic in 
		let str_array = Str.split (Str.regexp ",") line in
		close_in ic;
		List.map (fun s -> int_of_string s) str_array
	with e ->
		raise e

(* takes a file name and returns a new bloom
   filter loaded from the data found in that file
 *)
let load_from_file (fn:string): int array =
	let new_bf = make in
	let checked_list = get_flipped_array fn in
	let check_func = check_bit new_bf in
	List.map (fun idx -> check_func idx) checked_list;
	new_bf;;
