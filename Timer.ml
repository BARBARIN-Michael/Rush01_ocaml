(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   timer.ml                                           :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/16 11:11:45 by mbarbari          #+#    #+#             *)
(*   Updated: 2015/11/18 20:48:19 by sebgoret         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

type t_coord = int * int

let rec static_redraw button_list =
	List.iter (function a -> a#draw_button) button_list

let rec timer_loop ((flag:bool), callback) (timing:float) =
	if (not flag)
		then Thread.exit
	else
		(Thread.delay timing; callback; timer_loop (flag, callback) timing )

let rec handle_click (t:Tama.tama) (x, y) lst =
	match lst with
		| h::tail when ((h#hasClicked x y) = true) -> h#action
		| h::tail -> handle_click t (x, y) tail
		| _ -> t

let handle_mouse (t:Tama.tama) (x, y) action =
	if action = true
	then
		let screen = (Sdlvideo.set_video_mode 800 600 [])
		in let eat = new Graphics.button_eat t screen 40 380 40 30
		and thunder = new Graphics.button_thunder t screen 40 410 40 30
		and bath = new Graphics.button_bath t screen 40 440 40 30
		and kill = new Graphics.button_kill t screen 40 470 40 30
			in	let lst = [eat; thunder; bath; kill]
				in	let newtama = handle_click t (x, y) lst
					in	let yolo = new Graphics.creature newtama screen 300 80 120 80 in
							let bg = new Graphics.background newtama screen 0 0 200 200 in
							bg#draw_bg;
							static_redraw lst;
							yolo#draw_bg;
							ignore (Sdlvideo.flip screen);
							newtama
	else
		t

let handle_key (t:Tama.tama) =
	match Sdlevent.wait_event () with
		| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } -> exit 0
		| _ -> t

let rec handle_event (t:Tama.tama) =
	if (t#hasOneZero)
		then
		begin
			print_endline "You lose!";
			exit 0
		end
	else
		match Sdlevent.wait_event () with
			| Sdlevent.MOUSEBUTTONDOWN ({ Sdlevent.mbe_button = Sdlmouse.BUTTON_LEFT } as c) ->
				handle_event (handle_mouse t (c.Sdlevent.mbe_x, c.Sdlevent.mbe_y) true)
			| Sdlevent.MOUSEBUTTONUP ({ Sdlevent.mbe_button = Sdlmouse.BUTTON_LEFT } as c) ->
				handle_event (handle_mouse t (c.Sdlevent.mbe_x, c.Sdlevent.mbe_y) false)
			| Sdlevent.KEYDOWN { Sdlevent.keysym = Sdlkey.KEY_ESCAPE } ->
				handle_key t;
			| _ -> handle_event t
