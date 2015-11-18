(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/16 15:37:56 by mbarbari          #+#    #+#             *)
(*   Updated: 2015/11/18 19:49:05 by sebgoret         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let () =
	Sdl.init [`VIDEO];
	at_exit Sdl.quit;
	Sdlttf.init ();
	at_exit Sdlttf.quit;
	let screen = (Sdlvideo.set_video_mode 800 600 [])
	and newtama = new Tama.tama 100 100 100 100 in
		let bg = new Graphics.background newtama screen 0 0 200 200
		and eat = new Graphics.button_eat newtama screen 40 380 15 20
		and thunder = new Graphics.button_thunder newtama screen 40 410 15 20
		and bath = new Graphics.button_bath newtama screen 40 440 15 20
		and kill = new Graphics.button_kill newtama screen 40 470 15 20
		and tama = new Graphics.creature newtama screen 300 80 120 80
		in
		bg#draw_bg;
		eat#draw_button;
		thunder#draw_button;
		bath#draw_button;
		kill#draw_button;
		tama#draw_bg;
		Sdltimer.delay 4001
