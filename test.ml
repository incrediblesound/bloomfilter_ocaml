let fltr = Bloomfltr.make;;

Bloomfltr.insert fltr "Heyoo";;
Bloomfltr.insert fltr "What";;
Bloomfltr.write_to_file fltr "myfile.txt";;
let loaded = Bloomfltr.load_from_file "myfile.txt";;

let x = Bloomfltr.contains loaded "Heyoo";;
let y = Bloomfltr.contains loaded "What";;
let z = Bloomfltr.contains loaded "Nope";;

Bloomfltr.print_bool x;;
Bloomfltr.print_bool y;;
Bloomfltr.print_bool z;;