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
      puts "Error: #{parsed['error']}.".red
    else
      ref = parsed.keys.join('')
      val = "#{ref} #{parsed.values.join('')}"
      result = `echo "<p style='font-family: \"Helvetica Neue\";font-size:18px;'><i>#{val.gsub('"', '\"')}</i></p>" | textutil -stdin -format html -convert rtf -stdout | pbcopy`
      puts "#{val}".green
    end
  rescue
    puts 'Error.'.red
  end
  puts
end

