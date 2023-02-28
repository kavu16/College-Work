fun digitsPos x =
	let val last = x mod 10
	in
		if x = 0
		then []
		else (digitsPos ((x-last) div 10))@[last]
	end;

fun additivePersistence x = 
	let val sum = foldl (fn (a,b) => a+b) 0 (digitsPos x)
	in
		if sum < 10
		then 1
		else 1 + additivePersistence sum
	end;

fun digitalRoot x = 
	let val sum = foldl (fn (a,b) => a+b) 0 (digitsPos x)
	in
		if sum < 10
		then sum
		else digitalRoot sum
	end;

fun alternate [] = 0
	| alternate (x::xs) =
		x + ~(alternate xs);

fun alternate2 [] f g = 0
	| alternate2 (x::xs) f g =
		if null xs
		then x
		else alternate2 ((f (x, (hd xs)))::(tl xs)) g f;

fun scan_left f y [] = [y]
	| scan_left f y (x::xs) = y::(scan_left f (f x y) xs);

fun zipRecycle (xs, ys) = 
	let fun zip ([],[]) = []
		| zip (a,[]) = []
		| zip ([],b) = zip (xs,b)
		| zip (a,b) = ((hd a),(hd b))::(zip ((tl a),(tl b)))
	in
		zip (xs,ys)
	end;

fun bind (SOME a) (SOME b) f = (SOME (f a b))
	| bind NONE (SOME b) f = NONE
	| bind (SOME a) NONE f = NONE
	| bind NONE NONE f = NONE;

fun lookup [] st = NONE
	| lookup ((s,i)::xs) s2 = 
		if String.compare (s,s2) = EQUAL
		then (SOME (i*1))
		else (lookup xs s2);

fun getitem n [] = NONE
	| getitem n (x::xs) = 
		if n = 1
		then (SOME x)
		else getitem (n-1) xs;

fun getitem2 (SOME n) [] = NONE
	| getitem2 NONE [] = NONE
	| getitem2 NONE (x::xs) = NONE
	| getitem2 (SOME n) (x::xs) = 
		if n = 1
		then (SOME x)
		else getitem2 (SOME (n-1)) xs;


(* TRIE implementation *)
(*
signature DICT =
sig
	type key = string
	type 'a entry = key * 'a

	type 'a dict

	val empty : 'a dict
	val lookup : 'a dict -> key -> 'a option
	val insert : 'a dict * 'a entry -> 'a dict
end;

structure Trie :> DICT = 
struct
	type key = string
	type 'a entry = key * 'a

	datatype 'a trie =
		Root of 'a option * 'a trie list
		| Node of 'a option * char * 'a trie list

	type 'a dict = 'a trie

	val empty = Root(NONE, nil)

	fun lookup trie key =
		let val ks = explode key
			fun find x [] = NONE
				| find x ((Node(_,k,_))::ts) =
					if x = k
					then (Node(_,k,_))
					else find x ts

		in
			case of trie 
				empty => NONE
				| Root((SOME a),[]) => if null ks
								then (SOME a)
								else NONE
				| Root((SOME a),t::ts) => if null ks
										then (SOME a)
										else (case of t
												empty => 


	fun insert (trie, (key, value)) = 
		let val ks = explode key
			fun find x [] = empty
				| find x (t:ts) = 
					case of t
						Node((SOME a),k,ts1) => if x = k
												then t
												else find x ts

		in
			case of ks
			[] => case of trie
					empty => Root(value,[])
					Root(_,ts) => Root(value,ts)
			(k::ks') => case of trie
						empty => Root() *)

(* test edge cases include previous tries with new results and previous results with new trees*)