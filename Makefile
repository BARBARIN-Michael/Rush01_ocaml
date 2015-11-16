# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mbarbari <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/11/16 10:37:18 by mbarbari          #+#    #+#              #
#    Updated: 2015/11/16 15:47:27 by mbarbari         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RESULT     = tama_cthulhu
SOURCES    = tama_cthulhu.ml
LIBS       = bigarray sdl sdlloader sdlttf
INCDIRS    = +sdl

include OCamlMakefile
