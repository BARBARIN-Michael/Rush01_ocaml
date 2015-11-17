(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   main.ml                                            :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/16 15:37:56 by mbarbari          #+#    #+#             *)
(*   Updated: 2015/11/17 17:25:41 by mbarbari         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

let () =
    Sdl.init [`VIDEO];
    at_exit Sdl.quit;
    let screen = (Sdlvideo.set_video_mode 800 600 []) in
    let newtama = new Tama.tama 100 100 100 100 in
    let bg = new Graphics.background newtama screen 0 0 200 200 in
    let manger = new Graphics.button_eat newtama screen 0 0 200 200 in
    bg#draw_bg;
    manger#draw_button;
    print_endline "test";
    Sdltimer.delay 2001;

