
open Str
open List
open Printf

exception Invalid_input
exception Unwrap_none

let unwrap v = match v with Some v -> v | None -> raise Unwrap_none ;;

let read_ints () = map int_of_string (Str.split (regexp " +") (read_line ())) ;;

let read_int () =
  match read_ints () with
  | [i] -> i
  | _ -> raise Invalid_input
;;

let get map k = try Some (Hashtbl.find !map k) with Not_found -> None ;;

let opt_min a b =
  match a, b with
  | None, None -> None
  | Some x, None -> Some x
  | None, Some y -> Some y
  | Some x, Some y -> Some (min x y)
;;

let add_value_at price kv value map =
  let p, c = kv in
  let reached = p + value in
  let () =
  match get map reached with
  | None -> Hashtbl.add !map reached (c + 1)
  | Some d ->
    if d > c + 1
    then Hashtbl.replace !map reached (c + 1)
    else ()
  in
  if (reached >= price)
  then Some reached
  else None
;;

let add_value price value map =
  let seq = of_seq (Hashtbl.to_seq !map) in
  let rec loop seq =
    match seq with
    | [] -> None
    | head :: tail ->
      opt_min
        (add_value_at price head value map)
        (loop tail)
  in loop seq
;;

let run_case () =
  let price = read_int () in
  let count = read_int () in
  let map = ref (Hashtbl.create 100) in
  let () = Hashtbl.add !map 0 0 in
  let rec loop n =
    match n with
    | 0 -> None
    | _ -> opt_min (add_value price (read_int ()) map) (loop (n - 1))
  in
  let best = unwrap (loop count) in
  printf "%d %d\n" best (Hashtbl.find !map best)
;;

let rec loop n =
  match n with
  | 0 -> ()
  | _ -> let () = run_case () in loop (n - 1)
;;

let () = loop (read_int ()) ;;
