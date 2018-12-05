require_relative 'transaction'

puts 'Bem vindo ao Sistema de Câmbio'
transactions = []

print 'Digite a cotação do dólar hoje: $ '
quotation = gets.to_f
print 'Digite a quantidade de dólar em caixa: $ '
dollar_amount = gets.to_f
print 'Digite a quantidade de real em caixa: R$ '
real_amount = gets.to_f

puts "\n========== Menu =========="
puts "1 - Comprar Dólar"
puts "2 - Vender Dólar"
puts "3 - Balanço"
puts "4 - Sair"
print 'Digite a opção desejada: '
menu = gets.to_i

loop do
  case menu
  when 1
    print 'Qual a quantidade em dólar que deseja incluir no caixa? $ '
    quantity = gets.to_i
    transaction = Transaction.new(quantity: quantity, currency: 'dollar',
                                  quotation: quotation, transaction_type: 'buy')
    puts "Essa transação vai custar R$ #{transaction.total}"
    if transaction.confirm?
      dollar_amount += transaction.quantity
      real_amount -= transaction.total
      transactions << transaction
      puts 'Operação realizada com sucesso'
    else
      puts 'Operação não realizada'
    end
    puts "\nPressione qualquer tecla para continuar"
    gets
  when 2
    print 'Qual a quantidade em dólar que deseja retirar do caixa? $ '
    quantity = gets.to_i
    transaction = Transaction.new(quantity: quantity, currency: 'dollar',
                                  quotation: quotation,
                                  transaction_type: 'sell')
    puts "Essa transação vai incluir R$ #{transaction.total}"
    if transaction.confirm?
      dollar_amount -= transaction.quantity
      real_amount += transaction.total
      transactions << transaction
      puts 'Operação realizada com sucesso'
    else
      puts 'Operação não realizada'
    end
    puts "\nPressione qualquer tecla para continuar"
    gets
  when 3
    puts "\nDólar em caixa: $ #{dollar_amount}"
    puts "Real em caixa: R$ #{real_amount}"
    puts "Cotação do dólar: R$ #{quotation}"
    puts "\nTransação do dia"
    puts transactions
  when 4
    exit 0
  else
    puts 'Opção inválida'
  end

  puts "\n========== Menu =========="
  puts "1 - Comprar Dólar"
  puts "2 - Vender Dólar"
  puts "3 - Balanço"
  puts "4 - Sair"
  print 'Digite a opção desejada: '
  menu = gets.to_i
end
