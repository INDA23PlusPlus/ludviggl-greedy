
exception Invalid_input

open Str
open List
open Printf

type car = { weight : int; num : int } ;;
type lss_entry = { value : int; length : int } ;;

let read_int () =
  match Str.split (regexp " +") (read_line ()) with
  | [s] -> int_of_string s
  | _ -> raise Invalid_input
;;

let get_cars n =
  let rec loop m =
    if m < n
    then { weight = read_int (); num = m } :: loop (m + 1)
    else []
  in loop 0
;;

(* computes the length of the longest increasing/decreasing
   subsequence depending on operator `cmp` *)
let rec lss l cmp =
  let rec internal l cmp =
    match l with
    | [] -> [], 0
    | head :: tail ->
      let sub_l, sub_m = internal tail cmp in
      let length = lss_calc_elem head.num sub_l cmp in
      { value = head.num; length } :: sub_l, max sub_m length
  in let _, v = internal l cmp in v

and lss_calc_elem value sub cmp =
  match sub with
  | [] -> 1
  | head :: tail ->
    let tail = lss_calc_elem value tail cmp in
    if cmp value head.value
    then max (head.length + 1) tail
    else tail
;;

let car_cmp a b = Stdlib.compare a.weight b.weight ;;

let rec longest r l =
  match l with
  | [] -> 0
  | head :: tail -> max ((lss l (>)) + (lss r (<))) (longest (r @ [head]) tail)
;;

let main () =
  let n = read_int () in
  let cars = sort car_cmp (get_cars n) in
  printf "%d" (longest [] cars)
;;

let () = main ()
