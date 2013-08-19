shared_examples_for "a command" do
  it { should respond_to(:perform) }
end
