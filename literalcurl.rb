require 'json'
require 'colorize'

puts 'literalcurl: Look up and copy Scripture straight into your clipboard.'.yellow

while true do
  begin
    print '> '.yellow

    query = gets.strip

    raw = `curl -s 'http://nasb.literalword.com/?q=#{query}&format=json&token=#{ENV['LITERAL_WORD_TOKEN']}'`
    parsed = JSON.parse(raw)

    if parsed['error'] then
      puts 'Error.'.red
    else
      ref = parsed.keys.join('')
      val = "#{ref} #{parsed.values.join('').gsub('"', '\"')}"
      result = `echo "#{val}" | pbcopy`
      puts "#{ref} copied to clipboard!".green
    end
  rescue
    puts 'Error.'.red
  end
end

