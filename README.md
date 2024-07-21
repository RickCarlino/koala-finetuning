# Koala Fine Tuning

This project helps humans edit fine-tuning data from [Koala.Cards](http://koala.cards/) in a text editor. It's the final step before sending data to the [OpenAI fine tuning API](https://platform.openai.com/docs/guides/fine-tuning/when-to-use-fine-tuning).

## Required Dependencies

 * Any recent Ruby version (3.1.0 works)
 * [Micro Editor](https://micro-editor.github.io/) installed and in your $PATH
 * PGAdmin (for creating fine-tuning data dumps)

## Running

 * Clone this repo.
 * Export the contents of the `TrainingData` collection of a Koala server to CSV using PGAdmin.
 * Move the CSV to the root of this project with the name `data.csv`.
 * Run `ruby process.rb`
 * Edit fine-tuning data.
 * When you are done with fine tuning, you can write `quit` in the text editor to finish editing.
