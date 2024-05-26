require 'ruby2d'
require_relative 'tile'
require_relative 'word_pair'
require 'debug'

class Grid
  attr_reader :word_pairs, :tile_size, :tile_spacing, :grid_size, :selected_words,
              :grid_pixels, :tile_colour, :x, :y, :padding, :starting_position
  attr_accessor :tiles

  def initialize(opts)
    @x = opts.fetch(:x, 0)
    @y = opts.fetch(:y, 0)
    @padding =  opts.fetch(:padding, 1)
    @word_pairs = opts[:word_pairs]
    @tile_size = opts.fetch(:tile_size, 100)
    @tile_colour = opts.fetch(:tile_colour, 'blue')
    @tile_spacing = opts.fetch(:tile_spacing, 1)
    @tiles = []
    draw_grid
  end

  def grid_size
    # Find the largest square that can be made with a root divisible by 2
    @grid_size ||= (Math.sqrt(word_pairs.flatten.count).to_i / 2) * 2
  end

  def selected_words
    @selected_words ||= word_pairs.shuffle[..grid_size**2/2-1].flatten.shuffle
    @selected_words.dup
  end

  def grid_pixels
    @grid_pixels ||= grid_size * (tile_size) +
                     (grid_size - 1) * tile_spacing +
                     2 * padding
  end
  
  def starting_position
    @starting_position ||= [x + padding, y + padding]
  end

  private

  def draw_grid
    x0, y0 = starting_position
    remaining_words = selected_words
    xt, yt = [x0, y0]
    grid_size.times do
      grid_size.times do
        tiles << Tile.new(
          x: xt,
          y: yt,
          size: tile_size,
          color: tile_colour,
          label_text: remaining_words.pop
        )
        xt += (tile_size + tile_spacing) 
      end
      xt = x0
      yt += (tile_size + tile_spacing) 
    end
  end
end