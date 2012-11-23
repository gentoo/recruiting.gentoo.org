class HtmlWithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    options = { options: {encoding: 'utf-8'} }

    if Pygments::Lexer.find(language)
      Pygments.highlight(code, options.merge(lexer: language.downcase))
    else
      Pygments.highlight(code, options)
    end
  end

  def triple_emphasis(text)
    "<script src='#{text}.js' type='text/javascript' />"
  end
end
