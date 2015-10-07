let fltr = Bloomfltr.make;;

Bloomfltr.insert fltr "Heyoo";;
Bloomfltr.insert fltr "What";;
Bloomfltr.write_to_file fltr "myfile.txt";;
let loaded = Bloomfltr.load_from_file "myfile.txt";;

let a = Bloomfltr.contains fltr "Heyoo";;
let b = Bloomfltr.contains fltr "What";;
let c = Bloomfltr.contains fltr "Nope";;

let x = Bloomfltr.contains loaded "Heyoo";;
let y = Bloomfltr.contains loaded "What";;
let z = Bloomfltr.contains loaded "Nope";;

print_string "Bloom filter should return true for inserted values:\n";;
Bloomfltr.print_bool a;;
Bloomfltr.print_bool b;;
print_string "Bloom filter should return false for values not inserted:\n";;
Bloomfltr.print_bool c;;

print_string "Bloom filter (loaded from disk) should return true for inserted values:\n";;
Bloomfltr.print_bool x;;
Bloomfltr.print_bool y;;
print_string "Bloom filter (loaded from disk) should return false for values not inserted:\n";;
Bloomfltr.print_bool z;;