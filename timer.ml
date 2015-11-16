(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   timer.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/16 11:11:45 by mbarbari          #+#    #+#             *)
(*   Updated: 2015/11/16 11:42:40 by mbarbari         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let rec timer_loop ((flag:bool), callback) (timing:float) =
    if !flag then Thread.exit
    else
        (Thread.delay timing; callback; timer_loop(flag, callback))

let rec handle_event =
    if Sdlevent.has_event () then
        match Sdlevent.wait_event () with
            |Sdlevent.MOUSEBUTTONDOWN ->
                    handle_graphic Sdlevent.mbe_x Sdlevent.mbe_y 1
            |Sdlevent.MOUSEBUTTONUP ->
                    handle_graphic Sdlevent.mbe
