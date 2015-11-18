(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/16 15:37:56 by mbarbari          #+#    #+#             *)
(*   Updated: 2015/11/18 21:48:29 by mbarbari         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let rec timer_loop (flag, callback)=
	if (!flag)
		then Thread.exit
	else
		(Thread.delay 1.; callback (); timer_loop (flag, callback))

let timer_cb () = Sdlevent.add [Sdlevent.USER 0]

let rec static_redraw button_list =
	List.iter (function a -> a#draw_button) button_list

let () =
	Sdl.init [`VIDEO];
	at_exit Sdl.quit;
	Sdlttf.init ();
	at_exit Sdlttf.quit;
	let screen = (Sdlvideo.set_video_mode 800 600 [])
	and newtama = (Tama.get_data_of_file "save.tama") in
		let bg = new Graphics.background newtama screen 0 0 200 200 in
        print_endline ("test de lecture : " ^ newtama#to_string);
		bg#draw_bg;
		let eat = new Graphics.button_eat newtama screen 40 380 40 30
		and thunder = new Graphics.button_thunder newtama screen 40 410 40 30
		and bath = new Graphics.button_bath newtama screen 40 440 40 30
		and kill = new Graphics.button_kill newtama screen 40 470 40 30
		in static_redraw [eat; thunder; bath; kill];
		let tama = new Graphics.creature newtama screen 300 80 120 80 in
		tama#draw_bg;
		Sdlvideo.flip screen;
		let timer_flag = ref false
		in
			let th = Thread.create timer_loop (timer_flag, timer_cb)
			in	Tama.set_data_to_file "save.tama" (Timer.handle_event newtama th);
				timer_flag := true;
				print_endline ("You exit the game.");
				Thread.join th
