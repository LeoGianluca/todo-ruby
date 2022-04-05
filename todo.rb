require 'csv'
require 'pry'

class Task  # Controller
  attr_accessor :id, :name, :description, :status, :created_at, :updated_at

  def initialize(option = {})
    @id = option.fetch(:id){nil}
    @name = option.fetch(:name)
    @description = option.fetch(:description){nil}
    @status = option.fetch(:status){'OPEN'}
    @created_at = option.fetch(:created_at){nil}
    @updated_at = option.fetch(:updated_at){nil}
	end
end

class List  # Model
  attr_reader :file, :list

  def initialize(file)
    @file = file
    @list = nil
  end

  def parse_file
    return @list if @list
    @list = []

    CSV.foreach(@file) { |row|
      row = Task.new(
        id: @list.size,
        name: row[1],
        description: row[2],
        status: row[3],
        created_at: row[4],
        updated_at: row[5])
      add(row)
    }
  end

  def display  #View
    puts "\n|--------------------------------------------------------------------------------------------------------------------------------------------|"
    puts "| ID\t| NOME DA TAREFA\t\t| DESCRICAO\t\t\t| STATUS  | DATA DE CRIACAO\t\t| DATA DE ALTERACAO\t     |"
    puts "|--------------------------------------------------------------------------------------------------------------------------------------------|"

    @list.each_with_index { |task, index|
      puts "| #{task.id+1}\t| #{task.name}\t\t| #{task.description}\t\t\t| #{task.status}  | #{task.created_at} | #{task.updated_at}  |"
    }
    puts "|--------------------------------------------------------------------------------------------------------------------------------------------|"
    puts "Itens desenhados!"
  end

  def add(task)
    if task.id == nil
      task.id = @list.size + 1
    end

    if !task.name.empty? && !task.description.empty? && !task.status.empty?
      @list << task
      save()
      print "\e[H"
      print "\e[2J"
      puts "\t\nItem salvo com sucesso!"
    else
      print "\e[H"
      puts "\t\nDeverá existir: 'nome', 'descricao', 'status'"
    end
  end

  def update_list(list)
    list.each_with_index { |row, index| row.id = index }
  end

  def delete(task_number)
    if @list.size > 0 && @list[task_number - 1] 
      @list.delete_at(task_number-1)
      update_list(@list)

      puts "O item foi removido das tarefas com sucesso!"
    else
      puts "Não existe(m) o(s) item(ns) na lista!"
    end
  end

  def save
    CSV.open(@file, "w+") { |csv|
      @list.each { |task|
        csv << [task.id, task.name, task.description, task.status, task.created_at, task.updated_at]
      }
    }
  end
end

class ToDo 
  def start
    if ARGV.any?
      option_arg, one_arg, two_arg, *outher_arg = ARGV
      if !outher_arg.empty?
        outher_arg =  outher_arg.join(" ")
      end
    end

    menuOptions(option_arg, one_arg, two_arg, *outher_arg)
  end

  def menuOptions(option_arg, one_arg, two_arg, *outher_arg)
    list = List.new('./tmp/tasks.csv')
    list.parse_file
    list.save

    case option_arg
      when "list"
        clear_screen!
        got_to_start!
        list.display
  
      when "add"
        new_task = Task.new(name: one_arg, description: two_arg, status: outher_arg, created_at: Time.now, updated_at: Time.now)
        list.add(new_task)
  
      when "delete"
        if ARGV[1].nil?
          puts "\nOpção inválida! Voce deve informar o ID para exclusao do item."
        else
          one_arg = one_arg.to_i
          list.delete(one_arg)
          list.save
        end
        got_to_start!

      when "help"
        clear_screen!
        got_to_start!
        puts "\n\t==== ToDo List ===="
        puts "\n\truby todo.rb add ['nome', 'descricao', 'status (OPEN / PENDING / CLOSE)']"
        puts "\truby todo.rb delete 1 - [Insira o ID do item]"
        puts "\truby todo.rb list"
        puts ""
      else 
        puts "Opção inválida! Tente novamente!"
    end
  end

  private 
    def clear_screen!
      print "\e[2J"
    end

    # Move o cursor para o canto superior esquerdo do console
    def got_to_start!
      print "\e[H"
    end
end

todo = ToDo.new
todo.start