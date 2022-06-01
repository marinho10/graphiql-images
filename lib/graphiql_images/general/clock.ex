defmodule GraphiQLImages.General.Clock do
  @moduledoc """
  Module to provide helper on testing to manipulate time
  Thanks to: https://codeincomplete.com/articles/testing-dates-in-elixir/
  """

  @config Application.compile_env(:graphiql_images, __MODULE__) || []

  if @config[:freezable] do
    def now do
      Process.get(:mock_utc_now) || Timex.now()
    end

    def freeze do
      Process.put(:mock_utc_now, now())
    end

    def freeze(%DateTime{} = on) do
      Process.put(:mock_utc_now, on)
    end

    def unfreeze do
      Process.delete(:mock_utc_now)
    end

    defmacro time_travel(to, do: block) do
      alias GraphiQLImages.General.Clock

      quote do
        # save the current time
        previous = Clock.now()
        # freeze the clock at the new time
        Clock.freeze(unquote(to))
        # run the test block
        result = unquote(block)
        # reset the clock back to the previous time
        Clock.freeze(previous)
        # and return the result
        result
      end
    end
  else
    def now do
      Timex.now()
    end
  end
end
