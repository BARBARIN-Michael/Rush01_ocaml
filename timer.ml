(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   timer.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/16 11:11:45 by mbarbari          #+#    #+#             *)
(*   Updated: 2015/11/16 12:47:07 by mbarbari         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type t_coord = (x, y)

let rec timer_loop ((flag:bool), callback) (timing:float) =
    if !flag then Thread.exit
    else
        (Thread.delay timing; callback; timer_loop(flag, callback))

let handle_event (handle_object:UI_object) =
    if Sdlevent.has_event () then
        match Sdlevent.wait_event () with
            |Sdlevent.MOUSEBUTTONDOWN ->
                    handle_graphics handle_object (Sdlevent.mbe_x, Sdlevent.mbe_y) 1
            |Sdlevent.MOUSEBUTTONUP ->
                    handle_graphics handle_object (Sdlevent.mbe_x, Sdlevent.mbe_y) 2

let handle_graphics (handle_object: UI_object) (x, v) action = match handle_object with
    |a::b when (a.coord_inner_object x y) = true && action = 1 -> a.action; ()
    |[] -> ()
