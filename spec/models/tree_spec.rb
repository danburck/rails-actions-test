require 'rails_helper'

describe Tree, type: :model do
  it 'creates a Tree instance with an age' do
    tree = Tree.new(age: 13)
    expect(tree.age).to eq(13)
  end
end
