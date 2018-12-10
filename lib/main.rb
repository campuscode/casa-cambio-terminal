require_relative 'cashier'
require 'io/console'

class Main
  attr_reader :cashier

  def initialize
    puts 'Bem vindo ao Sistema de Câmbio'
    @cashier = Cashier.new
  end

  def start
    loop do
      case menu
      when 1
        print 'Qual a quantidade em dólar que deseja incluir no caixa? $ '
        quantity = gets.to_i
        cashier.buy_dollars(quantity)
        wait_keyboard
        clear
      when 2
        print 'Qual a quantidade em dólar que deseja retirar do caixa? $ '
        quantity = gets.to_i
        cashier.sell_dollars(quantity)
        wait_keyboard
        clear
      when 3
        clear
        puts cashier
        wait_keyboard
        clear
      when 4
        exit 0
      else
        puts 'Opção inválida'
        wait_keyboard
        clear
      end
    end
  end

  private

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

  def clear
    system('clear')
  end
end
