require 'erb'
f = open("quizzes.txt")

references = {"devmanual" => ["Dev Manual", "http://devmanual.gentoo.org/"],
  "handbook" => ["Handbook", "http://www.gentoo.org/doc/en/handbook/"],
  "GLEPs" => ["GLEPs", "http://www.gentoo.org/proj/en/glep/"]}


title = f.readline.strip
puts title

id = ""
quiz = []
docs = ""

template = ERB.new <<-EOF
**<%= quiz.join(" ") %>**

### docs
<% docs.strip.split(",").each do |d| %>
* [<%= references[d] && references[d][0] || d %>](<%= references[d] && references[d][1] || "" %>)
<% end %>
EOF

first_r = /^(\d+\.\s+(\(\w\))?)(.+)$/
f.each_line do |line|
  unless line =~ /^\s+$/
    if m = first_r.match(line)
      id = m[1].gsub(/[\.\s]+/, "")
      quiz << m[3].to_s.strip
    elsif line =~ /^\s+?(\s.+)$/
      quiz << $1.to_s.strip
    elsif line =~ /^docs\:\s(.+)$/
      docs = $1
      puts template.result(binding)
      Question.create(title: "#{title[1..-1]} #{id}", content: template.result(binding), group_id: 1)
      id = ""
      quiz = []
      docs = ""
    end
  end
end

f.close
