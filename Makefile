# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/11/16 10:37:18 by mbarbari          #+#    #+#              #
#    Updated: 2015/11/16 17:28:08 by mbarbari         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RESULT     =	tama_cthulhu
SOURCES    =	Graphics.ml	\
		Tama.ml		\
		Timer.ml	\
		Try.ml		\
		main.ml
LIBS       =	bigarray sdl sdlloader sdlttf sdlmixer
INCDIRS    =	+sdl


ifeq ($(shell uname), darwin)
	OCAMLLDFLAGS = -cclib  "-framework Cocoa"
endif

include OCamlMakefile
