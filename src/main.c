#include "../include/stuff.h"

int32_t pixel_select(int32_t r, int32_t g, int32_t b, int32_t a)
{
	return (r << 24 | g << 16 | b << 8 | a);
}

void loop_hook_function(void *param)
{
	t_data *data;

	data = (t_data *)param;
	int x;
	int y;

	x = 0;
	while (x < WIDTH)
	{
		y = 0;
		while (y < HEIGHT)
		{
			data->color = pixel_select(rand() % 255, rand() % 255, rand() % 255, 255);
			mlx_put_pixel(data->img, x, y, data->color);
			y++;
		}
		x++;
	}
}

void ft_on_key(mlx_key_data_t keydata, void *param)
{
	t_data *data;

	data = (t_data *)param;

	//press once
	if (keydata.action == MLX_PRESS)
	{
		//close window, exit program
		if (keydata.key == MLX_KEY_ESCAPE)
		{
			mlx_close_window(data->mlx);
			mlx_terminate(data->mlx);
			exit(0);
		}
	}
}

int main(int argc, char **argv)
{
	t_data data;

	data.mlx = mlx_init(WIDTH, HEIGHT, "up_and_down", true);
	data.img = mlx_new_image(data.mlx, WIDTH, HEIGHT);

	mlx_loop_hook(data.mlx, loop_hook_function, &data);
	mlx_key_hook(data.mlx, &ft_on_key, &data);
	mlx_image_to_window(data.mlx, data.img, 0, 0);
	mlx_loop(data.mlx);
	mlx_terminate(data.mlx);
	return 0;
}
