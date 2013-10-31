
# https://gist.github.com/rob-brown/7237656
# https://twitter.com/robby_brown/status/395620508865024000

defmodule CommandSigil do

  # 'x' is for 'execute'.
  defmacro sigil_x({ :<<>>, _line, [string] }, []) when is_binary(string) do
    string
      |> Macro.unescape_string()
      |> String.to_char_list!()
      |> :os.cmd()
  end

  defmacro sigil_x({ :<<>>, line, pieces }, []) do
    binary = { :<<>>, line, Macro.unescape_tokens(pieces) }
    quote do
      unquote(binary)
        |> String.to_char_list!()
        |> :os.cmd()
    end
  end
  
  defmacro sigil_X({ :<<>>, _line, [string] }, []) when is_binary(string) do
    string
      |> String.to_char_list!()
      |> :os.cmd()
  end

end

defmodule CommandSigil.Test do
  
  import CommandSigil
  
  def test_sigil_with_var do
    dir = "~/"
    %x"ls -al #{dir}/*"
  end
  
  def test_sigil_interpolated do
    %x"echo Hello \x45\x6c\x69\x78\x69\x72\x21" # => 'Hello Elixir!\n'
  end
  
  def test_sigil_non_interpolated do
    %X"echo Hello \x45\x6c\x69\x78\x69\x72\x21" # => 'Hello x45x6cx69x78x69x72x21\n'
  end
  
end
