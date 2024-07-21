# Iterate over the rows in the CSV file and process each row

require 'csv'
require 'json'
require 'pry'
require 'tempfile'

TEMPLATE = """
Target Phrase language code: %s
Target Phrase: %s
Target Phrase Translation: %s

Input Phrase: %s
Input Phrase translation: %s

Is the input phrase equivalent to the target phrase?
(YES/NO)
---
%s
"""

csv_data = CSV.read("data.csv", headers: true)

def word_wrap(text, width = 80)
  words = text.split
  wrapped_text = ""
  current_line = ""

  words.each do |word|
    if current_line.length + word.length + 1 > width
      wrapped_text += current_line.rstrip + "\n"
      current_line = word + " "
    else
      current_line += word + " "
    end
  end

  wrapped_text += current_line.rstrip
  wrapped_text
end

# Iterate over the rows in the CSV file
csv_data.each do |data|
  path = "data/#{data["id"]}.txt"
  next if File.file?(path)
  row = data.to_h
  if row["quizType"] == "speaking" && row["yesNo"] == "no"
    # This is the text we want to edit:
    text = TEMPLATE % [
        row["langCode"],
        row["term"],
        row["definition"],
        row["userInput"],
        row["englishTranslation"],
        word_wrap([row["yesNo"], row["explanation"]].join(", ")),
    ]

    Tempfile.open('edit') do |file|
      file.write(text)
      file.flush
  
      system("micro #{file.path}")
  
      file.rewind
      edited_text = file.read
      exit if edited_text.split("\n").first == "quit"
      File.write(path, edited_text)
    end
  end
end
