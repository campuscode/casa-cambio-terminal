require 'sqlite3'

class Transaction
  attr_accessor :id, :quantity, :currency, :quotation, :transaction_type

  def initialize(id: nil, quantity:, currency:, quotation:, transaction_type:)
    @id = id
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

  def save
    insert_on_database
  end

  def self.find(id)
    db = SQLite3::Database.open 'currency_exchange.db'
    db.results_as_hash = true
    results = db.execute2 <<-SQL
      SELECT * FROM transactions
      WHERE id = #{id}
      LIMIT 1
    SQL
    parse_all(results).first
  end

  private

  def self.parse_all(results)
    results[1..-1].map do |result|
      result.transform_keys!(&:to_sym)
      new(result)
    end
  end

  def currency_translated
    return 'Dólar' if currency.eql? 'dollar'
    'Real'
  end

  def transaction_type_translated
    return 'Compra' if transaction_type.eql? 'buy'
    'Venda'
  end

  def insert_on_database
    db = SQLite3::Database.open 'currency_exchange.db'
    db.execute("
      INSERT INTO transactions (quantity, currency, quotation, transaction_type)
      VALUES
        (?, ?, ?, ?)
        ", [quantity, currency, quotation, transaction_type])
    db.close
  end
end
