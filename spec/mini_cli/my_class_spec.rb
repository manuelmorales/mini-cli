require_relative '../spec_helper'

describe MiniCli::MyClass do
  subject{ MiniCli::MyClass.new }

  it 'can build instances' do
    expect(subject).to be_a(MiniCli::MyClass)
  end
end
