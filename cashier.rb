require_relative 'transaction'

class Cashier
  attr_accessor :quotation, :dollar_amount, :real_amount, :transactions

  def initialize
    print 'Digite a cotação do dólar hoje: $ '
    @quotation = gets.to_f
    print 'Digite a quantidade de dólar em caixa: $ '
    @dollar_amount = gets.to_f
    print 'Digite a quantidade de real em caixa: R$ '
    @real_amount = gets.to_f
    @transactions = []
  end

  def buy_dollars(quantity)
    transaction = Transaction.new(quantity: quantity, currency: 'dollar',
                                  quotation: quotation, transaction_type: 'buy')
    transaction.save
    puts "Essa transação vai custar R$ #{transaction.total}"
    if transaction.confirm?
      self.dollar_amount += transaction.quantity
      self.real_amount -= transaction.total
      transactions << transaction
      puts 'Operação realizada com sucesso'
      return
    end
    puts 'Operação não realizada'
  end

  def sell_dollars(quantity)
    transaction = Transaction.new(quantity: quantity, currency: 'dollar',
                                  quotation: quotation, transaction_type: 'buy')
    transaction.save
    puts "Essa transação vai custar R$ #{transaction.total}"
    if transaction.confirm?
      self.dollar_amount -= transaction.quantity
      self.real_amount += transaction.total
      transactions << transaction
      puts 'Operação realizada com sucesso'
      return
    end
    puts 'Operação não realizada'
  end

  def to_s
    <<~HEREDOC
    Dólar em caixa: $ #{dollar_amount}
    Real em caixa: R$ #{real_amount}
    Cotação do dólar: R$ #{quotation}
    Transação do dia
    #{transactions.map { |t| t.to_s }.join("\n")}
    HEREDOC
  end
end
