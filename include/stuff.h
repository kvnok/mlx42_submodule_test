#ifndef STUFF_H
# define STUFF_H

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <limits.h>
#include <stdbool.h>
#include <sys/time.h>
#include <math.h>
#include <fcntl.h>
# include "../MLX42/include/MLX42/MLX42.h"

#define WIDTH 1280
#define HEIGHT 960

typedef struct s_data
{
	mlx_t			*mlx;
	mlx_image_t		*img;
	uint32_t color;
}	t_data;

#endif
