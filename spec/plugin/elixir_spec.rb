require 'spec_helper'

describe "elixir" do
  let(:filename) { "test.ex" }

  before :each do
    vim.set(:expandtab)
    vim.set(:shiftwidth, 2)
  end

  describe "functions" do
    specify "0 arity" do
      set_file_contents <<~EOF
        defmodule Foo do
          def bar() do
            :bar
          end
        end
      EOF

      vim.search 'def bar'
      join

      assert_file_contents <<~EOF
        defmodule Foo do
          def bar(), do: :bar
        end
      EOF

      vim.search 'def bar'
      split

      assert_file_contents <<~EOF
        defmodule Foo do
          def bar() do
            :bar
          end
        end
      EOF
    end

    specify "0 arity no parens" do
      set_file_contents <<~EOF
        defmodule Foo do
          def bar do
            :bar
          end
        end
      EOF

      vim.search 'def bar'
      join

      assert_file_contents <<~EOF
        defmodule Foo do
          def bar, do: :bar
        end
      EOF

      vim.search 'def bar'
      split

      assert_file_contents <<~EOF
        defmodule Foo do
          def bar do
            :bar
          end
        end
      EOF
    end

    specify "1 arity" do
      set_file_contents <<~EOF
        defmodule Foo do
          def bar(foo) do
            :bar
          end
        end
      EOF

      vim.search 'def bar'
      join

      assert_file_contents <<~EOF
        defmodule Foo do
          def bar(foo), do: :bar
        end
      EOF

      vim.search 'def bar'
      split

      assert_file_contents <<~EOF
        defmodule Foo do
          def bar(foo) do
            :bar
          end
        end
      EOF
    end
  end
end
