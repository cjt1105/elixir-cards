defmodule Cards do
	@moduledoc """
  	Provides methods for creating and handling a deck of cards
	"""

  @doc """
    Returns a list of strings representing a deck of playing cards
  """

    def create_deck do
        cards = ["Ace", "Two", "Three", "Four", "Five"]
        suits = ["Clubs", "Spades", "Hearts", "Diamonds"]

        for suit <- suits, card <- cards do
            "#{card} of #{suit}"
        end
    end

    def shuffle(deck) do
        Enum.shuffle(deck)
    end

    def contains?(deck, card) do
        Enum.member?(deck, card)
    end

	@doc """
		Divides deck into  hand and the remainder of the deck. The `hand_size` argument indicates how many cards should be in the hand.

		## Examples
			iex> deck = Cards.create_deck
			iex> {hand,deck} = Cards.deal(deck, 1)
			iex> hand
			["Ace of Clubs"] 
    """

    def deal(deck, hand_size) do
        Enum.split(deck, hand_size)
    end

    def save(deck, filename) do
        binary = :erlang.term_to_binary(deck)
        File.write(filename, binary)
    end

    def load(filename) do

        case File.read(filename) do
            {:ok, binary} -> file = :erlang.binary_to_term(binary)
            {:error, _reason} -> "File does not exist"
        end
    end

    def create_hand(hand_size) do
        Cards.create_deck
        |> Cards.shuffle
        |> Cards.deal(hand_size)
    end
end
