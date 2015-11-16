(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Try.ml                                             :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: barbare <barbare@student.42.fr>            +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/13 21:05:34 by barbare           #+#    #+#             *)
(*   Updated: 2015/11/13 23:26:55 by barbare          ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

exception FAILED

type 'a t = Success of 'a | Failure of exn

let return (a:'a) = Success(a)

let bind (a: 'a t) fct = match a with
    |Success(x) -> (try (fct x) with |e -> Failure(e))
    |Failure(e) as fail-> fail

let recover (a: 'a t) fct = match a with
    |Success(a) -> a
    |_ -> fct a

let filter (a: 'a t) fct = match a with
|Success(x) -> if fct x then a else Failure(FAILED)
|_ -> a

let flatten (a: 'a t t) = match a with
    |Success(x) -> 
        (match x with
            |Success(y) -> Success(y)
        |_ -> Failure(FAILED))
    |_ -> Failure(FAILED)
