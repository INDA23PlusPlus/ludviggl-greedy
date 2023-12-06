
open Str
open Printf
open List



exception Invalid_input



type classroom =
  {
  count : int;
  stop  : int
  }
;;




type activity =
  {
  start : int;
  stop  : int
  }
;;



type insert_status = Refused | Accepted of (classroom ref * int) ;;



let read_ints () =
  match Str.split (regexp " +") (read_line ()) with
  | s0 :: (s1 :: _) -> int_of_string s0, int_of_string s1
  | _ -> raise Invalid_input
;;



let rec make_classrooms n =
  match n with
  | 0 -> []
  | _ -> ref { count = 0; stop = 0 } :: make_classrooms (n - 1)
;;



let read_activity () = let start, stop = read_ints () in { start; stop } ;;




let rec read_activities n =
  match n with
  | 0 -> []
  | _ -> read_activity () :: read_activities (n - 1)
;;



let activity_compare a b =
  if a.stop == b.stop
  then Stdlib.compare a.start b.start
  else Stdlib.compare a.stop b.stop
;;



let sort_activities acts = sort activity_compare acts ;;



let insert_activity (cr : classroom ref) act = cr := { count = !cr.count + 1; stop = act.stop } ;;



let try_classroom (cr : classroom ref) act =
  if !cr.stop < act.start
  then Accepted (cr, act.start - !cr.stop)
  else Refused
;;



let rec find_optimal crs act =
  match crs with
  | [] -> Refused
  | head :: tail ->
    let head_status = try_classroom head act in
    let tail_status = find_optimal tail act in
    match head_status, tail_status with
    | Refused, Refused -> Refused
    | Accepted _, Refused -> head_status
    | Refused, Accepted _ -> tail_status
    | Accepted (_, head_break), Accepted (_, tail_break) ->
      if head_break < tail_break
      then head_status
      else tail_status
;;



let try_insert_activity crs act =
  match find_optimal crs act with
  | Refused -> ()
  | Accepted (cr, _) -> insert_activity cr act
;;



let rec insert_activities crs acts =
  match acts with
  | [] -> ()
  | head :: tail ->
    let () = try_insert_activity crs head in
    insert_activities crs tail
;;



let rec count_scheduled crs =
  match crs with
  | [] -> 0
  | head :: tail -> !head.count + count_scheduled tail
;;




let () =
  let n, k = read_ints () in
  let acts = read_activities n in
  let acts = sort_activities acts in
  let crs = make_classrooms k in
  let () = insert_activities crs acts in
  let count = count_scheduled crs in
  printf "%d" count
;;
