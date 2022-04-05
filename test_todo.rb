require "./todo.rb"
require "minitest/autorun"

class TestToDo < Minitest::Test
  def setup
    @todo = ToDo.new
  end

  def test_case_add
    assert_output(/Item salvo com sucesso!/) {@todo.menuOptions("add", "LEONARDO", "ADASD", "OPEN")}
  end

  def test_case_add_error
    assert_output(/Item salvo com sucesso!/) {@todo.menuOptions("add", "LEONARDO", "ADASD", "OPEN")}
  end

  def test_case_delete
    assert_output(/Item salvo com sucesso!/) {@todo.menuOptions("delete", 1, "", "")}
  end

  def test_case_delete_error
    assert_output(/"Deverá existir: 'nome', 'descricao', 'status'"/) {@todo.menuOptions("delete", 999, "", "")}
  end

  def test_case_list
    assert_output(/Itens desenhados!/) {@todo.menuOptions("list", "", "", "")}
  end
end
