json.array!(@budgets) do |budget|
  json.extract! budget, :id, :amount
  json.url budget_url(budget, format: :json)
end
