class TitleBracketsValidator < ActiveModel::Validator
  def validate(movie)
    movie.errors[:title] << "Empty brackets" if has_empty_brackets?(movie.title)
    movie.errors[:title] << "Unbalanced brackets" unless balanced?(movie.title)
  end

  def balanced?(string)
    without_brackets = string.delete(brackets_pairs.join)
    brackets_only = string.delete(without_brackets).tr("-^", "")
    while has_empty_brackets?(brackets_only)
      brackets_pairs.each { |brackets| brackets_only.sub! brackets, "" }
    end
    brackets_only.empty?
  end

  def has_empty_brackets?(string)
    brackets_pairs.select { |brackets| string.include? brackets }.any?
  end

  def brackets_pairs
    ["()", "[]", "{}"]
  end
end
