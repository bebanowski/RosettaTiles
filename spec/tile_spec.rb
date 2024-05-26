require_relative '../lib/tile'

RSpec.describe Tile do
  let(:tile) do
    Tile.new(
      x: 10,
      y: 20,
      size: 105,
      color: 'green',
      opacity: 0.9,
      label_text: 'Label1',
      label_colour: 'black'
    )
  end

  describe '#initialize' do
    it 'initializes a tile with the correct properties' do
      # Square-derived properties
      expect(tile.x).to eq 10
      expect(tile.y).to eq 20
      expect(tile.size).to eq 105
      expect(tile.height).to eq 105
      expect(tile.width).to eq 105
      expect(tile.color.to_a).to eq [0.1803921568627451, 0.8, 0.25098039215686274, 0.9] # default green
      expect(tile.color.r).to be_within(0.01).of(0.180)
      expect(tile.color.g).to be_within(0.01).of(0.8)
      expect(tile.color.b).to be_within(0.01).of(0.251)     
      expect(tile.color.a).to eq 0.9

      # Tile label initialized correctly
      expect(tile.label.text).to eq 'Label1'
      expect(tile.label.color.r).to be_within(0.01).of(0.067)
      expect(tile.label.color.g).to be_within(0.01).of(0.067)
      expect(tile.label.color.b).to be_within(0.01).of(0.067)
      expect(tile.label.size).to eq 26
      expect(tile.label.x).to eq 24
      expect(tile.label.y).to eq 55
    end
  end
end