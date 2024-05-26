require 'ruby2d'
require_relative 'tile'
require_relative 'word_pair'
require_relative 'grid'

grid = Grid.new(word_pairs: WORDS, tile_size: 100, padding: 5, spacing: 1)
selected_tiles = []
completed_tiles = []
tick = 0

set( { title: 'Word Matcher', background: 'black', height: grid.grid_pixels, width: grid.grid_pixels } )

on :mouse_down do |event|
  # Find the tile that was clicked on
  selected_tile = grid.tiles.find do |tile|
    event.x >= tile.x && event.x <= tile.x + tile.size &&
    event.y >= tile.y && event.y <= tile.y + tile.size
  end
  
  # If no tile was clicked on, ignore
  next unless selected_tile

  # If 2 tiles already selected, ignore (CHECK)
  next if selected_tiles.count >= 2

  # If the tile that was clicked on has already been eliminated, ignore
  next if completed_tiles.include?(selected_tile)

  if event.button == :left # Selection
    next if selected_tiles.include?(selected_tile)
    selected_tiles << selected_tile

  elsif event.button == :right # Deselection
    next unless selected_tiles.include?(selected_tile)
    selected_tile.color = 'blue'

    # Cache the deselection
  selected_tiles.delete(selected_tile)
  end
end






update do
  selected_tiles.each do |t|
    t.color = 'white'
    t.label.colour = 'black'
  end

  next unless selected_tiles.count == 2
  tick += 1
  next unless tick % 30 == 0


  selected_words = selected_tiles.map {|t| t.label.text}
  
  # If the pair of words is a valid pair
  if WORDS.include?(selected_words) || WORDS.include?(selected_words.reverse)
    selected_tiles.each do |t|
      # Make the tiles disappear
      t.size = 0
      t.label.text = ''
      # Cache the completion
      completed_tiles << t
    end
  # If the pair of words is not a valid pair
  else    
    # Set the tiles back to their original unselected colours
    selected_tiles.each do |t|
      t.color = 'blue'
    end
  end
  
  # Regardless of whether the pair was valid or not, remove them from the selection
  selected_tiles = []
end

show