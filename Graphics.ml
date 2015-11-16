(* ************************************************************************** *)
(*                                                                            *)
(*                                                        :::      ::::::::   *)
(*   Graphics.ml                                        :+:      :+:    :+:   *)
(*                                                    +:+ +:+         +:+     *)
(*   By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+        *)
(*                                                +#+#+#+#+#+   +#+           *)
(*   Created: 2015/11/16 14:07:32 by mbarbari          #+#    #+#             *)
(*   Updated: 2015/11/16 16:21:19 by sebgoret         ###   ########.fr       *)
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
        method virtual action : unit

        (* PUBLIC METHOD  *************************************************** *)
        method draw (img:string) =
            let img_load = Sdlloader.load_image img in
            let pos_img = Sdlvideo.rect
                    self#getposx self#getposy self#getheight self#getwidth in
            Sdlvideo.blit_surface ~dst_rect:pos_img ~src:img_load ~dst:getscreen ();
            Sdlvideo.flip getscreen; ()

        method draw_text (str:string) =
            if ((String.compare str "") <> 0) then
                begin
                    let font = Sdlttf.open_font "rsc/Monaco.dfont" 24 in
                    let text = Sdlttf.render_text_blended font str ~fg:Sdlvideo.white in
                    let pos_text = Sdlvideo.rect
                            (self#getposx + (self#getwidth / 3))
                            (self#getposy + (self#getheight / 2))
                            (self#getwidth / 2)
                            (self#getheight / 2) in
                    Sdlvideo.blit_surface ~dst_rect:pos_img ~src:img_load ~dst:getscreen ();
                    Sdlvideo.flip getscreen; ()
                end
    end

class button_eat (objtama: Tama.tama) (pos_x:int) (pos_y:int) (height:int) (width:int) =
    object
        inherit graphics_object pos_x pos_y height width

        method action =
            objtama = objtama#eat
    end


