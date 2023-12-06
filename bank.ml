
(* Submission ID: 12460824 *)



exception Invalid_input
exception Something_wrong



open List
open Str



type entry = { c : int; t : int }
;;



let read_params () =
  let line = read_line () in
  match split (regexp " +") line with
  | n :: (t :: _) -> (int_of_string n, int_of_string t)
  | _ -> raise Invalid_input
;;



let entry_from_str str =
  match split (regexp " +") str with
  | c :: (t :: _) -> { c = int_of_string c; t = int_of_string t }
  | _ -> raise Invalid_input
;;



let rec read_entries n =
  if n == 0
  then []
  else
    try entry_from_str (read_line ()) :: read_entries (n - 1)
    with End_of_file -> []
;;



let rec make_queue t =
  match t with
  | 0 -> []
  | _ -> 0 :: make_queue (t - 1)
;;



let rec split_at e t =
  match t with
  | 0 -> [], e
  | _ ->
    match e with
    | [] -> raise Something_wrong
    | hd :: tl ->
      let r, l = split_at tl (t - 1) in
      hd :: r, l
;;



let rec insert_c l c =
  match l with
  | [] -> [c]
  | hd :: tl ->
    if c > hd
    then c :: insert_c tl hd
    else hd :: insert_c tl c
;;



let insert_entry q e =
  let r, l = split_at q e.t in
  let i = insert_c l e.c in
  r @ i
;;



let rec sum_first l n =
  match n with
  | 0 -> 0
  | _ ->
    match l with
    | [] -> 0
    | hd :: tl -> hd + sum_first tl (n - 1)
;;



let rec invert_times e t =
  match e with
  | [] -> []
  | hd :: tl -> { c = hd.c; t = t - hd.t - 1 } :: invert_times tl t
;;



let () =
  let n, t = read_params () in
  let entries = invert_times (read_entries n) t in
  let queue = make_queue t in
  let rec loop e q =
    match e with
    | [] -> q
    | hd :: tl -> loop tl (insert_entry q hd)
  in let inserted = loop entries queue in
  let result = sum_first inserted t in
  print_int result
;;
