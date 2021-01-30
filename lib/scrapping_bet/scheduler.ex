defmodule ScrappingBet.Scheduler do
  use Quantum, otp_app: :scrapping_bet

  def work do
    result = ScrappingBet.Scrapper.Scrapper.get_smoothies_url()

    IO.inspect(result, label: "XXX")

  end
end
