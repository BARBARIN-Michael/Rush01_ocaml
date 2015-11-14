# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: barbare <barbare@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/11/11 14:48:22 by barbare           #+#    #+#              #
#    Updated: 2015/11/14 18:36:29 by barbare          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = a.out
SOURCES = tama_cthulhu.ml
CAMLC = ocamlc
CAMLOPT = ocamlopt
CAMLDEP = ocamldep

all: rmexe depend $(NAME)

$(NAME): opt byt
	ln -s $(NAME).opt $(NAME)

opt: $(NAME).opt
byt: $(NAME).byt

OBJS = $(SOURCES:.ml=.cmo)
OPTOBJS = $(SOURCES:.ml=.cmx)

$(NAME).byt: $(OBJS)
		$(CAMLC) -o $(NAME).byt $(OBJS)

$(NAME).opt: $(OPTOBJS)
		$(CAMLOPT) -o $(NAME).opt $(OPTOBJS)

.SUFFIXES:
.SUFFIXES: .ml .mli .cmo .cmi .cmx

.ml.cmo:
	$(CAMLC) -c $<

.mli.cmi:
	$(CAMLC) -c $<

.ml.cmx:
	$(CAMLOPT) -c $<

rmexe:
	rm -f $(NAME)

clean:
	rm -f *.cm[iox] *~ .*~
	rm -f *.o
	rm -f $(NAME).o

fclean: clean
	rm -f $(NAME)
	rm -f $(NAME).opt
	rm -f $(NAME).byt

depend: .depend
	$(CAMLDEP) $(SOURCES) > .depend

re: fclean all
	
include .depend

