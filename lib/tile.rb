require 'ruby2d'
require 'debug'

class Tile < Square
  def initialize(opts)
    @x = opts.fetch(:x, 0)
    @y = opts.fetch(:y, 0)
    @size = opts.fetch(:size, 100)
    @color = opts.fetch(:color, 'blue')
    @opacity = opts.fetch(:opacity, 1)
    label_text = opts.fetch(:label_text, '')
    label_colour = opts.fetch(:label_colour, 'black')

    # Create square
    super(x: opts[:x], y: opts[:y], size: opts[:size], color: opts[:color], opacity: opts[:opacity])

    create_label(label_text, label_colour)
  end

  attr_reader :x, :y, :size
  attr_accessor :colour, :opacity, :label

  private

  def create_label(text, font_colour)
    @label = Text.new(
      text,
      x: x + size/3,
      y: y + size/4,
      size: 10,
      colour: font_colour,
      #font: font_path
    )

    scale_factor = (self.size * 0.8) / [@label.height, @label.width].max
    @label.size = (@label.size * scale_factor).to_i
    x_offset, y_offset = [@label.width, @label.height].map { |d| (size - d)/2 }
    @label.x,  @label.y = [self.x1 + x_offset, self.y1 + y_offset]
  end


  #def font_path
  #  File.expand_path('./fonts/NotoSansCJK-Regular.ttc', __dir__)
  #end
end