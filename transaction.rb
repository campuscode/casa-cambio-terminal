class Transaction
  attr_accessor :quantity, :currency, :quotation, :transaction_type

  def initialize(quantity:, currency:, quotation:, transaction_type:)
    @quantity = quantity
    @currency = currency
    @quotation = quotation
    @transaction_type = transaction_type
  end

  def confirm?
    puts 'Deseja continuar? s / n'
    opcao = gets.chomp
    return true if opcao.eql? 's'
    false
  end

  def total
    quantity * quotation
  end

  def to_s
    "Quantidade: #{quantity} | Moeda: #{currency_translated} "\
    " | Cotação: #{quotation} | Tipo: #{transaction_type_translated}"
  end

  private

  def currency_translated
    return 'Dólar' if currency.eql? 'dollar'
    'Real'
  end

  def transaction_type_translated
    return 'Compra' if transaction_type.eql? 'buy'
    'Venda'
  end
end
