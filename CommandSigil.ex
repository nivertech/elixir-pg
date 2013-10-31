defmodule CommandSigil do

  # x for eXecute, like in Ruby
  def sigil_x(cmd, _opts) do
    { :ok, list } = String.to_char_list(cmd)
    :os.cmd(list)
  end

  def sigil_X(cmd, _opts) do
    { :ok, list } = String.to_char_list(cmd)
    :os.cmd(list)
  end

end

defmodule CommandSigil.Test do
  
  import CommandSigil
  
  def test_sigil do
    %x"ls -l"
  end
  
  def test_sigil_with_var do
    dir = "~/"
    %X"ls -al #{dir}/*"
  end
  
end
