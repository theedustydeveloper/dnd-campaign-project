module PagyHelper
  include Pagy::Frontend

  # Helper method to format Pagy data for Tabulator
  def pagy_tabulator(collection, vars = {})
    pagy, records = pagy(collection, vars)

    {
      data: records,
      last: pagy.last
    }.to_json
  end
end
