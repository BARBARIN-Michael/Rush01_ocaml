(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   timer.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/16 11:11:45 by mbarbari          #+#    #+#             *)
(*   Updated: 2015/11/18 09:42:34 by mbarbari         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type t_coord = int * int

let rec timer_loop ((flag:bool), callback) (timing:float) =
	if (not flag)
		then Thread.exit
	else
		(Thread.delay timing; callback; timer_loop (flag, callback) timing )


let handle_mouse (handle_object:Graphics.graphics_object list) (x, y) action =
		if action = 1 then List.iter (fun a -> if (a#hasClicked x y) then a#action) handle_object


let handle_key () =
	match Sdlevent.wait_event () with
		| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } -> exit 0
		|_ -> ()

let rec handle_event (handle_object:Graphics.graphics_object list) (t:Tama.tama)=
	if Sdlevent.has_event ()
		then match Sdlevent.wait_event () with
				| Sdlevent.MOUSEBUTTONDOWN ({ Sdlevent.mbe_button = Sdlmouse.BUTTON_LEFT } as c) ->
                   handle_event handle_object (handle_mouse handle_object (c.Sdlevent.mbe_x, c.Sdlevent.mbe_y) 1)
				| Sdlevent.MOUSEBUTTONUP ({ Sdlevent.mbe_button = Sdlmouse.BUTTON_LEFT } as c) ->
                    handle_event handle_object (handle_mouse handle_object (c.Sdlevent.mbe_x, c.Sdlevent.mbe_y) 2)
				| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } ->
                    handle_key (); handle_event handle_object t
				| _ -> handle_event handle_object t
