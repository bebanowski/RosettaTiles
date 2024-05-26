require_relative '../lib/grid'

RSpec.describe Grid do
  let(:grid) do
    Grid.new(
     word_pairs:,
     tile_size: 100,
     padding: 10,
     tile_spacing: 5
    )
  end

  let(:word_pairs) do
    [
      # Pairs to form 4x4 square grid
      ['A', 'a'], ['B', 'b'],
      ['C', 'c'], ['D', 'd'],
      ['E', 'e'], ['F', 'f'],
      ['G', 'g'], ['H', 'h'],
      # Surplus pairs
      ['Y', 'y'], ['Z', 'z']
    ]
  end

  describe '#initialize' do
    it 'initializes a grid with the correct properties' do
      # Draws the largest square grid possible (4x4) given the number of pairs
      expect(grid.tiles.count).to eq 16
      expect(grid.grid_size).to eq 4
      expect(grid.selected_words.count).to eq 16

      # Dimensions are correct
      expect(grid.tile_size).to eq 100
      expect(grid.tile_spacing).to eq 5
      expect(grid.grid_pixels).to eq 435
      expect(grid.starting_position).to eq [10, 10]

      # Tiles are correct
      t1 = grid.tiles.first
      t16 = grid.tiles.last

      expect(t1.size).to eq 100
      expect([t1.x1, t1.x2, t1.x3, t1.x4]).to eq [10, 110, 110, 10]
      expect([t1.y1, t1.y2, t1.y3, t1.y4]).to eq [10, 10, 110, 110]

      expect(t16.size).to eq 100
      expect([t16.x1, t16.x2, t16.x3, t16.x4]).to eq [325, 425, 425, 325]
      expect([t16.y1, t16.y2, t16.y3, t16.y4]).to eq [325, 325, 425, 425]

      # Word pairs are fetched and shuffled
      tile_words = grid.tiles.map { |t| t.label.text }

      expect(grid.selected_words.sort).to eq tile_words.sort

      tile_words
        .sort_by { |word| word.downcase }
        .each_slice(2)
        .to_a
        .map { |p| p.sort }
        .each { |p| expect(word_pairs).to include(p) }
    end
  end
end
