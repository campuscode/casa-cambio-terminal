require_relative 'cashier'
require 'io/console'

puts 'Bem vindo ao Sistema de Câmbio'
cashier = Cashier.new

def menu
  puts "\n========== Menu =========="
  puts "1 - Comprar Dólar"
  puts "2 - Vender Dólar"
  puts "3 - Balanço"
  puts "4 - Sair"
  print 'Digite a opção desejada: '
  gets.to_i
end

def wait_keyboard
  puts "\nPressione qualquer tecla para continuar"
  STDIN.getch
end

loop do
  case menu
  when 1
    print 'Qual a quantidade em dólar que deseja incluir no caixa? $ '
    quantity = gets.to_i
    cashier.buy_dollars(quantity)
    wait_keyboard
  when 2
    print 'Qual a quantidade em dólar que deseja retirar do caixa? $ '
    quantity = gets.to_i
    cashier.sell_dollars(quantity)
    wait_keyboard
  when 3
    puts cashier
  when 4
    exit 0
  else
    puts 'Opção inválida'
  end
end
