require 'ruby2d'
require_relative 'tile'
require_relative 'word_pair'
require_relative 'grid'

grid = Grid.new(word_pairs: WORDS, tile_size: 100, padding: 5, spacing: 1)
selected_tiles = []
correct_tiles = []
incorrect_tiles = []
completed_tiles = []
tick = 0

set( { title: 'Word Matcher', background: 'black', height: grid.grid_pixels, width: grid.grid_pixels } )

on :mouse_down do |event|
  # Find the tile that was clicked on
  selected_tile = grid.tiles.find do |tile|
    event.x >= tile.x && event.x <= tile.x + tile.size &&
    event.y >= tile.y && event.y <= tile.y + tile.size
  end

  next unless selected_tile
  next if ( selected_tiles.count >= 2 || correct_tiles.any? || incorrect_tiles.any? )
  next if completed_tiles.include?(selected_tile)

  if event.button == :left # Selection
    next if selected_tiles.include?(selected_tile)
    selected_tiles << selected_tile

  elsif event.button == :right # Deselection
    next unless selected_tiles.include?(selected_tile)
    selected_tile.color = 'blue'
    selected_tiles.delete(selected_tile)
  end
end


update do
  if grid.tiles.count == completed_tiles.count
    finish = Tile.new(
      x: 0,
      y: 0,
      size: grid.grid_pixels,
      color: 'green',
      label_text: 'You Win!'
    )
  end

  selected_tiles.each { |t| t.color = 'white' }
  correct_tiles.each { |t| t.color = 'green' }
  incorrect_tiles.each { |t|  t.color = 'red' }

  next unless (selected_tiles.count == 2 || correct_tiles.any? || incorrect_tiles.any?)
  tick += 1
  next unless tick % 30 == 0
  tick = 0

  incorrect_tiles.each { |t| t.color = 'blue' }
  incorrect_tiles = []
  
  correct_tiles.each do |t|
    t.size = 0
    t.label.text = ''
    completed_tiles << t
  end
  correct_tiles = []

  selected_words = selected_tiles.map {|t| t.label.text}

  if WORDS.include?(selected_words) || WORDS.include?(selected_words.reverse)
    correct_tiles = selected_tiles
  else
    incorrect_tiles = selected_tiles
  end
  selected_tiles = []
end

show