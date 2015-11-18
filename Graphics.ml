(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Graphics.ml                                        :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/16 14:07:32 by mbarbari          #+#    #+#             *)
(*   Updated: 2015/11/18 19:50:46 by sebgoret         ###   ########.fr       *)
(*                                                                            *)
(* ************************************************************************** *)

class virtual graphics_object screen (pos_x:int) (pos_y:int) (height:int) (width:int) =
    object (self)
        val _screen = screen
        val _pos_x = pos_x
        val _pos_y = pos_y
        val _height = height
        val _width = width

        (* GETTEUR ********************************************************** *)
        method getscreen = _screen
        method getposx = _pos_x
        method getposy = _pos_y
        method getheight = _height
        method getwidth = _width

        (* VIRTUAL METHOD *************************************************** *)
        method virtual action : Tama.tama

        (* PUBLIC METHOD  *************************************************** *)
        method draw (img:string) =
            let img_load = Sdlloader.load_image img in
            let pos_img = Sdlvideo.rect
                    self#getposx self#getposy self#getheight self#getwidth in
            Sdlvideo.blit_surface ~dst_rect:pos_img ~src:img_load ~dst:self#getscreen ();
            Sdlvideo.flip self#getscreen; ()

        method draw_text (str:string) =
            if ((String.compare str "") <> 0) then
                begin
                    let font = Sdlttf.open_font "rsc/arial.ttf" 24 in
                    let text = Sdlttf.render_text_blended font str ~fg:Sdlvideo.white in
                    let pos_text = Sdlvideo.rect
                            (self#getposx + (self#getwidth / 3))
                            (self#getposy + (self#getheight / 2))
                            (self#getwidth / 2)
                            (self#getheight / 2) in
                    Sdlvideo.blit_surface ~dst_rect:pos_text ~src:text ~dst:self#getscreen ();
                    Sdlvideo.flip self#getscreen; ()
                end

		method draw_bar (value:int) (name:string) (color:string) (x, y) =
			let font = Sdlttf.open_font "rsc/arial.ttf" 24 in
			Sdlvideo.fill_rect ~rect:(Sdlvideo.rect x y (value * 2) 30) screen (Int32.of_string color) ;
			let text = Sdlttf.render_text_solid font (name ^ ": " ^ string_of_int value) ~fg:Sdlvideo.black in
			Sdlvideo.blit_surface ~dst_rect:(Sdlvideo.rect x y 200 30) ~src:text ~dst:(self#getscreen) ()

			method hasClicked (mouse_X:int) (mouse_Y:int) =
				if (mouse_Y > self#getposy && mouse_Y < (self#getposy + self#getheight) && mouse_X > self#getposx && mouse_X < (self#getposx + self#getwidth))
					then true
				else
					false

	end

class button_eat (objtama: Tama.tama) (screen:Sdlvideo.surface) (pos_x:int) (pos_y:int) (height:int) (width:int) =
    object (self)
        inherit graphics_object screen pos_x pos_y height width

        method action =
            objtama#eat

        method draw_button =
            self#draw_text "EAT"

    end

class button_thunder (objtama: Tama.tama) (screen:Sdlvideo.surface) (pos_x:int) (pos_y:int) (height:int) (width:int) =
    object (self)
        inherit graphics_object screen pos_x pos_y height width

        method action =
            objtama#thunder

        method draw_button =
            self#draw_text "THUNDER"
    end

class button_bath (objtama: Tama.tama) (screen:Sdlvideo.surface) (pos_x:int) (pos_y:int) (height:int) (width:int) =
    object (self)
        inherit graphics_object screen pos_x pos_y height width

        method action =
            objtama#bath

        method draw_button =
            self#draw_text "BATH"
    end

class button_kill (objtama: Tama.tama) (screen:Sdlvideo.surface) (pos_x:int) (pos_y:int) (height:int) (width:int) =
    object (self)
        inherit graphics_object screen pos_x pos_y height width

        method action =
            objtama#kill

        method draw_button =
            self#draw_text "KILL"
    end

class background (objtama: Tama.tama) (screen:Sdlvideo.surface) (pos_x:int) (pos_y:int) (height:int) (width:int) =
    object (self)
        inherit graphics_object screen pos_x pos_y height width

        method action = objtama

        method draw_bg =
            self#draw "rsc/bg.jpg"
    end

class creature (objtama: Tama.tama) (screen:Sdlvideo.surface) (pos_x:int) (pos_y:int) (height:int) (width:int) =
    object (self)
        inherit graphics_object screen pos_x pos_y height width

        method action = objtama

		method private draw_bars =
			self#draw_bar objtama#get_hp "Health" "0x00FF0000" (40, 100);
			self#draw_bar objtama#get_energy "Thunder" "0x00FFFF00" (40, 140);
			self#draw_bar objtama#get_hygiene "Bath" "0xFFFF0000" (40, 180);
			self#draw_bar objtama#get_happiness "Kill" "0x0000FF00" (40, 220);
			Sdlvideo.flip self#getscreen

		method draw_bg =
			self#draw "rsc/Nya.jpg";
			self#draw_bars
	end
