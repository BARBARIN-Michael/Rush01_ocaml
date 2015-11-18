# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/11/16 10:37:18 by mbarbari          #+#    #+#              #
#    Updated: 2015/11/18 16:18:08 by sebgoret         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RESULT     =	tama_cthulhu
SOURCES    =	Tama.ml		\
				Graphics.ml	\
				Timer.ml	\
				Try.ml		\
				main.ml

LIBS       =	bigarray sdl sdlloader sdlttf sdlmixer
INCDIRS    =	+sdl

THREADS =		true

ifeq ($(shell uname), darwin)
	OCAMLLDFLAGS = -cclib  "-framework Cocoa"
endif

include OCamlMakefile

fclean: cleanup
	rm -f $(RESULT)

