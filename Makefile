SHELL := /bin/bash

#always out-of-date
# .FORCE: ;

NAME := undertest
SRC_DIR := src
OBJ_DIR := obj
MLX42_DIR := MLX42
MLX42 := $(MLX42_DIR)/build/libmlx42.a
HEADERS := $(shell find include -type f -name '*.h')
SOURCES := $(shell find $(SRC_DIR) -type f -name '*.c')
OBJECTS := $(patsubst $(SRC_DIR)%,$(OBJ_DIR)%,$(SOURCES:.c=.o))

#mlx42 git repo things
# MLX42_REPO = git@github.com:codam-coding-college/MLX42.git
# MLX42_IN := $(shell if [ -d "$(MLX42_DIR)" ]; then echo 1; else echo 0; fi)

#debug output print MLX42_IN
# $(info MLX42_IN: $(MLX42_IN))

#git submodule add $(MLX42_REPO) $(MLX42_DIR)
# ifeq ($(MLX42_IN), 0)
# $(MLX42_DIR):
# 	git submodule update --init
# else
# $(MLX42_DIR):
# endif

CC  := cc
IFLAGS := -Iinclude -I$(MLX42_DIR)/include
CFLAGS := 
#-Wall -Wextra -Werror
LFLAGS := -L$(MLX42_DIR)/build -lmlx42 -lglfw -ldl -pthread -lm

_DEBUG := 0
ifeq ($(_DEBUG),1)
	CFLAGS += -g3 -fsanitize=address
endif

#$(MLX42_DIR)
all: $(MLX42) $(NAME)

$(MLX42): #.FORCE
	cmake $(MLX42_DIR) -B $(MLX42_DIR)/build
	$(MAKE) -C $(MLX42_DIR)/build -j4 --quiet

$(NAME): $(OBJ_DIR) $(OBJECTS)
	$(CC) $(OBJECTS) $(LFLAGS) -o $(NAME) 

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(HEADERS)
	mkdir -p $(dir $@)
	$(CC) $(SIZE_FLAGS) $(CFLAGS) $(IFLAGS) -c $< -o $@

clean:
	$(MAKE) clean -C $(MLX42_DIR)/build -j4 --quiet
	rm -rf $(OBJ_DIR)

fclean: clean
	$(MAKE) clean/fast -C $(MLX42_DIR)/build -j4 --quiet
	-rm -f $(NAME)

re: fclean all

.PHONY: all, clean, fclean, re
