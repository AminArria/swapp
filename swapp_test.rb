#!/usr/bin/ruby
require_relative 'swapp'
require 'minitest/autorun'


class TestSwapp < MiniTest::Test
  def test_valid_chars_both_nil
    out, err = capture_io do
      assert_raises SystemExit do
        valid_chars(nil, nil)
      end
    end

    assert_equal "You need to specify TWO character names in the script arguments\n", err
  end

  def test_valid_chars_char1_nil
    out, err = capture_io do
      assert_raises SystemExit do
        valid_chars(nil, 'yoda')
      end
    end

    assert_equal "You need to specify TWO character names in the script arguments\n", err
  end

  def test_valid_chars_char2_nil
    out, err = capture_io do
      assert_raises SystemExit do
        valid_chars('yoda', nil)
      end
    end

    assert_equal "You need to specify TWO character names in the script arguments\n", err
  end

  def test_char_films_not_exist
    out, err = capture_io do
      assert_raises SystemExit do
        get_char_films('rick sanchez')
      end
    end

    assert_equal "rick sanchez is not a character in Star Wars\n", err
  end

  def test_char_films
    films = ['2','5','4','6','3']
    assert_equal films, get_char_films('yoda')
  end

  def test_get_common_films_titles
    films1 = [1,2]
    films2 = [1,3]
    assert_equal ['A New Hope'], get_common_films_titles(films1, films2)
  end

  def test_print_titles
    assert_output "A New Hope\n" do
      print_titles(['A New Hope'])
    end
  end

  def test_script_fail_no_characters
    out, err = capture_subprocess_io do
      assert_equal false, system("ruby swapp.rb")
    end

    assert_equal "You need to specify TWO character names in the script arguments\n", err
  end

  def test_script_fail_one_character
    out, err = capture_subprocess_io do
      assert_equal false, system("ruby swapp.rb luke")
    end

    assert_equal "You need to specify TWO character names in the script arguments\n", err
  end

  def test_script_fail_wrong_character
    out, err = capture_subprocess_io do
      assert_equal false, system("ruby swapp.rb bender luke")
    end

    assert_equal "bender is not a character in Star Wars\n", err
  end

  def test_script_success
    out, err = capture_subprocess_io do
      assert_equal true, system("ruby swapp.rb luke leia")
    end

    assert_equal "The Empire Strikes Back\nRevenge of the Sith\nReturn of the Jedi\nA New Hope\nThe Force Awakens\n", out
  end
end