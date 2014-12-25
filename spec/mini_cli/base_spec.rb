require_relative '../spec_helper'

describe MiniCli::Base do
  subject{ MiniCli::Base.new }

  it 'can build instances' do
    expect(subject).to be_a(MiniCli::Base)
  end
end
